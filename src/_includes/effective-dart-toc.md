{% comment %}
This file is generated from the other files in this directory.
To re-generate it, please run the following command from root of
the project:

```
dart run dash_site effective-dart
```
{% endcomment %}

<div class="side-by-side"><div>

### Style

### 代码风格


**Identifiers**

**标识符**

* <a href='/effective-dart/style#do-name-types-using-uppercamelcase'>DO name types using <code>UpperCamelCase</code>.</a>

  <a href='/effective-dart/style#do-name-types-using-uppercamelcase'><strong>要</strong> 使用 <code>UpperCamelCase</code> 风格命名类型。</a>
* <a href='/effective-dart/style#do-name-extensions-using-uppercamelcase'>DO name extensions using <code>UpperCamelCase</code>.</a>

  <a href='/effective-dart/style#do-name-extensions-using-uppercamelcase'><strong>要</strong> 使用 <code>UpperCamelCase</code> 命名扩展。</a>
* <a href='/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores'>DO name packages, directories, and source files using <code>lowercase_with_underscores</code>.</a>

  <a href='/effective-dart/style#do-name-packages-and-file-system-entities-using-lowercase-with-underscores'><strong>要</strong> 在库、package、文件夹和源文件中使用 <code>lowercase_with_underscores</code> 方式命名。</a>
* <a href='/effective-dart/style#do-name-import-prefixes-using-lowercase_with_underscores'>DO name import prefixes using <code>lowercase_with_underscores</code>.</a>

  <a href='/effective-dart/style#do-name-import-prefixes-using-lowercase_with_underscores'><strong>要</strong> 用 <code>lowercase_with_underscores</code> 风格命名导入前缀。</a>
* <a href='/effective-dart/style#do-name-other-identifiers-using-lowercamelcase'>DO name other identifiers using <code>lowerCamelCase</code>.</a>

  <a href='/effective-dart/style#do-name-other-identifiers-using-lowercamelcase'><strong>要</strong> 使用 <code>lowerCamelCase</code> 风格来命名其他的标识符。</a>
* <a href='/effective-dart/style#prefer-using-lowercamelcase-for-constant-names'>PREFER using <code>lowerCamelCase</code> for constant names.</a>

  <a href='/effective-dart/style#prefer-using-lowercamelcase-for-constant-names'><strong>推荐</strong> 使用 <code>lowerCamelCase</code> 来命名常量。</a>
* <a href='/effective-dart/style#do-capitalize-acronyms-and-abbreviations-longer-than-two-letters-like-words'>DO capitalize acronyms and abbreviations longer than two letters like words.</a>

  <a href='/effective-dart/style#do-capitalize-acronyms-and-abbreviations-longer-than-two-letters-like-words'><strong>要</strong> 把超过两个字母的首字母缩写词和缩略词当作普通单词来大写。</a>
* <a href='/effective-dart/style#prefer-using-wildcards-for-unused-callback-parameters'>PREFER using wildcards for unused callback parameters.</a>

  <a href='/effective-dart/style#prefer-using-wildcards-for-unused-callback-parameters'><strong>推荐</strong> 为未使用的回调参数使用通配符。</a>
* <a href='/effective-dart/style#dont-use-a-leading-underscore-for-identifiers-that-arent-private'>DON'T use a leading underscore for identifiers that aren't private.</a>

  <a href='/effective-dart/style#dont-use-a-leading-underscore-for-identifiers-that-arent-private'><strong>不要</strong> 为非私有标识符使用前导下划线。</a>
* <a href='/effective-dart/style#dont-use-prefix-letters'>DON'T use prefix letters.</a>

  <a href='/effective-dart/style#dont-use-prefix-letters'><strong>不要</strong>使用前缀字母。</a>
* <a href='/effective-dart/style#dont-explicitly-name-libraries'>DON'T explicitly name libraries.</a>

  <a href='/effective-dart/style#dont-explicitly-name-libraries'><strong>不要</strong> 显式地为库命名。</a>

**Ordering**

**顺序**

* <a href='/effective-dart/style#do-place-dart-imports-before-other-imports'>DO place <code>dart:</code> imports before other imports.</a>

  <a href='/effective-dart/style#do-place-dart-imports-before-other-imports'><strong>要</strong> 把 "dart:" 导入语句放到其他导入语句之前。</a>
* <a href='/effective-dart/style#do-place-package-imports-before-relative-imports'>DO place <code>package:</code> imports before relative imports.</a>

  <a href='/effective-dart/style#do-place-package-imports-before-relative-imports'><strong>要</strong> 把 "package:" 导入语句放到项目相关导入语句之前。</a>
* <a href='/effective-dart/style#do-specify-exports-in-a-separate-section-after-all-imports'>DO specify exports in a separate section after all imports.</a>

  <a href='/effective-dart/style#do-specify-exports-in-a-separate-section-after-all-imports'><strong>要</strong> 把导出 (export) 语句作为一个单独的部分放到所有导入语句之后。</a>
* <a href='/effective-dart/style#do-sort-sections-alphabetically'>DO sort sections alphabetically.</a>

  <a href='/effective-dart/style#do-sort-sections-alphabetically'><strong>要</strong> 按照字母顺序来排序每个部分中的语句。</a>

**Formatting**

**格式化**

* <a href='/effective-dart/style#do-format-your-code-using-dart-format'>DO format your code using <code>dart format</code>.</a>

  <a href='/effective-dart/style#do-format-your-code-using-dart-format'><strong>要</strong> 使用 <code>dart format</code> 格式化你的代码。</a>
* <a href='/effective-dart/style#consider-changing-your-code-to-make-it-more-formatter-friendly'>CONSIDER changing your code to make it more formatter-friendly.</a>

  <a href='/effective-dart/style#consider-changing-your-code-to-make-it-more-formatter-friendly'><strong>考虑</strong> 修改你的代码让格式更友好。</a>
* <a href='/effective-dart/style#prefer-lines-80-characters-or-fewer'>PREFER lines 80 characters or fewer.</a>

  <a href='/effective-dart/style#prefer-lines-80-characters-or-fewer'><strong>推荐</strong> 单行少于 80 个字符。</a>
* <a href='/effective-dart/style#do-use-curly-braces-for-all-flow-control-statements'>DO use curly braces for all flow control statements.</a>

  <a href='/effective-dart/style#do-use-curly-braces-for-all-flow-control-statements'><strong>要</strong> 对所有流控制结构使用花括号。</a>

</div>
<div>


### Documentation

### 文档


**Comments**

**注释**

* <a href='/effective-dart/documentation#do-format-comments-like-sentences'>DO format comments like sentences.</a>

  <a href='/effective-dart/documentation#do-format-comments-like-sentences'><strong>要</strong> 像句子一样来格式化注释。</a>
* <a href='/effective-dart/documentation#dont-use-block-comments-for-documentation'>DON'T use block comments for documentation.</a>

  <a href='/effective-dart/documentation#dont-use-block-comments-for-documentation'><strong>不要</strong> 使用块注释作用作解释说明。</a>

**Doc comments**

**文档注释**

* <a href='/effective-dart/documentation#do-use-doc-comments-to-document-members-and-types'>DO use <code>///</code> doc comments to document members and types.</a>

  <a href='/effective-dart/documentation#do-use-doc-comments-to-document-members-and-types'><strong>要</strong> 使用 <code>///</code> 文档注释来注释成员和类型。</a>
* <a href='/effective-dart/documentation#prefer-writing-doc-comments-for-public-apis'>PREFER writing doc comments for public APIs.</a>

  <a href='/effective-dart/documentation#prefer-writing-doc-comments-for-public-apis'><strong>推荐</strong> 为公开发布的 API 编写文档注释。</a>
* <a href='/effective-dart/documentation#consider-writing-a-library-level-doc-comment'>CONSIDER writing a library-level doc comment.</a>

  <a href='/effective-dart/documentation#consider-writing-a-library-level-doc-comment'><strong>考虑</strong> 编写库级别（library-level）的文档注释。</a>
* <a href='/effective-dart/documentation#consider-writing-doc-comments-for-private-apis'>CONSIDER writing doc comments for private APIs.</a>

  <a href='/effective-dart/documentation#consider-writing-doc-comments-for-private-apis'><strong>推荐</strong> 为私有API 编写文档注释。</a>
* <a href='/effective-dart/documentation#do-start-doc-comments-with-a-single-sentence-summary'>DO start doc comments with a single-sentence summary.</a>

  <a href='/effective-dart/documentation#do-start-doc-comments-with-a-single-sentence-summary'><strong>要</strong> 要在文档注释开头有一个单句总结。</a>
* <a href='/effective-dart/documentation#do-separate-the-first-sentence-of-a-doc-comment-into-its-own-paragraph'>DO separate the first sentence of a doc comment into its own paragraph.</a>

  <a href='/effective-dart/documentation#do-separate-the-first-sentence-of-a-doc-comment-into-its-own-paragraph'><strong>要</strong> 让文档注释的第一句从段落中分开。</a>
* <a href='/effective-dart/documentation#avoid-redundancy-with-the-surrounding-context'>AVOID redundancy with the surrounding context.</a>

  <a href='/effective-dart/documentation#avoid-redundancy-with-the-surrounding-context'><strong>避免</strong> 与周围上下文冗余。</a>
* <a href='/effective-dart/documentation#prefer-starting-comments-of-a-function-or-method-with-third-person-verbs-if-its-main-purpose-is-a-side-effect'>PREFER starting comments of a function or method with third-person verbs if its main purpose is a side effect.</a>

  <a href='/effective-dart/documentation#prefer-starting-comments-of-a-function-or-method-with-third-person-verbs-if-its-main-purpose-is-a-side-effect'><strong>推荐</strong> 用第三人称来开始函数或者方法的文档注释（如果主要目的是副作用）。</a>
* <a href='/effective-dart/documentation#prefer-starting-a-non-boolean-variable-or-property-comment-with-a-noun-phrase'>PREFER starting a non-boolean variable or property comment with a noun phrase.</a>

  <a href='/effective-dart/documentation#prefer-starting-a-non-boolean-variable-or-property-comment-with-a-noun-phrase'><strong>推荐</strong> 使用名词短语来为非布尔值变量或属性注释。</a>
* <a href='/effective-dart/documentation#prefer-starting-a-boolean-variable-or-property-comment-with-whether-followed-by-a-noun-or-gerund-phrase'>PREFER starting a boolean variable or property comment with &quot;Whether&quot; followed by a noun or gerund phrase.</a>

  <a href='/effective-dart/documentation#prefer-starting-a-boolean-variable-or-property-comment-with-whether-followed-by-a-noun-or-gerund-phrase'><strong>推荐</strong> 以「Whether」开头，后接名词或动名词短语，来注释布尔变量或属性。</a>
* <a href='/effective-dart/documentation#prefer-a-noun-phrase-or-non-imperative-verb-phrase-for-a-function-or-method-if-returning-a-value-is-its-primary-purpose'>PREFER a noun phrase or non-imperative verb phrase for a function or method if returning a value is its primary purpose.</a>

  <a href='/effective-dart/documentation#prefer-a-noun-phrase-or-non-imperative-verb-phrase-for-a-function-or-method-if-returning-a-value-is-its-primary-purpose'><strong>考虑</strong> 使用名词短语或者非命令式动词短语命名返回数据为主要功能的方法或者函数。</a>
* <a href='/effective-dart/documentation#dont-write-documentation-for-both-the-getter-and-setter-of-a-property'>DON'T write documentation for both the getter and setter of a property.</a>

  <a href='/effective-dart/documentation#dont-write-documentation-for-both-the-getter-and-setter-of-a-property'><strong>不要</strong> 同时为属性的 getter 和 setter 编写文档</a>
* <a href='/effective-dart/documentation#prefer-starting-library-or-type-comments-with-noun-phrases'>PREFER starting library or type comments with noun phrases.</a>

  <a href='/effective-dart/documentation#prefer-starting-library-or-type-comments-with-noun-phrases'><strong>推荐</strong> 使用名词短语来开始库和类型注释。</a>
* <a href='/effective-dart/documentation#consider-including-code-samples-in-doc-comments'>CONSIDER including code samples in doc comments.</a>

  <a href='/effective-dart/documentation#consider-including-code-samples-in-doc-comments'><strong>考虑</strong> 在文档注释中添加示例代码。</a>
* <a href='/effective-dart/documentation#do-use-square-brackets-in-doc-comments-to-refer-to-in-scope-identifiers'>DO use square brackets in doc comments to refer to in-scope identifiers.</a>

  <a href='/effective-dart/documentation#do-use-square-brackets-in-doc-comments-to-refer-to-in-scope-identifiers'><strong>要</strong> 使用方括号在文档注释中引用作用域内的标识符</a>
* <a href='/effective-dart/documentation#do-use-prose-to-explain-parameters-return-values-and-exceptions'>DO use prose to explain parameters, return values, and exceptions.</a>

  <a href='/effective-dart/documentation#do-use-prose-to-explain-parameters-return-values-and-exceptions'><strong>要</strong> 使用平白简单的语句来描述参数、返回值以及异常信息。</a>
* <a href='/effective-dart/documentation#do-put-doc-comments-before-metadata-annotations'>DO put doc comments before metadata annotations.</a>

  <a href='/effective-dart/documentation#do-put-doc-comments-before-metadata-annotations'><strong>要</strong> 把注释文档放到注解之前。</a>

**Markdown**

**Markdown 格式**

* <a href='/effective-dart/documentation#avoid-using-markdown-excessively'>AVOID using markdown excessively.</a>

  <a href='/effective-dart/documentation#avoid-using-markdown-excessively'><strong>避免</strong> 过度使用 markdown。</a>
* <a href='/effective-dart/documentation#avoid-using-html-for-formatting'>AVOID using HTML for formatting.</a>

  <a href='/effective-dart/documentation#avoid-using-html-for-formatting'><strong>避免</strong> 使用 HTML 来格式化文字。</a>
* <a href='/effective-dart/documentation#prefer-backtick-fences-for-code-blocks'>PREFER backtick fences for code blocks.</a>

  <a href='/effective-dart/documentation#prefer-backtick-fences-for-code-blocks'><strong>推荐</strong> 使用反引号标注代码。</a>

**Writing**

**如何写注释**

* <a href='/effective-dart/documentation#prefer-brevity'>PREFER brevity.</a>

  <a href='/effective-dart/documentation#prefer-brevity'><strong>推荐</strong> 简洁.</a>
* <a href='/effective-dart/documentation#avoid-abbreviations-and-acronyms-unless-they-are-obvious'>AVOID abbreviations and acronyms unless they are obvious.</a>

  <a href='/effective-dart/documentation#avoid-abbreviations-and-acronyms-unless-they-are-obvious'><strong>避免</strong> 缩写和首字母缩写词，除非很常见。</a>
* <a href='/effective-dart/documentation#prefer-using-this-instead-of-the-to-refer-to-a-members-instance'>PREFER using &quot;this&quot; instead of &quot;the&quot; to refer to a member's instance.</a>

  <a href='/effective-dart/documentation#prefer-using-this-instead-of-the-to-refer-to-a-members-instance'><strong>推荐</strong> 使用 "this" 而不是 "the" 来引用实例成员。</a>

</div>
<div>


### Usage

### 用法


**Libraries**

**库**

* <a href='/effective-dart/usage#do-use-strings-in-part-of-directives'>DO use strings in <code>part of</code> directives.</a>

  <a href='/effective-dart/usage#do-use-strings-in-part-of-directives'><strong>要</strong> 在 <code>part of</code> 中使用字符串</a>
* <a href='/effective-dart/usage#dont-import-libraries-that-are-inside-the-src-directory-of-another-package'>DON'T import libraries that are inside the <code>src</code> directory of another package.</a>

  <a href='/effective-dart/usage#dont-import-libraries-that-are-inside-the-src-directory-of-another-package'><strong>不要</strong> 导入 package 中 <code>src</code> 目录下的库</a>
* <a href='/effective-dart/usage#dont-allow-an-import-path-to-reach-into-or-out-of-lib'>DON'T allow an import path to reach into or out of <code>lib</code>.</a>

  <a href='/effective-dart/usage#dont-allow-an-import-path-to-reach-into-or-out-of-lib'><strong>不要</strong> 让导入路径进出 <code>lib</code> 目录。</a>
* <a href='/effective-dart/usage#prefer-relative-import-paths'>PREFER relative import paths.</a>

  <a href='/effective-dart/usage#prefer-relative-import-paths'><strong>推荐</strong> 使用相对导入路径。</a>

**Null**

**空值**

* <a href='/effective-dart/usage#dont-explicitly-initialize-variables-to-null'>DON'T explicitly initialize variables to <code>null</code>.</a>

  <a href='/effective-dart/usage#dont-explicitly-initialize-variables-to-null'><strong>不要</strong> 把变量显式初始化为 <code>null</code>。</a>
* <a href='/effective-dart/usage#dont-use-an-explicit-default-value-of-null'>DON'T use an explicit default value of <code>null</code>.</a>

  <a href='/effective-dart/usage#dont-use-an-explicit-default-value-of-null'><strong>不要</strong> 使用显式的 <code>null</code> 默认值。</a>
* <a href='/effective-dart/usage#dont-use-true-or-false-in-equality-operations'>DON'T use <code>true</code> or <code>false</code> in equality operations.</a>

  <a href='/effective-dart/usage#dont-use-true-or-false-in-equality-operations'><strong>不要</strong> 在相等判断中使用 <code>true</code> 或 <code>false</code>。</a>
* <a href='/effective-dart/usage#avoid-late-variables-if-you-need-to-check-whether-they-are-initialized'>AVOID <code>late</code> variables if you need to check whether they are initialized.</a>

  <a href='/effective-dart/usage#avoid-late-variables-if-you-need-to-check-whether-they-are-initialized'><strong>避免</strong> 在需要检查是否已初始化时使用 <code>late</code> 变量。</a>
* <a href='/effective-dart/usage#consider-type-promotion-or-null-check-patterns-for-using-nullable-types'>CONSIDER type promotion or null-check patterns for using nullable types.</a>

  <a href='/effective-dart/usage#consider-type-promotion-or-null-check-patterns-for-using-nullable-types'><strong>考虑</strong> 使用类型提升或空检查模式来处理可空类型。</a>

**Strings**

**字符串**

* <a href='/effective-dart/usage#do-use-adjacent-strings-to-concatenate-string-literals'>DO use adjacent strings to concatenate string literals.</a>

  <a href='/effective-dart/usage#do-use-adjacent-strings-to-concatenate-string-literals'><strong>要</strong> 使用相邻字符串的方式连接字面量字符串</a>
* <a href='/effective-dart/usage#prefer-using-interpolation-to-compose-strings-and-values'>PREFER using interpolation to compose strings and values.</a>

  <a href='/effective-dart/usage#prefer-using-interpolation-to-compose-strings-and-values'><strong>推荐</strong> 使用插值的形式来组合字符串和值</a>
* <a href='/effective-dart/usage#avoid-using-curly-braces-in-interpolation-when-not-needed'>AVOID using curly braces in interpolation when not needed.</a>

  <a href='/effective-dart/usage#avoid-using-curly-braces-in-interpolation-when-not-needed'><strong>避免</strong> 在字符串插值中使用不必要的大括号</a>

**Collections**

**集合**

* <a href='/effective-dart/usage#do-use-collection-literals-when-possible'>DO use collection literals when possible.</a>

  <a href='/effective-dart/usage#do-use-collection-literals-when-possible'><strong>要</strong> 尽可能的使用集合字面量</a>
* <a href='/effective-dart/usage#dont-use-length-to-see-if-a-collection-is-empty'>DON'T use <code>.length</code> to see if a collection is empty.</a>

  <a href='/effective-dart/usage#dont-use-length-to-see-if-a-collection-is-empty'><strong>不要</strong> 使用 <code>.length</code> 来判断一个集合是否为空</a>
* <a href='/effective-dart/usage#avoid-using-iterable-foreach-with-a-function-literal'>AVOID using <code>Iterable.forEach()</code> with a function literal.</a>

  <a href='/effective-dart/usage#avoid-using-iterable-foreach-with-a-function-literal'><strong>避免</strong> 在 <code>Iterable.forEach()</code> 中使用字面量函数</a>
* <a href='/effective-dart/usage#dont-use-list-from-unless-you-intend-to-change-the-type-of-the-result'>DON'T use <code>List.from()</code> unless you intend to change the type of the result.</a>

  <a href='/effective-dart/usage#dont-use-list-from-unless-you-intend-to-change-the-type-of-the-result'><strong>不要</strong> 使用 <code>List.from()</code> 除非想修改结果的类型</a>
* <a href='/effective-dart/usage#do-use-wheretype-to-filter-a-collection-by-type'>DO use <code>whereType()</code> to filter a collection by type.</a>

  <a href='/effective-dart/usage#do-use-wheretype-to-filter-a-collection-by-type'><strong>要</strong> 使用 <code>whereType()</code> 按类型过滤集合</a>
* <a href='/effective-dart/usage#dont-use-cast-when-a-nearby-operation-will-do'>DON'T use <code>cast()</code> when a nearby operation will do.</a>

  <a href='/effective-dart/usage#dont-use-cast-when-a-nearby-operation-will-do'><strong>不要</strong> 使用 <code>cast()</code>，如果有更合适的方法</a>
* <a href='/effective-dart/usage#avoid-using-cast'>AVOID using <code>cast()</code>.</a>

  <a href='/effective-dart/usage#avoid-using-cast'><strong>避免</strong> 使用 <code>cast()</code></a>

**Functions**

**函数**

* <a href='/effective-dart/usage#do-use-a-function-declaration-to-bind-a-function-to-a-name'>DO use a function declaration to bind a function to a name.</a>

  <a href='/effective-dart/usage#do-use-a-function-declaration-to-bind-a-function-to-a-name'><strong>要</strong> 使用函数声明的方式为函数绑定名称</a>
* <a href='/effective-dart/usage#dont-create-a-lambda-when-a-tear-off-will-do'>DON'T create a lambda when a tear-off will do.</a>

  <a href='/effective-dart/usage#dont-create-a-lambda-when-a-tear-off-will-do'><strong>不要</strong> 使用 lambda 表达式来替代 tear-off</a>

**Variables**

**变量**

* <a href='/effective-dart/usage#do-follow-a-consistent-rule-for-var-and-final-on-local-variables'>DO follow a consistent rule for <code>var</code> and <code>final</code> on local variables.</a>

  <a href='/effective-dart/usage#do-follow-a-consistent-rule-for-var-and-final-on-local-variables'><strong>要</strong> 对局部变量的 <code>var</code> 和 <code>final</code> 遵循一致的规则。</a>
* <a href='/effective-dart/usage#avoid-storing-what-you-can-calculate'>AVOID storing what you can calculate.</a>

  <a href='/effective-dart/usage#avoid-storing-what-you-can-calculate'><strong>避免</strong> 保存可计算的结果</a>

**Members**

**成员**

* <a href='/effective-dart/usage#dont-wrap-a-field-in-a-getter-and-setter-unnecessarily'>DON'T wrap a field in a getter and setter unnecessarily.</a>

  <a href='/effective-dart/usage#dont-wrap-a-field-in-a-getter-and-setter-unnecessarily'><strong>不要</strong> 为字段创建不必要的 getter 和 setter 方法</a>
* <a href='/effective-dart/usage#prefer-using-a-final-field-to-make-a-read-only-property'>PREFER using a <code>final</code> field to make a read-only property.</a>

  <a href='/effective-dart/usage#prefer-using-a-final-field-to-make-a-read-only-property'><strong>推荐</strong> 使用 <code>final</code> 关键字来创建只读属性</a>
* <a href='/effective-dart/usage#consider-using-for-simple-members'>CONSIDER using <code>=&gt;</code> for simple members.</a>

  <a href='/effective-dart/usage#consider-using-for-simple-members'><strong>考虑</strong> 对简单成员使用 <code>=></code></a>
* <a href='/effective-dart/usage#dont-use-this-when-not-needed-to-avoid-shadowing'>DON'T use <code>this.</code> except to redirect to a named constructor or to avoid shadowing.</a>

  <a href='/effective-dart/usage#dont-use-this-when-not-needed-to-avoid-shadowing'><strong>不要</strong> 使用 <code>this.</code>，在重定向到命名构造函数和避免遮蔽的情况下除外。</a>
* <a href='/effective-dart/usage#do-initialize-fields-at-their-declaration-when-possible'>DO initialize fields at their declaration when possible.</a>

  <a href='/effective-dart/usage#do-initialize-fields-at-their-declaration-when-possible'><strong>要</strong> 尽可能的在定义变量的时候初始化变量值</a>

**Constructors**

**构造函数**

* <a href='/effective-dart/usage#do-use-initializing-formals-when-possible'>DO use initializing formals when possible.</a>

  <a href='/effective-dart/usage#do-use-initializing-formals-when-possible'><strong>要</strong> 尽可能的使用初始化形式</a>
* <a href='/effective-dart/usage#dont-use-late-when-a-constructor-initializer-list-will-do'>DON'T use <code>late</code> when a constructor initializer list will do.</a>

  <a href='/effective-dart/usage#dont-use-late-when-a-constructor-initializer-list-will-do'><strong>不要</strong> 在构造函数初始化列表够用时使用 <code>late</code>。</a>
* <a href='/effective-dart/usage#do-use-instead-of-for-empty-constructor-bodies'>DO use <code>;</code> instead of <code>{}</code> for empty constructor bodies.</a>

  <a href='/effective-dart/usage#do-use-instead-of-for-empty-constructor-bodies'><strong>要</strong> 用 <code>;</code> 来替代空的构造函数体 <code>{}</code></a>
* <a href='/effective-dart/usage#prefer-using-concise-constructor-syntax'>PREFER using concise constructor syntax.</a>

  <a href='/effective-dart/usage#prefer-using-concise-constructor-syntax'><strong>推荐</strong> 使用简洁的构造函数语法。</a>
* <a href='/effective-dart/usage#dont-use-new'>DON'T use <code>new</code>.</a>

  <a href='/effective-dart/usage#dont-use-new'><strong>不要</strong> 使用 <code>new</code></a>
* <a href='/effective-dart/usage#dont-use-const-redundantly'>DON'T use <code>const</code> redundantly.</a>

  <a href='/effective-dart/usage#dont-use-const-redundantly'><strong>不要</strong> 冗余地使用 <code>const</code></a>

**Error handling**

**错误处理**

* <a href='/effective-dart/usage#avoid-catches-without-on-clauses'>AVOID catches without <code>on</code> clauses.</a>

  <a href='/effective-dart/usage#avoid-catches-without-on-clauses'><strong>避免</strong> 使用没有 <code>on</code> 语句的 catch</a>
* <a href='/effective-dart/usage#dont-discard-errors-from-catches-without-on-clauses'>DON'T discard errors from catches without <code>on</code> clauses.</a>

  <a href='/effective-dart/usage#dont-discard-errors-from-catches-without-on-clauses'><strong>不要</strong> 丢弃没有使用 <code>on</code> 语句捕获的异常</a>
* <a href='/effective-dart/usage#do-throw-objects-that-implement-error-only-for-programmatic-errors'>DO throw objects that implement <code>Error</code> only for programmatic errors.</a>

  <a href='/effective-dart/usage#do-throw-objects-that-implement-error-only-for-programmatic-errors'><strong>要</strong> 只在代表编程错误的情况下才抛出实现了 <code>Error</code> 的异常</a>
* <a href='/effective-dart/usage#dont-explicitly-catch-error-or-types-that-implement-it'>DON'T explicitly catch <code>Error</code> or types that implement it.</a>

  <a href='/effective-dart/usage#dont-explicitly-catch-error-or-types-that-implement-it'><strong>不要</strong> 显示的捕获 <code>Error</code> 或者其子类</a>
* <a href='/effective-dart/usage#do-use-rethrow-to-rethrow-a-caught-exception'>DO use <code>rethrow</code> to rethrow a caught exception.</a>

  <a href='/effective-dart/usage#do-use-rethrow-to-rethrow-a-caught-exception'><strong>要</strong> 使用 <code>rethrow</code> 来重新抛出捕获的异常</a>

**Asynchrony**

**异步**

* <a href='/effective-dart/usage#prefer-asyncawait-over-using-raw-futures'>PREFER async/await over using raw futures.</a>

  <a href='/effective-dart/usage#prefer-asyncawait-over-using-raw-futures'><strong>推荐</strong> 使用 async/await 而不是直接使用底层的特性</a>
* <a href='/effective-dart/usage#dont-use-async-when-it-has-no-useful-effect'>DON'T use <code>async</code> when it has no useful effect.</a>

  <a href='/effective-dart/usage#dont-use-async-when-it-has-no-useful-effect'><strong>不要</strong> 在没有有用效果的情况下使用 <code>async</code></a>
* <a href='/effective-dart/usage#consider-using-higher-order-methods-to-transform-a-stream'>CONSIDER using higher-order methods to transform a stream.</a>

  <a href='/effective-dart/usage#consider-using-higher-order-methods-to-transform-a-stream'><strong>考虑</strong> 使用高阶函数来转换事件流 (stream)</a>
* <a href='/effective-dart/usage#avoid-using-completer-directly'>AVOID using Completer directly.</a>

  <a href='/effective-dart/usage#avoid-using-completer-directly'><strong>避免</strong> 直接使用 Completer</a>
* <a href='/effective-dart/usage#do-test-for-futuret-when-disambiguating-a-futureort-whose-type-argument-could-be-object'>DO test for <code>Future&lt;T&gt;</code> when disambiguating a <code>FutureOr&lt;T&gt;</code> whose type argument could be <code>Object</code>.</a>

  <a href='/effective-dart/usage#do-test-for-futuret-when-disambiguating-a-futureort-whose-type-argument-could-be-object'><strong>要</strong> 使用 <code>Future<T></code> 对 <code>FutureOr<T></code> 参数进行测试，以消除参数可能是 <code>Object</code> 类型的歧义</a>

</div>
<div>


### Design

### 设计


**Names**

**命名**

* <a href='/effective-dart/design#do-use-terms-consistently'>DO use terms consistently.</a>

  <a href='/effective-dart/design#do-use-terms-consistently'><strong>要</strong> 使用一致的术语。</a>
* <a href='/effective-dart/design#avoid-abbreviations'>AVOID abbreviations.</a>

  <a href='/effective-dart/design#avoid-abbreviations'><strong>避免</strong> 缩写。</a>
* <a href='/effective-dart/design#prefer-putting-the-most-descriptive-noun-last'>PREFER putting the most descriptive noun last.</a>

  <a href='/effective-dart/design#prefer-putting-the-most-descriptive-noun-last'><strong>推荐</strong> 把最具描述性的名词放到最后。</a>
* <a href='/effective-dart/design#consider-making-the-code-read-like-a-sentence'>CONSIDER making the code read like a sentence.</a>

  <a href='/effective-dart/design#consider-making-the-code-read-like-a-sentence'><strong>考虑</strong> 尽量让代码看起来像普通的句子。</a>
* <a href='/effective-dart/design#prefer-a-noun-phrase-for-a-non-boolean-property-or-variable'>PREFER a noun phrase for a non-boolean property or variable.</a>

  <a href='/effective-dart/design#prefer-a-noun-phrase-for-a-non-boolean-property-or-variable'><strong>推荐</strong> 使用名词短语来命名不是布尔类型的变量和属性。</a>
* <a href='/effective-dart/design#prefer-a-non-imperative-verb-phrase-for-a-boolean-property-or-variable'>PREFER a non-imperative verb phrase for a boolean property or variable.</a>

  <a href='/effective-dart/design#prefer-a-non-imperative-verb-phrase-for-a-boolean-property-or-variable'><strong>推荐</strong> 使用非命令式动词短语命名布尔类型的变量和属性。</a>
* <a href='/effective-dart/design#consider-omitting-the-verb-for-a-named-boolean-parameter'>CONSIDER omitting the verb for a named boolean <em>parameter</em>.</a>

  <a href='/effective-dart/design#consider-omitting-the-verb-for-a-named-boolean-parameter'><strong>考虑</strong> 省略命名布尔<strong>参数</strong>的动词。</a>
* <a href='/effective-dart/design#prefer-the-positive-name-for-a-boolean-property-or-variable'>PREFER the &quot;positive&quot; name for a boolean property or variable.</a>

  <a href='/effective-dart/design#prefer-the-positive-name-for-a-boolean-property-or-variable'><strong>考虑</strong> 为布尔属性或变量取“肯定”含义的名字。</a>
* <a href='/effective-dart/design#prefer-an-imperative-verb-phrase-for-a-function-or-method-whose-main-purpose-is-a-side-effect'>PREFER an imperative verb phrase for a function or method whose main purpose is a side effect.</a>

  <a href='/effective-dart/design#prefer-an-imperative-verb-phrase-for-a-function-or-method-whose-main-purpose-is-a-side-effect'><strong>推荐</strong> 使用命令式动词短语来命名带有副作用的函数或者方法。</a>
* <a href='/effective-dart/design#prefer-a-noun-phrase-or-non-imperative-verb-phrase-for-a-function-or-method-if-returning-a-value-is-its-primary-purpose'>PREFER a noun phrase or non-imperative verb phrase for a function or method if returning a value is its primary purpose.</a>

  <a href='/effective-dart/design#prefer-a-noun-phrase-or-non-imperative-verb-phrase-for-a-function-or-method-if-returning-a-value-is-its-primary-purpose'><strong>考虑</strong> 使用名词短语或者非命令式动词短语命名返回数据为主要功能的方法或者函数。</a>
* <a href='/effective-dart/design#consider-an-imperative-verb-phrase-for-a-function-or-method-if-you-want-to-draw-attention-to-the-work-it-performs'>CONSIDER an imperative verb phrase for a function or method if you want to draw attention to the work it performs.</a>

  <a href='/effective-dart/design#consider-an-imperative-verb-phrase-for-a-function-or-method-if-you-want-to-draw-attention-to-the-work-it-performs'><strong>考虑</strong> 使用命令式动词短语命名一个函数或方法，若果你希望它的执行能被重视。</a>
* <a href='/effective-dart/design#avoid-starting-a-function-or-method-name-with-get'>AVOID starting a function or method name with <code>get</code>.</a>

  <a href='/effective-dart/design#avoid-starting-a-function-or-method-name-with-get'><strong>避免</strong> 在函数或方法命名中使用 <code>get</code> 开头。</a>
* <a href='/effective-dart/design#prefer-naming-a-method-to___-if-it-copies-the-objects-state-to-a-new-object'>PREFER naming a method <code>to___()</code> if it copies the object's state to a new object.</a>

  <a href='/effective-dart/design#prefer-naming-a-method-to___-if-it-copies-the-objects-state-to-a-new-object'><strong>推荐</strong> 使用 <code>to___()</code> 来命名把对象的状态转换到一个新的对象的函数。</a>
* <a href='/effective-dart/design#prefer-naming-a-method-as___-if-it-returns-a-different-representation-backed-by-the-original-object'>PREFER naming a method <code>as___()</code> if it returns a different representation backed by the original object.</a>

  <a href='/effective-dart/design#prefer-naming-a-method-as___-if-it-returns-a-different-representation-backed-by-the-original-object'><strong>推荐</strong> 使用 <code>as___()</code> 来命名把原来对象转换为另外一种表现形式的函数。</a>
* <a href='/effective-dart/design#avoid-describing-the-parameters-in-the-functions-or-methods-name'>AVOID describing the parameters in the function's or method's name.</a>

  <a href='/effective-dart/design#avoid-describing-the-parameters-in-the-functions-or-methods-name'><strong>避免</strong> 在方法或者函数名称中描述参数。</a>
* <a href='/effective-dart/design#do-follow-existing-mnemonic-conventions-when-naming-type-parameters'>DO follow existing mnemonic conventions when naming type parameters.</a>

  <a href='/effective-dart/design#do-follow-existing-mnemonic-conventions-when-naming-type-parameters'><strong>要</strong> 在命名参数时，遵循现有的助记符约定。</a>

**Libraries**

**库**

* <a href='/effective-dart/design#prefer-making-declarations-private'>PREFER making declarations private.</a>

  <a href='/effective-dart/design#prefer-making-declarations-private'><strong>推荐</strong> 使用私有声明。</a>
* <a href='/effective-dart/design#consider-declaring-multiple-classes-in-the-same-library'>CONSIDER declaring multiple classes in the same library.</a>

  <a href='/effective-dart/design#consider-declaring-multiple-classes-in-the-same-library'><strong>考虑</strong> 声明多个类在一个库中。</a>

**Classes and mixins**

**类和 mixin**

* <a href='/effective-dart/design#avoid-defining-a-one-member-abstract-class-when-a-simple-function-will-do'>AVOID defining a one-member abstract class when a simple function will do.</a>

  <a href='/effective-dart/design#avoid-defining-a-one-member-abstract-class-when-a-simple-function-will-do'><strong>避免</strong> 避免为了使用一个简单的函数而去定义一个单一成员的抽象类</a>
* <a href='/effective-dart/design#avoid-defining-a-class-that-contains-only-static-members'>AVOID defining a class that contains only static members.</a>

  <a href='/effective-dart/design#avoid-defining-a-class-that-contains-only-static-members'><strong>避免</strong> 定义仅包含静态成员的类。</a>
* <a href='/effective-dart/design#avoid-extending-a-class-that-isnt-intended-to-be-subclassed'>AVOID extending a class that isn't intended to be subclassed.</a>

  <a href='/effective-dart/design#avoid-extending-a-class-that-isnt-intended-to-be-subclassed'><strong>避免</strong> 集成一个不期望被集成的类。</a>
* <a href='/effective-dart/design#do-use-class-modifiers-to-control-if-your-class-can-be-extended'>DO use class modifiers to control if your class can be extended.</a>

  <a href='/effective-dart/design#do-use-class-modifiers-to-control-if-your-class-can-be-extended'><strong>要</strong> 使用类修饰符来控制类是否可以扩展</a>
* <a href='/effective-dart/design#avoid-implementing-a-class-that-isnt-intended-to-be-an-interface'>AVOID implementing a class that isn't intended to be an interface.</a>

  <a href='/effective-dart/design#avoid-implementing-a-class-that-isnt-intended-to-be-an-interface'><strong>避免</strong> 去实现一个不期望成为接口的类（该类不想作为接口被实现）。</a>
* <a href='/effective-dart/design#do-use-class-modifiers-to-control-if-your-class-can-be-an-interface'>DO use class modifiers to control if your class can be an interface.</a>

  <a href='/effective-dart/design#do-use-class-modifiers-to-control-if-your-class-can-be-an-interface'><strong>要</strong> 使用类修饰符来控制你的类是否可以成为接口</a>
* <a href='/effective-dart/design#prefer-defining-a-pure-mixin-or-pure-class-to-a-mixin-class'>PREFER defining a pure <code>mixin</code> or pure <code>class</code> to a <code>mixin class</code>.</a>

  <a href='/effective-dart/design#prefer-defining-a-pure-mixin-or-pure-class-to-a-mixin-class'><strong>推荐</strong> 定义存粹的 <code>mixin</code> 或存粹的 <code>class</code>，而不是 <code>mixin class</code></a>

**Constructors**

**构造函数**

* <a href='/effective-dart/design#consider-making-your-constructor-const-if-the-class-supports-it'>CONSIDER making your constructor <code>const</code> if the class supports it.</a>

  <a href='/effective-dart/design#consider-making-your-constructor-const-if-the-class-supports-it'><strong>考虑</strong> 在类支持的情况下，指定构造函数为  <code>const</code>。</a>

**Members**

**成员**

* <a href='/effective-dart/design#prefer-making-fields-and-top-level-variables-final'>PREFER making fields and top-level variables <code>final</code>.</a>

  <a href='/effective-dart/design#prefer-making-fields-and-top-level-variables-final'><strong>推荐</strong> 指定字段或顶级变量为 <code>final</code> 。</a>
* <a href='/effective-dart/design#do-use-getters-for-operations-that-conceptually-access-properties'>DO use getters for operations that conceptually access properties.</a>

  <a href='/effective-dart/design#do-use-getters-for-operations-that-conceptually-access-properties'><strong>要</strong> 对概念上是访问的属性使用 getter 方法。</a>
* <a href='/effective-dart/design#do-use-setters-for-operations-that-conceptually-change-properties'>DO use setters for operations that conceptually change properties.</a>

  <a href='/effective-dart/design#do-use-setters-for-operations-that-conceptually-change-properties'><strong>要</strong> 对概念上是修改的属性使用 setter 方法。</a>
* <a href='/effective-dart/design#dont-define-a-setter-without-a-corresponding-getter'>DON'T define a setter without a corresponding getter.</a>

  <a href='/effective-dart/design#dont-define-a-setter-without-a-corresponding-getter'><strong>不要</strong> 在没有对应的 getter 的情况下定义 setter。</a>
* <a href='/effective-dart/design#avoid-using-runtime-type-tests-to-fake-overloading'>AVOID using runtime type tests to fake overloading.</a>

  <a href='/effective-dart/design#avoid-using-runtime-type-tests-to-fake-overloading'><strong>避免</strong> 用运行时类型测试来模拟重载。</a>
* <a href='/effective-dart/design#avoid-public-late-final-fields-without-initializers'>AVOID public <code>late final</code> fields without initializers.</a>

  <a href='/effective-dart/design#avoid-public-late-final-fields-without-initializers'><strong>避免</strong> 使用没有初始化器的公开 <code>late final</code> 字段。</a>
* <a href='/effective-dart/design#avoid-returning-nullable-future-stream-and-collection-types'>AVOID returning nullable <code>Future</code>, <code>Stream</code>, and collection types.</a>

  <a href='/effective-dart/design#avoid-returning-nullable-future-stream-and-collection-types'><strong>避免</strong> 返回可空的 <code>Future</code>、<code>Stream</code> 和集合类型。</a>
* <a href='/effective-dart/design#avoid-returning-this-from-methods-just-to-enable-a-fluent-interface'>AVOID returning <code>this</code> from methods just to enable a fluent interface.</a>

  <a href='/effective-dart/design#avoid-returning-this-from-methods-just-to-enable-a-fluent-interface'><strong>避免</strong> 为了书写流畅，而从方法中返回 <code>this</code> 。</a>

**Types**

**类型**

* <a href='/effective-dart/design#do-type-annotate-variables-without-initializers'>DO type annotate variables without initializers.</a>

  <a href='/effective-dart/design#do-type-annotate-variables-without-initializers'><strong>要</strong> 为没有初始化器的变量添加类型注解。</a>
* <a href='/effective-dart/design#do-type-annotate-fields-and-top-level-variables-if-the-type-isnt-obvious'>DO type annotate fields and top-level variables if the type isn't obvious.</a>

  <a href='/effective-dart/design#do-type-annotate-fields-and-top-level-variables-if-the-type-isnt-obvious'><strong>推荐</strong> 为类型不明显的公共字段和公共顶级变量指定类型注解。</a>
* <a href='/effective-dart/design#dont-redundantly-type-annotate-initialized-local-variables'>DON'T redundantly type annotate initialized local variables.</a>

  <a href='/effective-dart/design#dont-redundantly-type-annotate-initialized-local-variables'><strong>避免</strong> 为初始化的局部变量添加冗余地类型注解。</a>
* <a href='/effective-dart/design#do-annotate-return-types-on-function-declarations'>DO annotate return types on function declarations.</a>

  <a href='/effective-dart/design#do-annotate-return-types-on-function-declarations'><strong>要</strong> 在函数声明上注解返回类型</a>
* <a href='/effective-dart/design#do-annotate-parameter-types-on-function-declarations'>DO annotate parameter types on function declarations.</a>

  <a href='/effective-dart/design#do-annotate-parameter-types-on-function-declarations'><strong>要</strong> 在函数声明上注解参数类型。</a>
* <a href='/effective-dart/design#dont-annotate-inferred-parameter-types-on-function-expressions'>DON'T annotate inferred parameter types on function expressions.</a>

  <a href='/effective-dart/design#dont-annotate-inferred-parameter-types-on-function-expressions'><strong>避免</strong> 在函数表达式上注解推断的参数类型。</a>
* <a href='/effective-dart/design#dont-type-annotate-initializing-formals'>DON'T type annotate initializing formals.</a>

  <a href='/effective-dart/design#dont-type-annotate-initializing-formals'><strong>不要</strong> 为初始化形式参数添加类型注解。</a>
* <a href='/effective-dart/design#do-write-type-arguments-on-generic-invocations-that-arent-inferred'>DO write type arguments on generic invocations that aren't inferred.</a>

  <a href='/effective-dart/design#do-write-type-arguments-on-generic-invocations-that-arent-inferred'><strong>要</strong> 在泛型调用中写入未推断的类型参数</a>
* <a href='/effective-dart/design#dont-write-type-arguments-on-generic-invocations-that-are-inferred'>DON'T write type arguments on generic invocations that are inferred.</a>

  <a href='/effective-dart/design#dont-write-type-arguments-on-generic-invocations-that-are-inferred'><strong>不要</strong> 在已推断的泛型调用上写类型参数。</a>
* <a href='/effective-dart/design#avoid-writing-incomplete-generic-types'>AVOID writing incomplete generic types.</a>

  <a href='/effective-dart/design#avoid-writing-incomplete-generic-types'><strong>避免</strong> 写出不完整的泛型类型。</a>
* <a href='/effective-dart/design#do-annotate-with-dynamic-instead-of-letting-inference-fail'>DO annotate with <code>dynamic</code> instead of letting inference fail.</a>

  <a href='/effective-dart/design#do-annotate-with-dynamic-instead-of-letting-inference-fail'><strong>推荐</strong> 使用 <code>dynamic</code> 注解替换推断失败的情况。</a>
* <a href='/effective-dart/design#prefer-signatures-in-function-type-annotations'>PREFER signatures in function type annotations.</a>

  <a href='/effective-dart/design#prefer-signatures-in-function-type-annotations'><strong>推荐</strong> 使 function 类型注解的特征更明显</a>
* <a href='/effective-dart/design#dont-specify-a-return-type-for-a-setter'>DON'T specify a return type for a setter.</a>

  <a href='/effective-dart/design#dont-specify-a-return-type-for-a-setter'><strong>不要</strong> 为 setter 方法指定返回类型。</a>
* <a href='/effective-dart/design#dont-use-the-legacy-typedef-syntax'>DON'T use the legacy typedef syntax.</a>

  <a href='/effective-dart/design#dont-use-the-legacy-typedef-syntax'><strong>不要</strong> 使用弃用的 typedef 语法。</a>
* <a href='/effective-dart/design#prefer-inline-function-types-over-typedefs'>PREFER inline function types over typedefs.</a>

  <a href='/effective-dart/design#prefer-inline-function-types-over-typedefs'><strong>推荐</strong> 优先使用内联函数类型，而后是 typedef。</a>
* <a href='/effective-dart/design#prefer-using-function-type-syntax-for-parameters'>PREFER using function type syntax for parameters.</a>

  <a href='/effective-dart/design#prefer-using-function-type-syntax-for-parameters'><strong>考虑</strong> 在参数上使用函数类型语法。</a>
* <a href='/effective-dart/design#avoid-using-dynamic-unless-you-want-to-disable-static-checking'>AVOID using <code>dynamic</code> unless you want to disable static checking.</a>

  <a href='/effective-dart/design#avoid-using-dynamic-unless-you-want-to-disable-static-checking'><strong>避免</strong> 使用 <code>dynamic</code> 除非你希望禁用静态检查</a>
* <a href='/effective-dart/design#do-use-futurevoid-as-the-return-type-of-asynchronous-members-that-do-not-produce-values'>DO use <code>Future&lt;void&gt;</code> as the return type of asynchronous members that do not produce values.</a>

  <a href='/effective-dart/design#do-use-futurevoid-as-the-return-type-of-asynchronous-members-that-do-not-produce-values'><strong>要</strong> 使用 <code>Future<void></code> 作为无法回值异步成员的返回类型。</a>
* <a href='/effective-dart/design#avoid-using-futureort-as-a-return-type'>AVOID using <code>FutureOr&lt;T&gt;</code> as a return type.</a>

  <a href='/effective-dart/design#avoid-using-futureort-as-a-return-type'><strong>避免</strong> 使用 <code>FutureOr<T></code> 作为返回类型。</a>

**Parameters**

**参数**

* <a href='/effective-dart/design#avoid-positional-boolean-parameters'>AVOID positional boolean parameters.</a>

  <a href='/effective-dart/design#avoid-positional-boolean-parameters'><strong>避免</strong> 布尔类型的位置参数。</a>
* <a href='/effective-dart/design#avoid-optional-positional-parameters-if-the-user-may-want-to-omit-earlier-parameters'>AVOID optional positional parameters if the user may want to omit earlier parameters.</a>

  <a href='/effective-dart/design#avoid-optional-positional-parameters-if-the-user-may-want-to-omit-earlier-parameters'><strong>避免</strong> 在调用者需要省略前面参数的方法中，使用位置可选参数。</a>
* <a href='/effective-dart/design#avoid-mandatory-parameters-that-accept-a-special-no-argument-value'>AVOID mandatory parameters that accept a special &quot;no argument&quot; value.</a>

  <a href='/effective-dart/design#avoid-mandatory-parameters-that-accept-a-special-no-argument-value'><strong>避免</strong> 强制参数去接受一个特定表示"空参数"的值。</a>
* <a href='/effective-dart/design#do-use-inclusive-start-and-exclusive-end-parameters-to-accept-a-range'>DO use inclusive start and exclusive end parameters to accept a range.</a>

  <a href='/effective-dart/design#do-use-inclusive-start-and-exclusive-end-parameters-to-accept-a-range'><strong>要</strong> 使用开始为闭区间，结束为开区间的半开半闭区间作为接受范围。</a>

**Equality**

**相等**

* <a href='/effective-dart/design#do-override-hashcode-if-you-override'>DO override <code>hashCode</code> if you override <code>==</code>.</a>

  <a href='/effective-dart/design#do-override-hashcode-if-you-override'><strong>要</strong> 对重写 <code>==</code> 操作符的类，重写 <code>hashCode</code> 方法。</a>
* <a href='/effective-dart/design#do-make-your-operator-obey-the-mathematical-rules-of-equality'>DO make your <code>==</code> operator obey the mathematical rules of equality.</a>

  <a href='/effective-dart/design#do-make-your-operator-obey-the-mathematical-rules-of-equality'><strong>要</strong> 让 <code>==</code> 操作符的相等遵守数学规则。</a>
* <a href='/effective-dart/design#avoid-defining-custom-equality-for-mutable-classes'>AVOID defining custom equality for mutable classes.</a>

  <a href='/effective-dart/design#avoid-defining-custom-equality-for-mutable-classes'><strong>避免</strong> 为可变类自定义相等。</a>
* <a href='/effective-dart/design#dont-make-the-parameter-to-nullable'>DON'T make the parameter to <code>==</code> nullable.</a>

  <a href='/effective-dart/design#dont-make-the-parameter-to-nullable'><strong>不要</strong> 使用 <code>==</code> 操作符与可空值比较。</a>

</div>
</div>
