---
# title: dart pub token
title: dart pub token 命令
# description: Manage authentication tokens for package repositories.
description: 管理 package 仓库的身份验证令牌。
ai-translated: true
---

The `dart pub token` subcommand manages a store of tokens.
When [publishing](pub-lish) packages and [retrieving](pub-get) dependencies,
the `dart pub` command uses tokens to authenticate against third-party servers.

`dart pub token` 子命令用来管理一组令牌。
在 [发布](pub-lish) package 和 [获取](pub-get) 依赖时，
`dart pub` 命令会使用这些令牌向第三方服务器进行身份验证。

It stores these tokens in a [user-wide config directory][config-dir].
The `dart pub token` subcommand has three subcommands:
[`add`][], [`list`][] and [`remove`][].

这些令牌保存在 [用户级配置目录][config-dir] 中。
`dart pub token` 子命令包含三个子命令：
[`add`][]、[`list`][] 和 [`remove`][]。

The `dart pub` command considers the terms _credential_, _token_, _secret_,
and _secret token_ to be interchangeable.

`dart pub` 命令把 **credential**、**token**、**secret**
和 **secret token** 这几个说法视为可以互换。

[`add`]: #add-a-new-credential
[`list`]: #return-a-list-of-credentials
[`remove`]: #remove-one-or-more-credentials

## Use case for credentials

## 凭据的使用场景

Consider a scenario when you have a [dependency](/tools/pub/dependencies)
hosted on a private repository.
When you use the `dart pub get` command, it _might_ return a prompt
to provide credentials:

假设你有一项托管在私有仓库上的 [依赖](/tools/pub/dependencies)。
使用 `dart pub get` 命令时，它 **有可能** 提示你提供凭据：

```console
$ dart pub get
Resolving dependencies... 
https://some-package-repo.com/my-org/my-repo package repository requested authentication!
You can provide credentials using:
    dart pub token add https://some-package-repo.com/my-org/my-repo
```

Some, but not all, servers also return a message with instructions as
to how you can obtain a token.

有些服务器（并非全部）还会返回一段说明，告诉你如何获取令牌。

## Add a new credential

## 添加新凭据

To create a new credential,
use the `dart pub token add` command.

要创建新凭据，请使用 `dart pub token add` 命令。

### Add a credential for the current session

### 为当前会话添加凭据

At the prompt, type the credential on the command line (`stdin`).

在提示符处，从命令行（`stdin`）输入凭据。

```console
$ dart pub token add https://some-package-repo.com/my-org/my-repo
Enter secret token: <Type token on stdin>
 Requests to "https://some-package-repo.com/my-org/my-repo" will now be 
 authenticated using the secret token.
```

:::note
To keep the token out of the shell history,
the `dart pub token` command takes input on `stdin` rather than
as a command line option.

为了不让令牌进入 shell 历史记录，
`dart pub token` 命令从 `stdin` 读取输入，
而不是把它当作命令行选项。
:::

### Add a credential for all sessions

### 为所有会话添加凭据

To use the same token for any and all terminal sessions and in scripts,
store the token in an environment variable.

要在所有终端会话和脚本中使用同一个令牌，
请把令牌保存在环境变量里。

1. Store your token in an environment variable.

   把令牌保存在环境变量中。

   Make sure to hide the token from your shell history.
   To explore one way of doing this, consult [this post on Medium][zsh-post].

   务必让令牌不要进入 shell 历史记录。
   可以参考 [这篇 Medium 文章][zsh-post]，了解其中一种做法。

1. To enable any environment variables that you add,
   restart any open consoles.

   要让新添加的环境变量生效，请重新打开已经打开的控制台。

1. To use an environment variable as a token,
   use the `dart pub token add` command:

   要把环境变量用作令牌，请使用 `dart pub token add` 命令：

   ```console
   $ dart pub token add <hosted-url> --env-var <TOKEN_VAR>
   ```

   This command reads the token stored in `$TOKEN_VAR`
   then uses it to authenticate with the `hosted-url`
   hosting the desired package.
   It should print the following response to the terminal.

   这个命令会读取保存在 `$TOKEN_VAR` 中的令牌，
   然后用它向托管目标 package 的 `hosted-url` 进行身份验证。
   终端上应打印如下响应。

   ```console
   $ dart pub token add https://other-package-repo.com/ --env-var TOKEN_VAR
   Requests to "https://other-package-repo.com/" will now be authenticated using the secret token stored in the environment variable "TOKEN_VAR".
   ```

Most CI environments can inject tokens into an environment variable.
To learn how, consult documentation for [GitHub Actions][] or
[GitLab][] as examples.

大多数 CI 环境都可以把令牌注入环境变量。
具体做法可以参考 [GitHub Actions][] 或 [GitLab][] 的文档。

[GitHub Actions]: https://docs.github.com/actions/security-guides/encrypted-secrets#using-encrypted-secrets-in-a-workflow
[GitLab]: https://docs.gitlab.com/ee/ci/secrets/
[zsh-post]: https://medium.com/@prasincs/hiding-secret-keys-from-shell-history-part-1-5875eb5556cc

## Return a list of credentials

## 返回凭据列表

To see a list of all active credentials, use the `dart pub token list` command:

要查看所有生效中的凭据，请使用 `dart pub token list` 命令：

```console
$ dart pub token list
You have secret tokens for 2 package repositories:
https://some-package-repo.com/my-org/my-repo
https://other-package-repo.com/
```

## Remove one or more credentials

## 移除一个或多个凭据

To remove a single token, use the `dart pub token remove` command:

要移除单个令牌，请使用 `dart pub token remove` 命令：

```console
$ dart pub token remove https://other-package-repo.com
Removed secret token for package repository: https://other-package-repo.com
```

To remove all tokens, use the preceding command with the `remove --all` option:

要移除全部令牌，请在前面的命令上加上 `remove --all` 选项：

```console
$ dart pub token remove --all
pub-tokens.json is deleted.
Removed 1 secret tokens.
```

{% render 'pub-problems.md' %}

[config-dir]: {{site.repo.dart.org}}/cli_util/blob/71ba36e2554f7b7717f3f12b5ddd33751a4e3ddd/lib/cli_util.dart#L88-L118
