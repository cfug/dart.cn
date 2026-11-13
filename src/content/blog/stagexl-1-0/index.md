---
# title: "StageXL 1.0"
title: "StageXL 1.0"
# description: "A fast 2D rendering engine for HTML5 and Dart."
description: "面向 HTML5 和 Dart 的高速 2D 渲染引擎。"
ai-translated: true
publishDate: 2016-12-03
author: bp74
image: images/1oPIKFEq7-9ndX53muruOsQ.webp
category: other
layout: blog
---


<DashImage src="images/1oPIKFEq7-9ndX53muruOsQ.webp" alt="StageXL 1.0 release artwork." />


After more than 4 years in development and available since the early beta versions of Dart, we are proud to announce the release of StageXL 1.0. [StageXL](http://www.stagexl.org/) is a fast and universal 2D render engine for games and applications on the web. This article talks about the most important features and applications of this library.

经过 4 年多的开发、从 Dart 早期 beta 版本起就可用，
我们自豪地宣布 StageXL 1.0 发布。
[StageXL](http://www.stagexl.org/) 是面向 Web 游戏和应用的
快速、通用 2D 渲染引擎。本文介绍这个库最重要的特性和应用。

## Standing on the shoulders of giants: Adobe Flash

## 站在巨人的肩膀上：Adobe Flash

Several years ago it became apparent that Adobe Flash will be replaced by the capabilities of HTML5. Video streaming platforms replaced their Flash players with HTML5 players and Google’s AdWords network banned all Flash based display ads recently. The last big resort of Flash applications on the web are games. Even today most games on facebook are built with Flash.

几年前就已明显，Adobe Flash 将被 HTML5 的能力取代。
视频流媒体平台用 HTML5 播放器替换了 Flash 播放器，
Google 的 AdWords 网络最近也禁止了所有基于 Flash
的展示广告。Flash 应用在 Web 上最后的大本营是游戏。
即使今天，facebook 上大多数游戏仍用 Flash 构建。

Game developers had no other choice than using Flash for games in the past. The capabilities of the DOM were not suitable for games and even after the introduction of the canvas element you had to deal with performance issues, compatibility issues and last but not least JavaScript (a language born out of hell if you ask certain Flash/ActionScript developers). Things became better with the introduction of libraries like [CreateJS](http://www.createjs.com/) or [PixiJS](http://www.pixijs.com/) which provide a Flash like API and developer experience. Also the raise of languages like [TypeScript](https://www.typescriptlang.org/), [Haxe](https://haxe.org/) or [CoffeeScript](http://coffeescript.org/) reduced the pain.

过去游戏开发者做游戏别无选择，只能用 Flash。
DOM 的能力不适合游戏，即使引入 canvas 元素之后，
你仍要应付性能问题、兼容性问题，
最后还有 JavaScript（某些 Flash/ActionScript 开发者
会说这是门生于地狱的语言）。随着
[CreateJS](http://www.createjs.com/) 或
[PixiJS](http://www.pixijs.com/) 等提供类 Flash API
和开发体验的库出现，情况好转了。
[TypeScript](https://www.typescriptlang.org/)、
[Haxe](https://haxe.org/) 或
[CoffeeScript](http://coffeescript.org/) 等语言的兴起
也减轻了痛苦。

As a former Flash/ActionScript game developer myself, I experienced all the things mentioned above first-hand. But once i got in touch with the early versions of Dart it was clear that it was a worthy successor to ActionScript. Dart looks and feels very similar to ActionScript and at the same time it is a much more modern language that avoids bloated syntax. But Flash is much more than the language. Flash provides a display tree based render engine, a sound engine, vector graphics, text rendering and much more. This was the foundation for StageXL — this new library should provider the features of Flash in combination with Dart and HTML5. Developers should be able to use Dart and StageXL to write their games in the same way as they did with Flash before. To make it even easier the API of StageXL is mostly identical to the one of Flash.

作为曾经的 Flash/ActionScript 游戏开发者，
上面提到的种种我都亲身经历过。但一接触 Dart 的早期版本，
我就清楚它是 ActionScript 的合格继任者。
Dart 看起来、用起来都很像 ActionScript，
同时又是避免臃肿语法的更现代的语言。
但 Flash 远不止语言本身。Flash 提供基于显示树的渲染引擎、
声音引擎、矢量图形、文本渲染等等。这就是 StageXL 的基础——
这个新库要把 Flash 的特性与 Dart 和 HTML5 结合起来。
开发者应该能像以前用 Flash 那样，用 Dart 和 StageXL
编写游戏。为了更容易上手，StageXL 的 API
与 Flash 的基本一致。

Flash developers should be familiar with StageXL code like this:

Flash 开发者应该对这样的 StageXL 代码很熟悉：

```
**Sprite** createContainer(**BitmapData** bitmapData) {
  var bitmap = new **Bitmap**(bitmapData);
  var sprite = new **Sprite**();
  bitmap.**x** = -bitmapData.**width** / 2;
  bitmap.**y** = -bitmapData.**height** / 2;
  sprite.**addChild**(bitmap);
  sprite.**alpha** = 0.5;
  return sprite;
}
```


[**StageXL - ActionScript to Dart comparison**
*Coming from ActionScript and learning Dart is easy. Both languages are class-based, single inheritance, object-oriented…*www.stagexl.org](http://www.stagexl.org/docs/actionscript-dart.html)

[**StageXL——ActionScript 到 Dart 对照**
*从 ActionScript 转学 Dart 很容易。两门语言都是基于类、
单继承、面向对象的……*www.stagexl.org](http://www.stagexl.org/docs/actionscript-dart.html)

## StageXL in a nutshell

## StageXL 概览

The API of StageXL covers a wide range of features. The main purpose of the library is a fast and easy to use render engine, but you need more than that to write a game or application.

StageXL 的 API 覆盖广泛的特性。这个库的主要目的
是快速易用的渲染引擎，但写游戏或应用需要的不止这些。

**Graphics:** A display tree is built out of nodes that extend the abstract DisplayObject base class. The position of a node on the tree defines if the display object is in front or back of another object. To create branches on the tree, a second abstract base class called DisplayObjectContainer is used. You can build custom display objects by extending one of those two base classes, or you can use one of the built in classes like Sprite, Bitmap, TextField or Shape. All these classes are the [same as in Flash](http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7e26.html) and similar concepts are used in other render engines too.

**图形：**显示树由继承抽象基类 DisplayObject 的节点构成。
节点在树上的位置决定显示对象在其他对象的前面还是后面。
要在树上创建分支，使用第二个抽象基类
DisplayObjectContainer。你可以继承这两个基类之一
构建自定义显示对象，也可以使用 Sprite、Bitmap、
TextField 或 Shape 等内置类。所有这些类都
[与 Flash 中相同](http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7e26.html)，
其他渲染引擎也使用类似概念。

**Interaction:** The EventDispatcher class provides the capabilities to dispatch events and to subscribe listeners to certain events. All display objects extend the EventDispatcher class and therefore they are capable of dispatching events. Those events can be custom events dispatched by your game logic, or events for mouse, touch and keyboard interaction dispatched by the StageXL runtime. Since all display objects live within the display tree, an event is propagated over all nodes from the root node to the target node and back again (capturing, target and bubbling phase of an event).

**交互：**EventDispatcher 类提供派发事件
和为特定事件订阅监听器的能力。所有显示对象都继承
EventDispatcher 类，因此都能派发事件。
这些事件可以是游戏逻辑派发的自定义事件，
也可以是 StageXL 运行时派发的鼠标、触摸和键盘交互事件。
由于所有显示对象都活在显示树中，
事件会从根节点传播到目标节点再返回
（事件的捕获、目标和冒泡阶段）。

**Audio:** Every game needs proper sound effects. StageXL provides the infrastructure to load and play audio samples without much hassle. The Sound class represents an audio sample that was loaded into memory. Calling the play method on the Sound class will start playing the audio sample and it will return an instance of the SoundChannel class to get control over the playback. You can play multiple instances of the same Sound concurrently, for example play multiple instances of an explosion sound.

**音频：**每个游戏都需要合适的音效。
StageXL 提供了轻松加载和播放音频样本的基础设施。
Sound 类表示加载进内存的音频样本。
调用 Sound 类的 play 方法会开始播放音频样本，
并返回一个 SoundChannel 类实例来控制播放。
你可以并发播放同一个 Sound 的多个实例，
比如同时播放多个爆炸声。

**Resources:** StageXL makes it easy to load images, audio files and other resources from the server. Since loading such files is an asynchronous operation, a Future based API is provided. Loading an image is as easy as waiting for the completion of the Future returned by the BitmapData.load method. The same is true for the Future returned by the Sound.load or TextureAtlas.load methods. To make it even more convenient to load many different resources at once, the ResourceManager class can be used. This class loads all specified resources and provides easy access to those resources once the loading process has finished. The ResourceManager can be seen as the replacement for embedded resources in Flash.

**资源：**StageXL 让从服务器加载图片、音频文件
和其他资源变得容易。由于加载这类文件是异步操作，
提供了基于 Future 的 API。加载图片就像等待
BitmapData.load 方法返回的 Future 完成一样简单。
Sound.load 或 TextureAtlas.load 方法返回的 Future
也是如此。要更方便地一次加载多种资源，
可以使用 ResourceManager 类。这个类加载所有指定资源，
并在加载完成后提供对这些资源的便捷访问。
ResourceManager 可以看作 Flash 内嵌资源的替代品。

**Animation:** StageXL also contains a framework for animations called Juggler. The Juggler framework was introduced by the [Starling](http://gamua.com/starling/) render engine well known among Flash developers. The Juggler is used to control so called Animatables based on the time that has passed between two render frames. One of those Animatables is the Tween class, which is used to animate the position, the rotation, the scaling or the translucency of any display object. The Juggler also provides time based Streams to control values in your game logic. More details can be found in the [Juggler documentation](http://www.stagexl.org/docs/wiki-articles.html?article=juggler).

**动画：**StageXL 还包含名为 Juggler 的动画框架。
Juggler 框架由 Flash 开发者熟知的
[Starling](http://gamua.com/starling/) 渲染引擎引入。
Juggler 基于两个渲染帧之间流逝的时间，
控制所谓的 Animatable。其中之一是 Tween 类，
用来对任何显示对象的位置、旋转、缩放或透明度做动画。
Juggler 还提供基于时间的 Stream 来控制游戏逻辑中的值。
更多细节见
[Juggler 文档](http://www.stagexl.org/docs/wiki-articles.html?article=juggler)。

## StageXL behind the scenes

## StageXL 幕后

The render engine of StageXL is built on top of WebGL for best performance and flexibility. Of course the developer does not need to know anything about WebGL to use StageXL. Still, it is worth noting that display objects are rendered by WebGL shader programs either by using a default shader or a more advanced shader for filter effects like BlurFilter, DropShadowFilter, ColorMatrixFilter and others. In more advanced use cases developers can use custom filters by implementing their own WebGL shader program code.

StageXL 的渲染引擎构建在 WebGL 之上，
以获得最佳性能和灵活性。当然，开发者使用 StageXL
不需要懂任何 WebGL。不过值得说明的是，
显示对象由 WebGL shader 程序渲染：
要么用默认 shader，要么用更高级的 shader 实现
BlurFilter、DropShadowFilter、ColorMatrixFilter
等滤镜效果。在更高级的用例中，
开发者可以编写自己的 WebGL shader 程序代码
来实现自定义滤镜。

To achieve the best rendering performance possible it is essential to use so called texture atlases. All your image assets are combined in one big image that is uploaded to the memory of the GPU. Therefor StageXL supports the most common texture atlas formats out of the box. Use your favorite texture atlas generator (we highly recommend [TexturePacker](https://www.codeandweb.com/texturepacker)) to generate the texture atlas, the rest is handled by StageXL internally. As a special goodie StageXL supports advanced texture atlas features such as [polygon sprite meshes](https://www.codeandweb.com/texturepacker/tutorials/cocos2d-x-performance-optimization) and the polygon packing algorithm.

要获得尽可能好的渲染性能，使用所谓的纹理图集
（texture atlas）至关重要。所有图片资产合并成一张大图，
上传到 GPU 内存。因此 StageXL 开箱支持最常见的
纹理图集格式。用你喜欢的纹理图集生成器
（我们强烈推荐
[TexturePacker](https://www.codeandweb.com/texturepacker)）
生成纹理图集，其余由 StageXL 内部处理。
作为特别福利，StageXL 支持高级纹理图集特性，
如[多边形 sprite 网格](https://www.codeandweb.com/texturepacker/tutorials/cocos2d-x-performance-optimization)
和多边形打包算法。

The sound engine of StageXL is build on top of the WebAudio API. Similar to WebGL the developer does not to need to know anything about this API. To play audio samples you just need to use the Sound and SoundChannel classes which do all the heavy lifting for you. A common pain with playing audio on different browsers is the missing support for certain audio codecs. You probably encode you audio samples as mp3 files, but it is not guaranteed that mp3 is supported on all platforms. The same is true if you encode your audio samples with any other file format. StageXL solves this problem by automatically loading the correct audio format based on the capabilities of the browser.

StageXL 的声音引擎构建在 WebAudio API 之上。
与 WebGL 类似，开发者不需要了解这个 API。
播放音频样本只需用 Sound 和 SoundChannel 类，
它们替你承担所有重活。在不同浏览器上播放音频的
常见痛点是缺少对某些音频编解码器的支持。
你可能把音频样本编码为 mp3 文件，
但不能保证所有平台都支持 mp3。
用任何其他文件格式编码也一样。
StageXL 根据浏览器的能力自动加载正确的音频格式，
解决了这个问题。

Other 2D render engines for JavaScript often claim to be the fastest and most flexible ones. Of course this claim depends heavily on the benchmark or the use case and is very difficult to verify. During the design and development of StageXL we constantly compared its performance and flexibility to other engines. In the end both quality factors do match or even surpass other engines which claim to be the best. One of the big advantages for StageXL in this regard is the use of the Dart programming language. The language not only allows a very clean API design, but also provides an outstanding compiler to JavaScript that optimizes certain patterns in a way you practically can’t implement by hand in JavaScript. The compiled JavaScript does not need to look pretty, it only needs to run fast. The compiler does function inlining, dead code elimination, constant folding, type inference and other optimizations. The compiler is also aware of how the JavaScript needs to look like to make it run fast in modern JavaScript engines. This is very different to other languages like TypeScript where the code is not compiled to JavaScript but only transpiled to JavaScript. Last but not least, you won’t need to change a single line of code to compile to native ES5 and ES6 JavaScript.

其他 JavaScript 2D 渲染引擎常常自称最快、最灵活。
当然，这种说法高度依赖基准测试或用例，很难验证。
在 StageXL 的设计和开发过程中，
我们不断把它的性能和灵活性与其他引擎对比。
最终这两项质量指标都能追平甚至超越那些自称最好的引擎。
StageXL 在这方面的一大优势是使用 Dart 编程语言。
这门语言不仅允许非常干净的 API 设计，
还提供了出色的 JavaScript 编译器，
能以你在 JavaScript 中几乎无法手写实现的方式
优化某些模式。编译出的 JavaScript 不需要好看，
只需要跑得快。编译器做函数内联、死代码消除、
常量折叠、类型推断等优化。编译器还知道
JavaScript 要长什么样才能在现代 JavaScript 引擎中跑得快。
这与 TypeScript 等其他语言非常不同——
后者的代码不是编译到 JavaScript，而只是转译到 JavaScript。
最后同样重要的是，编译到原生 ES5 和 ES6 JavaScript
不需要改动任何一行代码。

[**StageXL BunnyMark**
*Render as many bunnies as possible!*www.stagexl.org](http://www.stagexl.org/example/benchmark/bunny_mark/?v=2)

[**StageXL BunnyMark**
*尽可能多地渲染兔子！*www.stagexl.org](http://www.stagexl.org/example/benchmark/bunny_mark/?v=2)

## StageXL to be continued

## StageXL 未完待续

It took over 4 years to get to version 1.0 of StageXL. The reason for such a long time is that there is always something to improve or to add and you never think that the project is finished. This is also true for version 1.0 and new features will be added on a regular basis in the future. The feedback from the community is very valuable and feature requests are always welcome — bug reports too, to a certain degree ;)

StageXL 走到 1.0 版本花了 4 年多。
之所以这么久，是因为总有东西可以改进或添加，
你永远不会觉得项目完成了。1.0 版本也是如此，
未来会定期加入新特性。社区的反馈非常宝贵，
随时欢迎特性请求——bug 报告也是，在一定程度上 ;)

Probably the biggest feature we see on the horizon is support for [Flutter](https://flutter.io/). You would be able to write mobile games in Dart and StageXL for Android and iOS. The early versions of Flutter look very promising, unfortunately the platform does not yet expose the OpenGL APIs you need to build StageXL on top of it. We will keep an eye on the development and hope that it won’t take too long to see StageXL on mobile devices.

我们看到的下一个最大特性可能是对
[Flutter](https://flutter.io/) 的支持。
你将能用 Dart 和 StageXL 为 Android 和 iOS 编写移动游戏。
Flutter 的早期版本看起来很有希望，
可惜该平台还没有暴露在其上构建 StageXL 所需的
OpenGL API。我们会持续关注进展，
希望不用等太久就能在移动设备上看到 StageXL。

[**Flutter: The best mobile development experience?**
*Developing for mobile just got a lot more fun with Flutter's live developer workflow. At the heart of this new workflow…*news.dartlang.org](http://news.dartlang.org/2016/11/flutter-best-mobile-development.html)

[**Flutter：最佳移动开发体验？**
*Flutter 的实时开发工作流让移动开发有趣多了。
这个新工作流的核心……*news.dartlang.org](http://news.dartlang.org/2016/11/flutter-best-mobile-development.html)

## Extension libraries

## 扩展库

The StageXL library provides everything you need to render graphics, play audio, load resource files, do animations and much more. But there are other features you may need for your game or application. Therefore StageXL can be extended with more specialized features which are available in extra packages. The following extensions are available on GitHub as well as on [Pub](https://pub.dartlang.org/).

StageXL 库提供了渲染图形、播放音频、加载资源文件、
做动画等所需的一切。但你的游戏或应用可能还需要其他特性。
因此 StageXL 可以用额外 package 中更专门的特性来扩展。
以下扩展在 GitHub 和 [Pub](https://pub.dartlang.org/)
上都可以获取。

**[StageXL_Spine](https://github.com/bp74/StageXL_Spine):** [Spine](http://esotericsoftware.com/) is dedicated to 2D skeletal animation, providing an efficient workflow both for creating amazing animation and for integrating it into your games. Spine provides numerous tools to shape and refine your 2D animations. Bend and deform images with mesh skinning/weights, adjust timing with the dopesheet, visualize motion with ghosting, pose your characters with inverse kinematics, create pseudo 3D effects, and much more. ([demo](http://www.stagexl.org/show/spine/raptor/example.html))

**[StageXL_Spine](https://github.com/bp74/StageXL_Spine)：**
[Spine](http://esotericsoftware.com/) 专注于 2D 骨骼动画，
为创作精彩动画和把动画集成进游戏提供高效工作流。
Spine 提供大量工具来塑造和打磨 2D 动画：
用网格蒙皮/权重弯曲和变形图像、用摄影表调整时间、
用重影可视化运动、用反向动力学给角色摆姿势、
创建伪 3D 效果等等。
（[演示](http://www.stagexl.org/show/spine/raptor/example.html)）

**[StageXL_DragonBones](https://github.com/bp74/StageXL_DragonBones):** [DragonBones](http://dragonbones.com/) is an open source 2D skeleton animation solution very popular among Flash and Starling developers. The editor is available for Mac and Windows and does not require Adobe Flash. DragonBones may not be as feature rich as Spine, but provides enough functionality for most use cases. ([demo](http://www.stagexl.org/show/dragonbones/dragon_new/example.html))

**[StageXL_DragonBones](https://github.com/bp74/StageXL_DragonBones)：**
[DragonBones](http://dragonbones.com/) 是开源 2D 骨骼动画方案，
在 Flash 和 Starling 开发者中很流行。
编辑器支持 Mac 和 Windows，不需要 Adobe Flash。
DragonBones 也许不如 Spine 功能丰富，
但对大多数用例来说功能足够。
（[演示](http://www.stagexl.org/show/dragonbones/dragon_new/example.html)）

**[StageXL_GAF](https://github.com/bp74/StageXL_GAF):** [GAF](http://www.gafmedia.com/) stands for Generic Animation Format. GAF is designed to store Flash animations in an open cross-platform format for further playback. GAF enables artists and animators to use Adobe Flash for creating complex animations and seamlessly use those animations in StageXL. ([demo](http://www.stagexl.org/show/gaf/skeleton/example.html))

**[StageXL_GAF](https://github.com/bp74/StageXL_GAF)：**
[GAF](http://www.gafmedia.com/) 是 Generic Animation Format
（通用动画格式）的缩写。GAF 旨在以开放的跨平台格式
存储 Flash 动画供后续播放。GAF 让美术和动画师
用 Adobe Flash 创作复杂动画，
并无缝地在 StageXL 中使用这些动画。
（[演示](http://www.stagexl.org/show/gaf/skeleton/example.html)）

**[StageXL_BitmapFont](https://github.com/bp74/StageXL_BitmapFont):** [Bitmap fonts](http://kvazars.com/littera/) are created with specialized tools or even designed in PhotoShop to render fancy looking texts. The glyphs are stored on a texture to render texts very efficiently at runtime. The StageXL bitmap font library also supports features like [distance fields](http://www.stagexl.org/show/bitmapfont/distance_field/example.html) for sharp edges when scaling or rotating the text. ([demo](http://www.stagexl.org/show/bitmapfont/texture_atlas/example.html))

**[StageXL_BitmapFont](https://github.com/bp74/StageXL_BitmapFont)：**
[位图字体](http://kvazars.com/littera/)用专门工具创建，
甚至可以在 PhotoShop 中设计，用来渲染漂亮的文本。
字形存储在纹理上，运行时能高效渲染文本。
StageXL 位图字体库还支持
[距离场](http://www.stagexl.org/show/bitmapfont/distance_field/example.html)
等特性，缩放或旋转文本时边缘依然锐利。
（[演示](http://www.stagexl.org/show/bitmapfont/texture_atlas/example.html)）

<DashImage src="images/1mImI5oveZ9ohWbaxmFXarg.webp" alt="Spine animations rendered with StageXL." caption="Spine animations rendered with StageXL ([demo](http://www.stagexl.org/show/spine/texture-atlas/example.html))" />


## **Links**

## 链接

**StageXL:**
[StageXL on Github](https://github.com/bp74/StageXL)
[StageXL examples on Github](https://github.com/bp74/StageXL_Samples)
[StageXL API Reference](http://www.stagexl.org/docs/api/stagexl/stagexl-library.html)
[StageXL Forum](https://groups.google.com/forum/#!forum/stagexl)

**StageXL：**
[Github 上的 StageXL](https://github.com/bp74/StageXL)
[Github 上的 StageXL 示例](https://github.com/bp74/StageXL_Samples)
[StageXL API 参考](http://www.stagexl.org/docs/api/stagexl/stagexl-library.html)
[StageXL 论坛](https://groups.google.com/forum/#!forum/stagexl)

**Runtimes:**
[StageXL Spine runtime](https://github.com/bp74/StageXL_Spine)
[StageXL DragonBones runtime
StageXL GAF runtime](https://github.com/bp74/StageXL_GAF)
[StageXL Bitmap Fonts](https://github.com/bp74/StageXL_BitmapFont)

**运行时：**
[StageXL Spine 运行时](https://github.com/bp74/StageXL_Spine)
[StageXL DragonBones 运行时
StageXL GAF 运行时](https://github.com/bp74/StageXL_GAF)
[StageXL 位图字体](https://github.com/bp74/StageXL_BitmapFont)

**Games:**
[Memory](http://www.stagexl.org/example/game/memory) ([source](http://www.stagexl.org/example/game/memory/))
[Escape (ported from Flash)](http://www.stagexl.org/example/game/escape) ([source](https://github.com/bp74/StageXL_Samples/tree/master/example/game/escape))
[Supersonic (ported from Flash)](http://www.stagexl.org/example/game/supersonic) ([source](https://github.com/bp74/StageXL_Samples/tree/master/example/game/supersonic))

**游戏：**
[Memory](http://www.stagexl.org/example/game/memory)（[源码](http://www.stagexl.org/example/game/memory/)）
[Escape（从 Flash 移植）](http://www.stagexl.org/example/game/escape)（[源码](https://github.com/bp74/StageXL_Samples/tree/master/example/game/escape)）
[Supersonic（从 Flash 移植）](http://www.stagexl.org/example/game/supersonic)（[源码](https://github.com/bp74/StageXL_Samples/tree/master/example/game/supersonic)）

**Benchmarks:**
[Bunny Mark](http://www.stagexl.org/example/benchmark/bunny_mark)
[Starling](http://www.stagexl.org/example/benchmark/starling/)

**基准测试：**
[Bunny Mark](http://www.stagexl.org/example/benchmark/bunny_mark)
[Starling](http://www.stagexl.org/example/benchmark/starling/)

**Community projects:**
[Flash/ActionScript to StageXL/Dart converter](https://github.com/blockforest/stagexl-converter-pubglobal)
[Rockdot framework (UI and more)](https://github.com/blockforest/rockdot-framework)

**社区项目：**
[Flash/ActionScript 到 StageXL/Dart 转换器](https://github.com/blockforest/stagexl-converter-pubglobal)
[Rockdot 框架（UI 及更多）](https://github.com/blockforest/rockdot-framework)
