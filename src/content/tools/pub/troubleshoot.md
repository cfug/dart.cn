---
# title: Troubleshooting pub
title: Pub 命令问题排查
# description: Common gotchas you might run into when using pub.
description: 使用 pub 时可能遇到的常见问题。
ai-translated: true
---

## Getting a "403" error when publishing a package {:#pub-publish-403}

## 发布 package 时出现「403」错误

You receive the following error when running `pub publish`:

运行 `pub publish` 时出现如下错误：

```plaintext
HTTP error 403: Forbidden
...
You aren't an uploader for package '<foo>'
```

This problem can occur if one of your accounts was granted permission to
publish a package, but the pub client registers you with another account.

如果某个账号已经获得发布 package 的权限，
但 pub 客户端却用另一个账号登记了你，就会出现这个问题。

You can reset pub's authentication process
by deleting the pub credentials file:

删除 pub 凭据文件，即可重置 pub 的身份验证流程：

#### Linux {:#pub-credentials-linux}

#### Linux 平台

If `$XDG_CONFIG_HOME` is defined:

如果定义了 `$XDG_CONFIG_HOME`：

```console
$ rm $XDG_CONFIG_HOME/dart/pub-credentials.json
```

Otherwise:

否则：

```console
$ rm $HOME/.config/dart/pub-credentials.json
```

#### macOS {:#pub-credentials-mac}

#### macOS 平台

```console
$ rm $HOME/Library/Application Support/dart/pub-credentials.json
```

#### Windows {:#pub-credentials-windows}

#### Windows 平台

If you're using Command Prompt:

如果使用命令提示符：

```cmd
$ del "%APPDATA%\dart\pub-credentials.json"
```

If you're using PowerShell:

如果使用 PowerShell：

```ps
$ Remove-Item -Path "%APPDATA%\dart\pub-credentials.json"
```

:::version-note
In Dart 2.14 or earlier,
you should instead delete the `credentials.json` file
found in the [`PUB_CACHE`][] folder.

在 Dart 2.14 或更早版本中，
应改为删除 [`PUB_CACHE`][] 文件夹中的 `credentials.json` 文件。
:::

[`PUB_CACHE`]: /tools/pub/environment-variables

## Getting an "UnauthorizedAccess" error when publishing a package {:#pub-publish-unauthorized}

## 发布 package 时出现「UnauthorizedAccess」错误

You receive the following error when running `pub publish`:

运行 `pub publish` 时出现如下错误：

```plaintext
UnauthorizedAccess: Unauthorized user: <username> is not allowed to upload versions to package '<foo>'.
```

You will see this message if you are not on the list of people
authorized to publish new versions of a package.
See [Uploaders](/tools/pub/publishing#uploaders).

如果你不在有权发布某个 package 新版本的人员名单中，就会看到这条消息。
请参阅 [上传者](/tools/pub/publishing#uploaders)。

## Pub build fails with HttpException error {:#pub-get-fails}

## Pub build 失败并出现 HttpException 错误

You receive an HttpException error similar to the following when
running `pub build`:

运行 `pub build` 时出现类似下面的 HttpException 错误：

```plaintext
Pub build failed, [1] IsolateSpawnException: 'HttpException: Connection closed while receiving data,
...
library handler failed
...
```

This can happen as a result of some antivirus software, such as the
AVG 2013 Internet security suite. Check the manual for your security
suite to see how to temporarily
disable this feature. For example, see
[How to Disable AVG Components](https://support.avg.com/SupportArticleView?urlName=How-to-disable-AVG).

某些杀毒软件会导致这种情况，例如 AVG 2013 Internet security suite。
请查阅安全套件的手册，了解如何临时关闭该功能。例如参阅
[How to Disable AVG Components](https://support.avg.com/SupportArticleView?urlName=How-to-disable-AVG)。

## Pub get fails from behind a corporate firewall

## 在公司防火墙后 pub get 失败

From the command line, pub honors the `http_proxy` and `https_proxy`
environment variables.
You can set the proxy server environment variable as follows.

在命令行中，pub 会遵循 `http_proxy` 和 `https_proxy` 环境变量。
你可以按下面的方式设置代理服务器环境变量。

On Linux/macOS:

在 Linux/macOS 上：

```console
$ export https_proxy=hostname:port
```

On Windows Command Prompt:

在 Windows 命令提示符中：

```cmd
$ set https_proxy=hostname:port
```

On Windows PowerShell:

在 Windows PowerShell 中：

```ps
$ $Env:https_proxy="hostname:port"
```

If the proxy requires credentials, you can set them as follows.

如果代理需要凭据，可以按下面的方式设置。

On Linux/macOS:

在 Linux/macOS 上：

```console
$ export https_proxy=username:password@hostname:port
```

On Windows Command Prompt:

在 Windows 命令提示符中：

```cmd
$ set https_proxy=username:password@hostname:port
```

On Windows PowerShell:

在 Windows PowerShell 中：

```ps
$ $Env:https_proxy="username:password@hostname:port"
```

## Localhost unreachable after sign-in

## 登录后无法访问 localhost

When you run `dart pub publish` in a container or over an SSH session,
the `localhost` that `dart pub` is listening to might be different from
the `localhost` that's accessible in your browser.
Although you can sign in using the browser,
the browser then complains that `http://localhost:<port>?code=...`
is not reachable.

在容器中或通过 SSH 会话运行 `dart pub publish` 时，
`dart pub` 正在监听的 `localhost` 可能和浏览器能访问的 `localhost` 不是同一个。
虽然你可以在浏览器中登录，
但浏览器随后会提示无法访问 `http://localhost:<port>?code=...`。

Try this workaround, which uses the command line to complete sign-in:

可以试试下面的变通办法，用命令行完成登录：

1. In a terminal window, run `dart pub publish`.

   在一个终端窗口中运行 `dart pub publish`。

2. In the browser window that comes up, sign in. <br>
   The browser is redirected to a _new localhost URL_
   (`http://localhost:<port>?code=...`)
   but complains that the URL isn't reachable.

   在弹出的浏览器窗口中登录。<br>
   浏览器会被重定向到一个 **新的 localhost URL**
   （`http://localhost:<port>?code=...`），
   但提示该 URL 无法访问。

3. Copy the _new localhost URL_  from the browser.

   从浏览器中复制这个 **新的 localhost URL**。

4. In another terminal window in the same container or on the same host
   as the one where `dart pub publish` was called, use the `curl` command to
   complete sign-in using the _new localhost URL_:

   在调用 `dart pub publish` 的同一个容器或同一台主机上，
   另开一个终端窗口，用 `curl` 命令和这个 **新的 localhost URL** 完成登录：

   ```console
   $ curl 'http://localhost:<port>?code=...'
   ```

## Getting a socket error trying to find a package {:#pub-get-socket-error}

## 查找 package 时出现套接字错误

The following error might occur if
you have no internet access, your ISP is blocking `pub.dev`,
or security software is blocking internet access from `dart`.

如果没有网络连接、ISP 屏蔽了 `pub.dev`，
或者安全软件阻止了 `dart` 访问互联网，可能会出现下面的错误。

```plaintext
Got socket error trying to find package ... at https://pub.dev.
pub get failed (server unavailable) -- attempting retry 1 in 1 second...
```

Check your internet connection, and
verify that you don't have a firewall or other security software
that blocks internet access from `dart`.

请检查网络连接，并确认没有防火墙或其他安全软件阻止 `dart` 访问互联网。

<details>
 <summary>
   <b>Detailed instructions for Kaspersky Internet Security</b>

   <b>Kaspersky Internet Security 的详细步骤</b>
  </summary>

   When you have turned off _Kaspersky Internet Security_ protection
   from the menu bar,
   the VPN application filter `sysextctrld`
   still runs in the background.
   This filter causes a failure to connect to `pub.dev`.
   To resolve this issue, 
   add both `https://pub.dev` and `https://pub.dartlang.org`
   to the trusted zone:

   当你从菜单栏关闭 **Kaspersky Internet Security** 防护后，
   VPN 应用过滤器 `sysextctrld` 仍会在后台运行。
   这个过滤器会导致无法连接 `pub.dev`。
   要解决这个问题，请把 `https://pub.dev` 和 `https://pub.dartlang.org`
   都加入受信任区域：

   1. Open Kaspersky Internet Security.

      打开 Kaspersky Internet Security。

   2. Click the **Privacy** icon.

      点击 **Privacy** 图标。

   3. Under the **Block website tracking** section, click the **Preferences** button.

      在 **Block website tracking** 部分，点击 **Preferences** 按钮。

   4. In the top icon bar, select **Threats**.

      在顶部图标栏中选择 **Threats**。

   5. Under **Threats**, click **Trusted Zone**.

      在 **Threats** 下点击 **Trusted Zone**。

   6. Select the **Trusted web addresses** tab.

      选择 **Trusted web addresses** 标签页。

   7. Click the **+** button, and add the URL `https://pub.dev`.

      点击 **+** 按钮，添加 URL `https://pub.dev`。

   8. Click **OK**.

      点击 **OK**。

   9. Repeat the previous two steps for `https://pub.dartlang.org`

      对 `https://pub.dartlang.org` 重复前两个步骤。

</details>
