---
# title: "Annotate Once: AngularDart"
title: "一次注解，处处生效：AngularDart"
# description: "Introducing Component Inheritance"
description: "介绍组件继承（Component Inheritance）"
ai-translated: true
publishDate: 2017-08-31
author: leonsenft
image: images/1JLI4Zv7yp3j6qSzoaGEehw.webp
category: deep-dive
layout: blog
---


<DashImage src="images/1JLI4Zv7yp3j6qSzoaGEehw.webp" alt="A blue origami hummingbird pollinating an orange flower." />


AngularDart allows developers to create [components and directives](https://webdev.dartlang.org/angular/guide/architecture) by annotating class definitions with metadata. This metadata instructs the compiler to generate code necessary for dependency injection, template construction, data binding, and more.

AngularDart 允许开发者通过用元数据（metadata）注解类定义，
来创建[组件和指令](https://webdev.dartlang.org/angular/guide/architecture)。
这些元数据会指示编译器生成依赖注入（dependency injection）、
模板构造、数据绑定（data binding）等所需的代码。

```dart
import 'package:angular/angular.dart';

@Component(
  selector: 'greet',
  template: '<p>Hello {{name}}!</p>',
)
class GreetComponent {
  String name;
}
```

Until recently, the AngularDart compiler did not process metadata on supertypes. This meant sharing common functionality between different components and directives via inheritance required redeclaring all of the metadata in each class.

直到最近，AngularDart 编译器还不处理超类型（supertype）上的元数据。
这意味着，如果想通过继承在不同的组件和指令之间共享通用功能，
就必须在每个类中重新声明所有元数据。

Let’s see what this pattern looked like.

我们来看看这种模式原本是什么样子。

*Throughout this article, the following example will be revisited to demonstrate the benefits of metadata inheritance. This is a simplified example drawn from the official [Material Design components for AngularDart](https://pub.dartlang.org/packages/angular_components) used at Google.*

*在整篇文章中，我们会反复回到下面这个示例，
以展示元数据继承（metadata inheritance）的好处。
这是一个简化示例，取自 Google 内部使用的官方
[AngularDart Material Design 组件](https://pub.dartlang.org/packages/angular_components)。*

```dart
import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Directive(selector: '[my-button]')
class MyButtonDirective {
  final StreamController<UIEvent> _trigger = new StreamController<UIEvent>();
  
  @Input()
  bool disabled = false;

  @Output()
  Stream<UIEvent> get trigger => _trigger.stream;

  @HostListener('click', const [r'$event'])
  void onClick(MouseEvent event) {
    if (disabled) return;
    _trigger.add(event);
  }

  @HostListener('keypress', const [r'$event'])
  void onKeyPress(KeyboardEvent event) {
    if (disabled) return;
    if (event.keyCode == KeyCode.ENTER) {
      _trigger.add(event);
    }
  }
}
```

Here we have a simple directive that adds button functionality to its host element. If the host element is clicked, or focused when the enter key is pressed, it will emit an event via the `trigger` output. It can also be disabled to prevent emitting events. This logic can be reused to create a button component using inheritance.

这里我们有一个简单的指令（directive），它为宿主元素添加按钮功能。
如果宿主元素被点击，或者在获得焦点时按下了回车键，
它就会通过 `trigger` 输出发出一个事件。
它也可以被禁用，以阻止发出事件。
这段逻辑可以通过继承来复用，用于创建一个按钮组件。

```dart
import 'package:angular/angular.dart';

import 'my_button_directive.dart';

@Component(
  selector: 'my-button',
  template: '<ng-content></ng-content>',
  inputs: const ['disabled'],
  outputs: const ['trigger'],
  host: const {
    '(click)': r'onClick($event)',
    '(keypress)': r'onKeyPress($event)',
  },
)
class MyButtonComponent extends MyButtonDirective {}
```

Now we have a component which inherits button behavior from the directive, but notice the need to redeclare the input, output, and host listeners in the derived component annotation?

现在我们有了一个从指令继承按钮行为的组件，
但注意到没有：在派生组件的注解中，
还需要重新声明输入、输出和宿主监听器（host listener）？

As of version 4.0, redeclaring metadata on derived types is no longer necessary!

从 4.0 版本开始，不再需要在派生类型上重新声明元数据了！

```dart
import 'package:angular/angular.dart';

import 'my_button_directive.dart';

@Component(
  selector: 'my-button',
  template: '<ng-content></ng-content>',
)
class MyButtonComponent extends MyButtonDirective {}
```

Now `MyButtonComponent` implicitly has the same input, output and host listeners as `MyButtonDirective`, similar to how a class normally inherits properties and methods. Now that you’ve seen a simple — and hopefully compelling — example, let’s look at what exactly is inheritable and how it works.

现在 `MyButtonComponent` 隐式地拥有了与 `MyButtonDirective`
相同的输入、输出和宿主监听器，
就像类通常继承属性和方法一样。
既然你已经看过这个简单——希望也足够有说服力——的示例，
我们就来看看究竟哪些内容可以继承，以及它是如何工作的。

### What is inheritable?

### 哪些内容可以继承？

The following annotations are now inherited from all supertypes, including superclasses, interfaces, and mixins.

以下注解（annotation）现在会从所有超类型继承，
包括超类（superclass）、接口（interface）和 mixin。

* `@ContentChild` / `@ContentChildren`

* `@HostBinding`

* `@HostListener`

* `@Input`

* `@Output`

* `@ViewChild` / `@ViewChildren`

This means it’s no longer necessary to redeclare any of the above annotations in a derived class.

这意味着不再需要在派生类中重新声明上述任何注解。

### What isn’t inheritable?

### 哪些内容不能继承？

Templates, styles, and other `@Directive` parameters are *not* inherited. Only metadata that is bound to a property or method is inherited. This decision was made because derived types can override accessors and methods, referencing their original implementation via `super`, whereas no such mechanism exists for the values bound to other metadata.

模板、样式以及其他 `@Directive` 参数*不会*被继承。
只有绑定到属性或方法上的元数据才会被继承。
这样决定是因为派生类型可以覆写访问器和方法，
并通过 `super` 引用它们的原始实现，
而绑定到其他元数据上的值并不存在这样的机制。

### Inherited metadata is immutable

### 继承的元数据是不可变的

It’s still valid to redeclare annotations in derived types; however, modifying the inherited metadata or binding it to a different property is not permitted.

在派生类型中重新声明注解仍然是合法的；
但是，不允许修改继承来的元数据，
也不允许把它绑定到另一个属性上。

```dart
import 'package:angular/angular.dart';

import 'my_button_directive.dart';

@Directive(selector: '[illegal-button]')
class IllegalButtonDirective extends MyButtonDirective {
  @Input('notEnabled') // Changing the binding name causes a compile error.
  set disabled(bool value) {
    super.disabled = value; 
  }
}
```

This restriction may be lifted in the future, but for now is necessary to simplify tooling and ensure components and directives are easily substitutable.

这一限制未来可能会解除，但眼下为了简化工具链，
并确保组件和指令易于相互替换，它是必要的。

### Metadata base types

### 元数据基类型

An interesting consequence arises as a result of metadata inheritance: classes that are not directives or components themselves, may now be annotated to serve as base types or mixins for others. Let’s further develop our example to demonstrate.

元数据继承带来了一个有趣的结果：
本身不是指令或组件的类，现在也可以加上注解，
作为其他类的基类型（base type）或 mixin。
我们来进一步完善示例加以演示。

There’s an issue with the current button component implementation: the button isn’t focusable. This means it’s not accessible, and can’t be triggered via the key press listener. This issue is also present with the button directive if its host element isn’t focusable. We can solve this problem by making the button directive set the `tabindex` property on the host element.

当前的按钮组件实现有一个问题：按钮无法获得焦点。
这意味着它是不可访问的（not accessible），
也无法通过按键监听器来触发。
如果按钮指令的宿主元素无法获得焦点，同样存在这个问题。
我们可以让按钮指令在宿主元素上设置 `tabindex` 属性来解决它。

`MyButtonDirective` could implement this directly, but let’s imagine we have other components that will want focusable behavior as well. Instead, we’ll create an abstract class that can be extended or mixed in by directives or components.

`MyButtonDirective` 可以直接实现这一点，
但设想一下，我们还有其他组件也想要可获得焦点的行为。
因此，我们改为创建一个抽象类，
供指令或组件继承（extend）或混入（mix in）。

```dart
import 'package:angular/angular.dart';

abstract class HasTabIndex {
  bool get disabled;

  @HostBinding('tabindex')
  String get tabIndex => disabled ? null : '0';
}
```

We can now simply extend or mix in `HasTabIndex` to make the button directive — and consequently the derived component — focusable.

现在只需继承或混入 `HasTabIndex`，
就能让按钮指令——进而让派生组件——可以获得焦点。

```dart
@Directive(selector: '[my-button]')
class MyButtonDirective extends HasTabIndex {
  ...
}
```

### Conclusion

### 结语

We’ve seen how inheritable metadata reduces code duplication among components and directives with shared functionality. Furthermore, it should improve readability by allowing metadata to live next to its associated field or method. Hopefully you’ll find this feature helpful in developing and maintaining your own projects.

我们看到了可继承的元数据如何减少共享功能的组件和指令之间的代码重复。
此外，它允许元数据与关联的字段或方法放在一起，从而提升可读性。
希望你会觉得这个特性对你开发和维护自己的项目有所帮助。