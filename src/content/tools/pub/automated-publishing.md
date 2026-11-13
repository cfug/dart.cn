---
# title: Automated publishing of packages to pub.dev
title: 自动把 package 发布到 pub.dev
# shortTitle: Automated publishing
shortTitle: 自动发布
# description: Publish Dart packages to pub.dev directly from GitHub Actions.
description: 直接从 GitHub Actions 把 Dart package 发布到 pub.dev。
ai-translated: true
---

You can automate publishing from:
* [GitHub Actions](https://github.com/features/actions),

  [GitHub Actions](https://github.com/features/actions)，

* [Google Cloud Build][9] or,

  [Google Cloud Build][9]，或者

* Anywhere else using a [GCP service account][2].

  使用 [GCP 服务账号][2] 的任何其他地方。

你可以从这些地方自动发布：

The following sections explain how automated publishing is configured, and
how you can customize publishing flows in line with your preferences.

下面各节说明如何配置自动发布，以及如何按你的偏好定制发布流程。

When configuring automated publishing you don't need to create a long-lived
secret that is copied into your automated deployment environment.
Instead, authentication relies on temporary OpenID-Connect tokens signed by
either GitHub Actions (See [OIDC for GitHub Actions][1]) or Google Cloud IAM.

配置自动发布时，你不需要创建一份复制到自动部署环境中的长期密钥。
身份验证依赖由 GitHub Actions（参见 [适用于 GitHub Actions 的 OIDC][1]）
或 Google Cloud IAM 签名的临时 OpenID-Connect 令牌。

You can use _exported service account keys_ for deployment
environments where an identity service isn't present.
Such exported service account keys are long-lived secrets, they might be easier
to use in some environments, but also pose a larger risk if accidentally leaked.

在没有身份服务的部署环境中，你可以使用 **导出的服务账号密钥**。
这类导出的服务账号密钥是长期密钥，在某些环境中可能更好用，
但一旦意外泄漏，风险也更大。

:::note
Today, you can only automate publishing of existing packages.
To create a new package, you must publish the first version using
`dart pub publish`.

目前，你只能自动发布已有的 package。
要创建新 package，必须用 `dart pub publish` 发布第一个版本。
:::

## Publishing packages using GitHub Actions

## 使用 GitHub Actions 发布 package

You can configure automated publishing using GitHub Actions. This involves:

你可以用 GitHub Actions 配置自动发布。这包括：

* Enabling automated publishing on pub.dev, specifying:

  在 pub.dev 上启用自动发布，并指定：

  * The GitHub repository and,

    GitHub 仓库，以及

  * A _tag-pattern_ that must match to allow publishing.

    一个必须匹配才允许发布的 **标签模式**。

* Creating a GitHub Actions _workflow_ for publishing to pub.dev.

  创建用于发布到 pub.dev 的 GitHub Actions **工作流**。

* Pushing a _git tag_ for the version to be published.

  为要发布的版本推送一个 **git 标签**。

The following sections outline how to complete these steps.

下面各节概述如何完成这些步骤。

:::note
Pub.dev only allows automated publishing from GitHub Actions when the
_workflow_ is triggered by pushing a git tag to GitHub.
Pub.dev rejects publishing from GitHub Actions triggered without a tag.
This ensures that new versions cannot be published by events that should
never trigger publishing.

只有当 **工作流** 是由向 GitHub 推送 git 标签触发时，
pub.dev 才允许从 GitHub Actions 自动发布。
pub.dev 会拒绝没有标签触发的 GitHub Actions 发布。
这样可以确保本不该触发发布的事件无法发布新版本。
:::

### Configuring automated publishing from GitHub Actions on pub.dev

### 在 pub.dev 上配置从 GitHub Actions 自动发布

To enable automated publication from GitHub Actions to `pub.dev`, you must be:

要从 GitHub Actions 向 `pub.dev` 启用自动发布，你必须是：

* An _uploader_ on the package, or,

  该 package 的 **上传者**，或者

* An _admin_ of the publisher (if the package is owned by a publisher).

  发布者的 **管理员**（如果 package 归某个发布者所有）。

If you have sufficient permission, you can enable automated publishing by:

如果权限足够，可以按下面的步骤启用自动发布：

1. Navigating to the **Admin** tab (`pub.dev/packages/<package>/admin`).

   打开 **Admin** 标签页（`pub.dev/packages/<package>/admin`）。

1. Find the **Automated publishing** section.

   找到 **Automated publishing** 部分。

1. Click **Enable publishing from GitHub Actions**, this prompts you to
   specify:

   点击 **Enable publishing from GitHub Actions**，系统会提示你指定：

   * A repository (`<organization>/<repository>`, example: `dart-lang/pana`),

     一个仓库（`<organization>/<repository>`，例如 `dart-lang/pana`），

   * A _tag-pattern_ (a string containing `{% raw %}{{version}}{% endraw %}`).

     一个 **标签模式**（包含 `{% raw %}{{version}}{% endraw %}` 的字符串）。

The _repository_ is the `<organization>/<repository>` on GitHub.
For example, if your repository is
`{{site.repo.dart.org}}/pana` you must specify `dart-lang/pana` in the
repository field.

**仓库** 是 GitHub 上的 `<organization>/<repository>`。
例如，如果你的仓库是 `{{site.repo.dart.org}}/pana`，
必须在仓库字段中填写 `dart-lang/pana`。

The _tag pattern_ is a string that must contain `{% raw %}{{version}}{% endraw %}`.
Only GitHub Actions triggered by a push of a tag that matches this
_tag pattern_ will be allowed to publish your package.

**标签模式** 是一个必须包含 `{% raw %}{{version}}{% endraw %}` 的字符串。
只有由推送与该 **标签模式** 匹配的标签所触发的 GitHub Actions，才被允许发布你的 package。

![Configuration of publishing from GitHub Actions on pub.dev](/assets/img/tools/pub/pub-dev-gh-setup.png)

**Example:** a _tag pattern_ like `v{% raw %}{{version}}{% endraw %}` allows
GitHub Actions (triggered by `git tag v1.2.3 && git push v1.2.3`) to publish
version `1.2.3` of your package. Thus, it's also important that the `version` key in
`pubspec.yaml` matches this version number.

**示例：** 像 `v{% raw %}{{version}}{% endraw %}` 这样的 **标签模式**，
允许 GitHub Actions（由 `git tag v1.2.3 && git push v1.2.3` 触发）
发布你的 package 的 `1.2.3` 版本。
因此，`pubspec.yaml` 中的 `version` 键与这个版本号一致也很重要。

If your repository contains multiple packages, give each a separate
_tag-pattern_. Consider using a _tag-pattern_ like
`my_package_name-v{% raw %}{{version}}{% endraw %}` for a package
named `my_package_name`.

如果仓库包含多个 package，请为每个 package 单独设置 **标签模式**。
对于名为 `my_package_name` 的 package，可以考虑使用
`my_package_name-v{% raw %}{{version}}{% endraw %}` 这样的 **标签模式**。

### Configuring a GitHub Action workflow for publishing to pub.dev

### 配置用于发布到 pub.dev 的 GitHub Action 工作流

When automated publishing from GitHub Actions is enabled on pub.dev,
you can create a GitHub Actions workflow for publishing. This is done by
creating a `.github/workflows/publish.yml` file as follows:

在 pub.dev 上启用从 GitHub Actions 自动发布之后，
你可以创建用于发布的 GitHub Actions 工作流。
做法是按下面这样创建 `.github/workflows/publish.yml` 文件：

```yaml
# .github/workflows/publish.yml
name: Publish to pub.dev

on:
  push:
    tags:
    # must align with the tag-pattern configured on pub.dev, often just replace
      # {% raw %}{{version}}{% endraw %} with [0-9]+.[0-9]+.[0-9]+
    - 'v[0-9]+.[0-9]+.[0-9]+' # tag-pattern on pub.dev: 'v{% raw %}{{version}}{% endraw %}'
    # If you prefer tags like '1.2.3', without the 'v' prefix, then use:
    # - '[0-9]+.[0-9]+.[0-9]+' # tag-pattern on pub.dev: '{% raw %}{{version}}{% endraw %}'
    # If your repository contains multiple packages consider a pattern like:
    # - 'my_package_name-v[0-9]+.[0-9]+.[0-9]+'

# Publish using the reusable workflow from dart-lang.
jobs:
  publish:
    permissions:
      id-token: write # Required for authentication using OIDC
    uses: dart-lang/setup-dart/.github/workflows/publish.yml@v1
    # with:
    #   working-directory: path/to/package/within/repository
```

Make sure to match the pattern in `on.push.tags` with the _tag pattern_
specified on pub.dev. Otherwise, the GitHub Action workflow won't work.
If publishing multiple packages from the same repository, 
use a per-package _tag pattern_ like 
`my_package_name-v{% raw %}{{version}}{% endraw %}` and
create a separate workflow file for each package.

请确保 `on.push.tags` 中的模式与 pub.dev 上指定的 **标签模式** 一致。
否则 GitHub Action 工作流不会工作。
如果从同一个仓库发布多个 package，请为每个 package 使用单独的 **标签模式**，
例如 `my_package_name-v{% raw %}{{version}}{% endraw %}`，
并为每个 package 创建单独的工作流文件。

The workflow file above uses
`dart-lang/setup-dart/.github/workflows/publish.yml` to publish the package.
This is a [reusable workflow][3] that allows the Dart team to maintain
the publishing logic and enables pub.dev to know how the package was published.
Using this _reusable workflow_ is strongly encouraged.

上面的工作流文件使用 `dart-lang/setup-dart/.github/workflows/publish.yml`
来发布 package。这是一个 [可复用工作流][3]，
让 Dart 团队可以维护发布逻辑，也让 pub.dev 知道 package 是如何发布的。
强烈建议使用这个 **可复用工作流**。

If you need generated code in your package, then it is preferable to check this
generated code into your repository.
This simplifies verifying that the files published on pub.dev match
the files from your repository. If checking generated or built artifact into
your repository is not reasonable, you can create a custom workflow along
the lines of:

如果你的 package 需要生成的代码，最好把这些生成的代码签入仓库。
这样更容易验证发布到 pub.dev 的文件与仓库中的文件一致。
如果把生成或构建产物签入仓库并不合理，你可以按类似下面的方式创建自定义工作流：

```yaml
# .github/workflows/publish.yml
name: Publish to pub.dev

on:
  push:
    tags:
    - 'v[0-9]+.[0-9]+.[0-9]+' # tag pattern on pub.dev: 'v{% raw %}{{version}{% endraw %}'

# Publish using custom workflow
jobs:
  publish:
    permissions:
      id-token: write # Required for authentication using OIDC
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: dart-lang/setup-dart@v1
      - name: Install dependencies
        run: dart pub get
      # Here you can insert custom steps you need
      # - run: dart tool/generate-code.dart
      - name: Publish
        run: dart pub publish --force
```

The workflow authenticates to `pub.dev` using a temporary
[GitHub-signed OIDC token][1], the token is created and configured in the
`dart-lang/setup-dart` step.
To publish to pub.dev, subsequent steps can run `dart pub publish --force`.

工作流使用临时的 [GitHub 签名的 OIDC 令牌][1] 向 `pub.dev` 进行身份验证，
该令牌在 `dart-lang/setup-dart` 步骤中创建并配置。
要发布到 pub.dev，后续步骤可以运行 `dart pub publish --force`。

:::note
At this point, anyone with push access to your repository can publish new versions
of the package. Consider using [tag protection rules][sec-gh-tag-protection] or
[GitHub deployment Environments][sec-gh-environment] to limit who can publish.

到这一步，任何对你的仓库有推送权限的人都可以发布 package 的新版本。
可以考虑使用 [标签保护规则][sec-gh-tag-protection] 或
[GitHub 部署环境][sec-gh-environment] 来限制谁可以发布。
:::

[sec-gh-tag-protection]: #hardening-security-with-tag-protection-rules-on-github
[sec-gh-environment]: #hardening-security-with-github-deployment-environments

### Triggering automated publishing from GitHub Actions

### 从 GitHub Actions 触发自动发布

After you've configured automated publishing on `pub.dev` and created a
GitHub Actions workflow, you can publish a new version of your package.
To publish, push a _git tag_ matching the configured _tag pattern_.

在 `pub.dev` 上配置好自动发布并创建 GitHub Actions 工作流之后，
你就可以发布 package 的新版本。
要发布，请推送一个与所配置的 **标签模式** 匹配的 **git 标签**。

```console
$ cat pubspec.yaml
```

```yaml
package: my_package_name
version: 1.2.3            # must match the version number used in the git tag
environment:
  sdk: ^2.19.0
```

```console
$ git tag v1.2.3          # assuming my tag pattern is: 'v{% raw %}{{version}}{% endraw %}'
$ git push origin v1.2.3  # triggers the action that publishes my package.
```

Once pushed, review the workflow logs at
`https://github.com/<organization>/<repository>/actions`.

推送之后，请在 `https://github.com/<organization>/<repository>/actions`
查看工作流日志。

If the Action didn't trigger, check that the pattern configured in
`.github/workflows/publish.yml` matches the pushed _git tag_.
If the Action failed, the logs might contain clues as to why it failed.

如果 Action 没有触发，请检查 `.github/workflows/publish.yml` 中配置的模式
是否与推送的 **git 标签** 匹配。
如果 Action 失败了，日志里可能有失败原因的线索。

Once published, you can see the publication event in the `audit-log` on
`pub.dev`.
The `audit-log` entry should contain a link to the GitHub Action run that
published the package version.

发布之后，你可以在 `pub.dev` 的 `audit-log` 中看到这次发布事件。
`audit-log` 条目应包含发布该 package 版本的 GitHub Action 运行的链接。

![Audit log after publishing from GitHub Actions](/assets/img/tools/pub/audit-log-pub-gh.png)

If you don't like using the `git` CLI to create tags, you can create _releases_
on GitHub from `https://github.com/<organization>/<repository>/releases/new`.
To learn more, check out [managing releases in a repository][4] from GitHub.

如果你不想用 `git` CLI 创建标签，可以在
`https://github.com/<organization>/<repository>/releases/new`
上创建 GitHub **发布**。
要了解更多，请参阅 GitHub 的 [管理仓库中的发布][4]。

### Hardening security with tag protection rules on GitHub

### 用 GitHub 上的标签保护规则加强安全

Configuring automated publishing from GitHub Actions allows anyone who can push
a tag to your repository to trigger publishing to pub.dev.
You can restrict who can push tags to your repository using
[tag protection rules][5] on GitHub.

配置从 GitHub Actions 自动发布之后，任何能向你的仓库推送标签的人
都可以触发向 pub.dev 的发布。
你可以用 GitHub 上的 [标签保护规则][5] 限制谁可以向仓库推送标签。

By limiting who can create tags matching your _tag pattern_, you can limit who
can publish the package.

通过限制谁能创建与你的 **标签模式** 匹配的标签，你就可以限制谁能发布该 package。

At this time, the [tag protection rules][5] lack flexibility. You might want to
restrict who can trigger publishing using GitHub Deployment Environments,
as outlined in the next section.

目前，[标签保护规则][5] 还不够灵活。你可能想用 GitHub 部署环境来限制谁能触发发布，
如下一节所述。

### Hardening security with GitHub Deployment Environments

### 用 GitHub 部署环境加强安全

When configuring automated publishing from GitHub Actions on pub.dev, you can 
require a [GitHub Actions environment][6].
To require a _GitHub Actions environment_ for publishing you must:

在 pub.dev 上配置从 GitHub Actions 自动发布时，你可以要求使用
[GitHub Actions 环境][6]。
要让发布必须使用 **GitHub Actions 环境**，你必须：

1. Navigate to the **Admin** tab (`pub.dev/packages/<package>/admin`).

   打开 **Admin** 标签页（`pub.dev/packages/<package>/admin`）。

1. Find the **Automated publishing** section.

   找到 **Automated publishing** 部分。

1. Click **Require GitHub Actions environment**.

   点击 **Require GitHub Actions environment**。

1. Specify an **Environment** name, (`pub.dev` is typically a good name)

   指定一个 **Environment** 名称（`pub.dev` 通常是个好名字）

![Configure pub.dev to require a GitHub deployment environment](/assets/img/tools/pub/pub-dev-gh-env-setup.png)

When an environment is required on pub.dev, GitHub Actions won't be able to
publish unless they have `environment: pub.dev`. Thus, you must:

当 pub.dev 要求某个环境时，GitHub Actions 除非带有 `environment: pub.dev`，
否则无法发布。因此你必须：

1. [Create an _environment_][8] with the same name on GitHub
   (typically `pub.dev`)

   在 GitHub 上 [创建一个 **环境**][8]，使用相同的名称（通常是 `pub.dev`）

1. Alter your `.github/workflows/publish.yml` workflow file to specify
   `environment: pub.dev`, as follows:

   修改 `.github/workflows/publish.yml` 工作流文件，按下面这样指定
   `environment: pub.dev`：

```yaml
# .github/workflows/publish.yml
name: Publish to pub.dev

on:
  push:
    tags:
    - 'v[0-9]+.[0-9]+.[0-9]+' # for tags like: 'v1.2.3'

jobs:
  publish:
    permissions:
      id-token: write # Required for authentication using OIDC.
    uses: dart-lang/setup-dart/.github/workflows/publish.yml@v1
    with:
      # Specify the GitHub Action deployment environment.
      environment: pub.dev
      # working-directory: path/to/package/within/repository
```

The _environment_ is reflected in the temporary [GitHub-signed OIDC token][1]
used for authentication with pub.dev. Thus, a user with permission to push to
your repository cannot circumvent [environment protection rules][7] by modifying
the workflow file.

**环境** 会反映在用于向 pub.dev 进行身份验证的临时 [GitHub 签名的 OIDC 令牌][1] 中。
因此，有权向你的仓库推送的用户无法通过修改工作流文件来绕过 [环境保护规则][7]。

In GitHub repository settings, you can use [environment protection rules][7] to
configure _required reviewers_. If you configure this option, GitHub prevents
actions with the environment from running until one of the
_required reviewers_ have approved the run.

在 GitHub 仓库设置中，你可以用 [环境保护规则][7] 配置 **必需的审核者**。
如果配置了这个选项，GitHub 会阻止带有该环境的 action 运行，
直到其中一位 **必需的审核者** 批准这次运行。

![GitHub Action waiting for deployment review](/assets/img/tools/pub/gh-pending-review.png)

## Publishing from Google Cloud Build

## 从 Google Cloud Build 发布

You can configure automated publishing from [Google Cloud Build][9]. This
involves:

你可以从 [Google Cloud Build][9] 配置自动发布。这包括：

* Register a Google Cloud Project (or using an existing project),

  注册一个 Google Cloud 项目（或使用已有项目），

* Create a [service account][10] for publishing to pub.dev,

  创建一个用于发布到 pub.dev 的 [服务账号][10]，

* Enable automated publishing in the admin tab for the package on pub.dev,
  specifying the email of the service account created for publishing.

  在 pub.dev 上该 package 的管理标签页中启用自动发布，
  并指定为发布创建的服务账号邮箱。

* Grant the default Cloud Build service account permission to impersonate the
  service account created for publishing.

  授予默认的 Cloud Build 服务账号权限，让它可以模拟为发布创建的服务账号。

* Create a `cloudbuild.yaml` file that obtains a temporary OIDC `id_token`
  and uses it for publishing to pub.dev

  创建 `cloudbuild.yaml` 文件，获取临时的 OIDC `id_token`，并用它发布到 pub.dev

* Configure a Cloud Build trigger, for running the steps in `cloudbuild.yaml`
  in your project on Google Cloud Build.

  配置一个 Cloud Build 触发器，以便在 Google Cloud Build 上的项目中
  运行 `cloudbuild.yaml` 里的步骤。

The following sections outline how to complete these steps.

下面各节概述如何完成这些步骤。

:::note
When you enable automated publishing from a _service account_ you must carefully
review who has the ability to impersonate this service account, either by
calling through APIs, exporting service account keys, or through changing
IAM permission in the cloud project.
To learn more, check out [managing service account impersonation][11].

启用从 **服务账号** 自动发布时，必须仔细审查谁能够模拟这个服务账号，
无论是通过 API 调用、导出服务账号密钥，还是通过更改云项目中的 IAM 权限。
要了解更多，请参阅 [管理服务账号模拟][11]。
:::

### Creating a service account for publishing

### 创建用于发布的服务账号

For publishing to pub.dev you are going to create a _service account_ that is
granted permission to publish your package on pub.dev. You are then going to
grant Cloud Build permission to impersonate this service account.

为了发布到 pub.dev，你将创建一个 **服务账号**，并授予它在 pub.dev 上发布你的 package 的权限。
然后你将授予 Cloud Build 权限来模拟这个服务账号。

1. [Create a cloud project][12], if you don't have an existing project.

   如果还没有项目，请 [创建一个云项目][12]。

1. Create a _service account_ as follows:

   按下面的方式创建一个 **服务账号**：

    ```console
    $ gcloud iam service-accounts create pub-dev \
      --description='Service account to be impersonated when publishing to pub.dev' \
      --display-name='pub-dev'
    ```

    This creates a service account named
    `pub-dev@$PROJECT_ID.iam.gserviceaccount.com`.

    这会创建一个名为 `pub-dev@$PROJECT_ID.iam.gserviceaccount.com` 的服务账号。

1. Grant the service account permission to publish your package.

   授予该服务账号发布你的 package 的权限。

   To complete this step, you must have _uploader_ permission on the package or
   be an _admin_ of the publisher that owns the package.

   要完成这一步，你必须拥有该 package 的 **上传者** 权限，
   或者是拥有该 package 的发布者的 **管理员**。

   a. Navigate to the **Admin** tab (`pub.dev/packages/<package>/admin`).

      打开 **Admin** 标签页（`pub.dev/packages/<package>/admin`）。

   a. Click **Enable publishing with Google Cloud Service account**.

      点击 **Enable publishing with Google Cloud Service account**。

   a. Type the email of the service account into the **Service account email** field.
      You created this account in the previous step:
      `pub-dev@$PROJECT_ID.iam.gserviceaccount.com`

      把服务账号的邮箱填入 **Service account email** 字段。
      你在上一步创建了这个账号：
      `pub-dev@$PROJECT_ID.iam.gserviceaccount.com`

![Configuration that allows service account to publish on pub.dev](/assets/img/tools/pub/pub-dev-gcb-config.png)

With this procedure complete, anyone who can impersonate the service account can
publish new versions of the package. Make sure to review who has permissions to
impersonate the service account and change permissions in the cloud project as
needed.

完成这个流程后，任何能模拟该服务账号的人都可以发布 package 的新版本。
请务必审查谁有权限模拟该服务账号，并按需更改云项目中的权限。

:::note
The _service account_ must be created in the same cloud project where you
intend to run Cloud Build. If you need to impersonate across cloud projects,
refer to [enabling service account impersonation across projects][27].

**服务账号** 必须创建在你打算运行 Cloud Build 的同一个云项目中。
如果需要跨云项目模拟，请参阅 [启用跨项目的服务账号模拟][27]。
:::

### Granting Cloud Build permission to publish

### 授予 Cloud Build 发布权限

To publish from Cloud Build you must give the
[default Cloud Build service account][13] permission to impersonate 
the service account created for publishing in the previous section.

要从 Cloud Build 发布，你必须授予
[默认的 Cloud Build 服务账号][13] 权限，
让它可以模拟上一节中为发布创建的服务账号。

1. Enable the [IAM Service Account Credentials API][14] in the cloud project.
   Attempts to impersonate a service account will fail without this API.

   在云项目中启用 [IAM Service Account Credentials API][14]。
   没有这个 API，模拟服务账号的尝试会失败。

   ```console
   # Enable IAM Service Account Credentials API
   $ gcloud services enable iamcredentials.googleapis.com
   ```

1. Find the project number.

   找到项目编号。

   ```console
   # The PROJECT_NUMBER can be obtained as follows:
   $ gcloud projects describe $PROJECT_ID --format='value(projectNumber)'
   ```

1. Grant the permission to impersonate the publishing service account.

   授予模拟发布服务账号的权限。

   ```console
   # Grant default cloud
   $ gcloud iam service-accounts add-iam-policy-binding \
     pub-dev@$PROJECT_ID.iam.gserviceaccount.com \
     --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
     --role=roles/iam.serviceAccountTokenCreator
   ```

### Writing a Cloud Build configuration file

### 编写 Cloud Build 配置文件

To publish from Cloud Build, you must specify steps for Cloud Build to:

要从 Cloud Build 发布，你必须为 Cloud Build 指定以下步骤：

* Impersonate the service account to obtain a temporary OIDC token.
* Provide the temporary OIDC token to `dart pub` for use when publishing.
* Calling `dart pub publish` to publish the package.

  模拟服务账号以获取临时的 OIDC 令牌。
  把临时的 OIDC 令牌提供给 `dart pub`，供发布时使用。
  调用 `dart pub publish` 发布 package。

Steps for Google Cloud Build are provided in a `cloudbuild.yaml` file, see
[build configuration file schema][15] for full documentation of the format.

Google Cloud Build 的步骤写在 `cloudbuild.yaml` 文件中，
该格式的完整文档参见 [构建配置文件 schema][15]。

For publishing to pub.dev from Google Cloud Build, a `cloudbuild.yaml` file as
follows will do:

要从 Google Cloud Build 发布到 pub.dev，像下面这样的 `cloudbuild.yaml` 文件就可以了：

```yaml
# cloudbuild.yaml
steps:
- id: Create temporary token
  name: gcr.io/cloud-builders/gcloud
  volumes:
  - name: temporary-secrets
    path: /secrets
  script: |
    gcloud auth print-identity-token \
      --impersonate-service-account=pub-dev@$PROJECT_ID.iam.gserviceaccount.com \
      --audiences=https://pub.dev \
      --include-email > /secrets/temporary-pub-token.txt
  env:
  - PROJECT_ID=$PROJECT_ID
- id: Publish to pub.dev
  name: dart
  volumes:
  - name: temporary-secrets
    path: /secrets
  script: | 
    cat /secrets/temporary-pub-token.txt | dart pub token add https://pub.dev
    dart pub publish --force
```

The `gcloud auth print-identity-token` creates an OIDC `id_token` impersonating
the specified service account. This `id_token` is signed by Google, with a
signature that expires within 1 hour. The _audiences_ parameter lets pub.dev
know that it is the intended recipient of the token. The `--include-email`
option is necessary for pub.dev to recognize the service account.

`gcloud auth print-identity-token` 会模拟指定的服务账号，创建一个 OIDC `id_token`。
这个 `id_token` 由 Google 签名，签名在 1 小时内过期。
_audiences_ 参数让 pub.dev 知道它是该令牌的预期接收者。
`--include-email` 选项是 pub.dev 识别服务账号所必需的。

Once the `id_token` is created, it's written to a file that resides in a
_volume_; this mechanism is used to [pass data between steps][16].
Don't store the token in `/workspace`. Since `/workspace` is where the
repository from which you wish to publish is checked out.
Not using `/workspace` for storing the token reduces the risk that you
accidentally include it in your package when publishing.

`id_token` 创建后，会写入位于 **卷（volume）** 中的一个文件；
这个机制用于 [在步骤之间传递数据][16]。
不要把令牌存放在 `/workspace` 中，因为 `/workspace` 是检出你要发布的仓库的地方。
不用 `/workspace` 存放令牌，可以降低发布时意外把它包含进 package 的风险。

### Creating a Cloud Build trigger

### 创建 Cloud Build 触发器

With service accounts configured and a `cloudbuild.yaml` file in the repository
you can create a _Cloud Build Trigger_ using the [console.cloud.google.com][28]
dashboard.
To create a build trigger, you need to connect to a _source repository_
and specify which events should trigger a build. You can use [GitHub][18],
[Cloud Source Repository][19], or one of the [other options][20].
To learn how to configure a _Cloud Build Trigger_, check out
[creating and managing build triggers][21].

配置好服务账号并在仓库中放入 `cloudbuild.yaml` 文件后，
你就可以使用 [console.cloud.google.com][28] 控制台创建一个 **Cloud Build 触发器**。
要创建构建触发器，你需要连接一个 **源代码仓库**，并指定哪些事件应触发构建。
你可以使用 [GitHub][18]、[Cloud Source Repository][19] 或 [其他选项][20] 之一。
要了解如何配置 **Cloud Build 触发器**，请参阅 [创建和管理构建触发器][21]。

To use the `cloudbuild.yaml` from the previous step, configure the
_Cloud Build Trigger_ type as "Cloud Build Configuration" located in the
repository in the `/cloudbuild.yaml` file.
Do **not** specify a _service account_ for the build to be triggered with.
Instead you'll want to use the default service account for Cloud Build.

要使用上一步的 `cloudbuild.yaml`，请把 **Cloud Build 触发器** 的类型配置为
"Cloud Build Configuration"，即位于仓库中 `/cloudbuild.yaml` 文件里的配置。
**不要** 为触发的构建指定 **服务账号**，
而应使用 Cloud Build 的默认服务账号。

![Configuration for trigger](/assets/img/tools/pub/gcb-trigger-configuration.png)

:::note
You can configure the Cloud Build trigger to run under a custom
_service account_. If you want to do this, create a new service
account for this purpose. Allow this service account to impersonate
the `pub-dev@$PROJECT_ID.iam.gserviceaccount.com` account, which can
publish to pub.dev.

你可以把 Cloud Build 触发器配置为在自定义 **服务账号** 下运行。
如果想这样做，请为此创建一个新的服务账号，
并允许这个服务账号模拟可以发布到 pub.dev 的
`pub-dev@$PROJECT_ID.iam.gserviceaccount.com` 账号。

The configuration of the `pub-dev@$PROJECT_ID.iam.gserviceaccount.com`
_service account_ allowed the default Cloud Build service account,
`$PROJECT_NUMBER@cloudbuild.gserviceaccount.com`, to impersonate the 
`pub-dev@$PROJECT_ID.iam.gserviceaccount.com` service account.
If using a custom service account for the Cloud Build, you'll need to change
this.

`pub-dev@$PROJECT_ID.iam.gserviceaccount.com` **服务账号** 的配置，
允许默认的 Cloud Build 服务账号 `$PROJECT_NUMBER@cloudbuild.gserviceaccount.com`
模拟 `pub-dev@$PROJECT_ID.iam.gserviceaccount.com` 服务账号。
如果为 Cloud Build 使用自定义服务账号，你需要更改这一配置。

To learn more about custom service accounts for running Cloud Builds,
check out [Configuring user-specified service accounts][22].

要了解更多关于运行 Cloud Build 的自定义服务账号，
请参阅 [配置用户指定的服务账号][22]。
:::

When configuring your Cloud Build trigger, consider who can trigger the
build. _Because triggering a build might publish a new version of your package_.
Consider only allowing manual builds or use
[Cloud Build approvals][17] to gate builds as outlined in next section.

配置 Cloud Build 触发器时，请考虑谁可以触发构建，
_因为触发构建可能会发布你的 package 的新版本_。
可以考虑只允许手动构建，或使用 [Cloud Build 审批][17] 来把关构建，
如下一节所述。

### Hardening security with Cloud Build Approvals

### 用 Cloud Build 审批加强安全

When configuring a Cloud Build trigger, you can select
**require approval before build executes**. If a Cloud Build trigger
requires approval, it won't run when triggered. Instead, it'll wait for
approval.
This can be used to limit who can publish new versions of your package.

配置 Cloud Build 触发器时，你可以选择 **构建执行前需要审批**。
如果 Cloud Build 触发器需要审批，它在被触发时不会运行，而是等待审批。
这可以用来限制谁能发布你的 package 的新版本。

![Enabling approvals in configuration of the Cloud Build trigger](/assets/img/tools/pub/gcb-approval-checkbox.png)

Only a user with the **Cloud Build Approver** role can give approval.
When giving a approval, the approver can specify a URL and comment.

只有拥有 **Cloud Build Approver** 角色的用户才能给予审批。
审批时，审批者可以指定一个 URL 和评论。

![Cloud Build run waiting for approval to run](/assets/img/tools/pub/gcp-waiting-for-approval.png)

You can also configure notifications for pending approvals.
To learn more, check out [gate build on approval][17].

你还可以为待审批配置通知。
要了解更多，请参阅 [通过审批把关构建][17]。

## Publish from anywhere using a Service Account

## 使用服务账号从任何地方发布

To allow automated publishing outside of GitHub Actions, you might
authenticate using service accounts in way similar to _Cloud Build_.

要在 GitHub Actions 之外进行自动发布，
你可以用类似 **Cloud Build** 的方式，通过服务账号进行身份验证。

This usually involves:

这通常包括：

* [Create a service account for publishing][create-svc],
* Impersonate the publishing service account in one of two ways:
  * Workload Identity Federation
  * Exported Service Account Keys

  [创建一个用于发布的服务账号][create-svc]，
  用以下两种方式之一模拟发布服务账号：
    工作负载身份联合（Workload Identity Federation）
    导出的服务账号密钥（Exported Service Account Keys）

The section for _Cloud Build_ outlined how to
[create a service account for publishing][create-svc].
This should provide a service account, such as
`pub-dev@$PROJECT_ID.iam.gserviceaccount.com`.

**Cloud Build** 一节概述了如何 [创建用于发布的服务账号][create-svc]。
这应该会提供一个服务账号，例如 `pub-dev@$PROJECT_ID.iam.gserviceaccount.com`。

[create-svc]: #creating-a-service-account-for-publishing

### Publish using Workload Identity Federation

### 使用工作负载身份联合发布

When running on a cloud service that supports OIDC or SAML,
you can impersonate a GCP service account using
[Workload Identity Federation][23]. This enables you to
leverage your cloud provider's identity services.

在支持 OIDC 或 SAML 的云服务上运行时，
你可以使用 [工作负载身份联合（Workload Identity Federation）][23] 来模拟 GCP 服务账号。
这样就能利用你的云服务提供商的身份服务。

For example, if deploying on EC2, you can
[configure workload identity federation with AWS][24], allowing
temporary AWS tokens from the EC2 metadata service to impersonate a
service account.
To learn how to configure these flows, check out
[workload identity federation][25].

例如，如果部署在 EC2 上，你可以 [配置与 AWS 的工作负载身份联合][24]，
让来自 EC2 元数据服务的临时 AWS 令牌能够模拟服务账号。
要了解如何配置这些流程，请参阅 [工作负载身份联合][25]。

### Publish using Exported Service Account Keys

### 使用导出的服务账号密钥发布

When running on a custom system without identity services, you
can export service account keys. Exported service account keys allows you to
authenticate as said _service account_.
To learn more, check out how to
[create and manage service account keys][26].

在没有身份服务的自定义系统上运行时，你可以导出服务账号密钥。
导出的服务账号密钥让你能够以该 **服务账号** 的身份进行认证。
要了解更多，请参阅如何 [创建和管理服务账号密钥][26]。

#### Export service account keys

#### 导出服务账号密钥

1. Create exported service account keys for an existing service account.

   为已有的服务账号创建导出的服务账号密钥。

    ```console
    $ gcloud iam service-accounts keys create key-file.json \
      --iam-account=pub-dev@$PROJECT_ID.iam.gserviceaccount.com
    ```

1. Save the `key-file.json` file for later use.

   保存 `key-file.json` 文件以备后用。

:::warning
Treat the `key-file.json` like a password.
Anyone who gains access to it can authenticate as the service account
and publish your package.

请像对待密码一样对待 `key-file.json`。
任何获得它的人都能以该服务账号的身份认证并发布你的 package。
:::

#### Publish packages using exported service account keys

#### 使用导出的服务账号密钥发布 package

To publish a package using exported service account keys:

要使用导出的服务账号密钥发布 package：

1. Setup gcloud to authenticate using `key-file.json` (created in the previous step)

   设置 gcloud，使用 `key-file.json`（上一步创建的）进行身份验证

    ```console
    $ gcloud auth activate-service-account --key-file=key-file.json
    ```

1. Create a temporary token for pub.dev and pass it to
   `dart pub token add https://pub.dev`.
   To impersonate service account, include the `--include-email` option.

   为 pub.dev 创建一个临时令牌，并把它传给 `dart pub token add https://pub.dev`。
   要模拟服务账号，请加上 `--include-email` 选项。

    ```console
    $ gcloud auth print-identity-token \
      --audiences=https://pub.dev \
      | dart pub token add https://pub.dev
    ```

1. Publish using the temporary token.
   Add the `--force` option to skip the `yes/no` prompt.

   使用临时令牌发布。
   加上 `--force` 选项可以跳过 `yes/no` 提示。

    ```console
    $ dart pub publish --force
    ```

:::note
Consider using [Workload Identity Federation][23], if possible. This
avoids long-lived secrets. Relying on Workload Identity Federation
allows you to use short-lived secrets that your cloud provider signs.
Short-lived secrets greatly reduces the security risks if accidentally leaked
in logs or similar ways.

如果可能，请考虑使用 [工作负载身份联合][23]。这样可以避免长期密钥。
依赖工作负载身份联合，你可以使用由云服务提供商签名的短期密钥。
短期密钥即使意外泄漏到日志或类似地方，也能大大降低安全风险。
:::

[1]: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect
[2]: https://cloud.google.com/iam/docs/service-accounts
[3]: https://docs.github.com/en/actions/using-workflows/reusing-workflows#calling-a-reusable-workflow
[4]: https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository
[5]: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/configuring-tag-protection-rules
[6]: https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment
[7]: https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#environment-protection-rules
[8]: https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#creating-an-environment
[9]: https://cloud.google.com/build
[10]: https://cloud.google.com/iam/docs/service-accounts
[11]: https://cloud.google.com/iam/docs/impersonating-service-accounts
[12]: https://cloud.google.com/resource-manager/docs/creating-managing-projects
[13]: https://cloud.google.com/build/docs/cloud-build-service-account
[14]: https://console.cloud.google.com/apis/api/iamcredentials.googleapis.com
[15]: https://cloud.google.com/build/docs/build-config-file-schema
[16]: https://cloud.google.com/build/docs/configuring-builds/pass-data-between-steps
[17]: https://cloud.google.com/build/docs/securing-builds/gate-builds-on-approval
[18]: https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github
[19]: https://cloud.google.com/source-repositories/docs/create-code-repository
[20]: https://cloud.google.com/build/docs/triggers
[21]: https://cloud.google.com/build/docs/automating-builds/create-manage-triggers
[22]: https://cloud.google.com/build/docs/securing-builds/configure-user-specified-service-accounts
[23]: https://cloud.google.com/iam/docs/workload-identity-federation
[24]: https://cloud.google.com/iam/docs/workload-identity-federation-with-other-clouds
[25]: https://cloud.google.com/iam/docs/how-to#workload-identity-federation
[26]: https://cloud.google.com/iam/docs/creating-managing-service-account-keys
[27]: https://cloud.google.com/iam/docs/impersonating-service-accounts#enabling-cross-project
[28]: https://console.cloud.google.com/cloud-build/triggers

