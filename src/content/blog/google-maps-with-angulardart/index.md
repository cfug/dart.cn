---
# title: "Google Maps with AngularDart"
title: "用 AngularDart 集成 Google Maps"
# description: "In this article we will integrate Google Maps with an AngularDart application. The app itself will be very simple: it calculates the great…"
description: "在本文中，我们将把 Google Maps 集成到一个 AngularDart 应用中。应用本身非常简单：它计算地图上两个选定标记之间的大圆距离。"
ai-translated: true
publishDate: 2017-02-23
author: isoos
image: images/1hLce2qgbJEkxjOlOr8jn9g.webp
category: other
skipTemplateRendering: true
layout: blog
---


In this article we will integrate Google Maps with an AngularDart application. The app itself will be very simple: it calculates the [great circle distance](https://en.wikipedia.org/wiki/Great-circle_distance) (the shortest distance on the surface of a sphere) between two selected markers on the map.

在本文中，我们将把 Google Maps 集成到一个 AngularDart 应用中。
这个应用本身非常简单：它计算地图上两个选定标记（marker）之间的
[大圆距离](https://en.wikipedia.org/wiki/Great-circle_distance)
（great circle distance，即球面上两点之间的最短距离）。

Along the way you will:

在这个过程中，你将：

* Register your own Google Maps API key.

  注册你自己的 Google Maps API 密钥（key）。

* Create a barebones Angular web application.

  创建一个最简的 Angular Web 应用。

* Integrate Dart with the Google Maps JavaScript API, and handle the maps interaction.

  将 Dart 与 Google Maps JavaScript API 集成，并处理地图交互。

* Learn some polishing tips for the Angular component.

  学习一些打磨 Angular 组件的小技巧。

This article is roughly four times longer than the code. If you want, just go look at the complete [**source code**](https://github.com/isoos/google_maps_angular_dart) and the final [**demo**](https://isoos.github.io/google_maps_angular_dart/).

这篇文章的篇幅大约是代码的四倍。如果你愿意，
可以直接去看完整的[**源代码**](https://github.com/isoos/google_maps_angular_dart)
和最终的[**演示**](https://isoos.github.io/google_maps_angular_dart/)。

<DashImage src="images/1hLce2qgbJEkxjOlOr8jn9g.webp" alt="Google Maps demo showing markers near Paris and Rome with a calculated distance of 1095 km." caption="Screenshot of the demo" />


## Google Maps JavaScript API

## Google Maps JavaScript API

The [Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript/) allows developers to embed and integrate Google Maps on their site. You can customize the displayed map’s content and handling with your own imagery, data and processing.

[Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript/)
允许开发者在自己的网站上嵌入并集成 Google Maps。
你可以用自己的图像、数据和处理逻辑，
定制所显示地图的内容与交互方式。

To start developing with the Google Maps API, you must register a free API key that allows a reasonable amount of usage. As your application gets more traction, you can upgrade it to a paid plan.

要开始使用 Google Maps API 进行开发，
你必须注册一个免费的 API 密钥，它允许合理额度的用量。
当你的应用获得更多用户后，可以升级到付费计划。

Visit the [JavaScript API page](https://developers.google.com/maps/documentation/javascript/), and at the top of the page, click `GET A KEY`. Create a name for your project and click `CREATE AND ENABLE API`:

访问 [JavaScript API 页面](https://developers.google.com/maps/documentation/javascript/)，
在页面顶部点击 `GET A KEY`。
为你的项目起一个名字，然后点击 `CREATE AND ENABLE API`：

<DashImage src="images/1cPMKvi22U5csti4Dubb-4A.webp" alt="A dialog box with the title 'Enable Google Maps JavaScript API' and a text field with 'My Dart Map Project' entered." />


Your key will be enabled and ready to use in a couple of seconds:

几秒钟后，你的密钥就会被启用并可以使用：

<DashImage src="images/18Opaixc6Ardgd0wYKyvKNw.webp" alt="A success message 'You're all set!' in the Google Maps API console showing that the API key is ready to use." />


Note your API key. We’ll use it when we fetch the Maps JavaScript library:

记下你的 API 密钥。我们在加载 Maps JavaScript 库时会用到它：

```
https://maps.googleapis.com/maps/api/js?key=KEY_GOES_HERE
```


In JavaScript, to create a map instance and place a marker on it, we’d use the following code:

在 JavaScript 中，要创建一个地图实例并在上面放置一个标记，
我们会使用下面这段代码：

```js
var hostElement = document.getElementById('map-id');
var map = new google.maps.Map(hostElement, {
  zoom: 2,
  center: {lat: 47.4979, lng: 19.0402}
});
var marker = new google.maps.Marker({
  position: {lat: 47.4979, lng: 19.0402},
  map: map,
  label: 'A'
});
```


As you will see later, the Dart code will be very similar (with all of the added benefits of Dart).

稍后你会看到，Dart 代码会非常相似（还附带 Dart 的全部优势）。

## The AngularDart Application

## AngularDart 应用

The easiest way to get started with an AngularDart application is to follow the [Get Started](https://webdev.dartlang.org/guides/get-started) guide and [create a new project](https://webdev.dartlang.org/guides/get-started#4-create-and-run-a-web-app) in WebStorm or in the Community Edition of IntelliJ IDEA.

上手 AngularDart 应用最简单的方式，
是遵循[入门指南](https://webdev.dartlang.org/guides/get-started)，
在 WebStorm 或 IntelliJ IDEA 社区版中
[创建一个新项目](https://webdev.dartlang.org/guides/get-started#4-create-and-run-a-web-app)。

In case you are using a different editor, or you just want to follow the structure of our example code, here is the bare minimum.

如果你使用的是其他编辑器，或者只是想照着示例代码的结构来，
下面就是所需的最少内容。

In the pubspec file, `pubspec.yaml`:

在 pubspec 文件 `pubspec.yaml` 中：

```
name: google_maps_angular_dart
version: 0.0.1
description: Angular application with Google Maps integration

environment:
  sdk: '>=1.19.0 <2.0.0'

dependencies:
  angular2: ^2.2.0

dev_dependencies:
  dart_to_js_script_rewriter: ^1.0.1

transformers:
- angular2:
    platform_directives:
      - 'package:angular2/common.dart#COMMON_DIRECTIVES'
    platform_pipes:
      - 'package:angular2/common.dart#COMMON_PIPES'
    entry_points: web/main.dart
- dart_to_js_script_rewriter
```


In the host page, `web/index.html`:

在宿主页面 `web/index.html` 中：

```
<!DOCTYPE html>
<html>
<head>
    <!-- other headers -->
    <script defer src="main.dart" type="application/dart"></script>
</head>
<body>
   **<map-control></map-control>**
</body>
</html>
```


In the app’s entry point, `web/main.dart`:

在应用的入口文件 `web/main.dart` 中：

```
import 'package:angular2/platform/browser.dart';
import 'package:google_maps_angular_dart/component/map_control.dart';

void main() {
  bootstrap(MapControl);
}
```


In the Dart file for the `&lt;map-control&gt;` component, `lib/component/map_control.dart`:

在 `&lt;map-control&gt;` 组件的 Dart 文件
`lib/component/map_control.dart` 中：

```
import 'package:angular2/core.dart';

@Component(
  selector: 'map-control',
  template: '{{distance}}',
)
class MapControl {
  String distance = 'no distance yet';
}
```


The above code won’t do too much, but it is a start and you can run it by using `pub serve` and then opening the page in Dartium:

上面的代码做不了太多事情，但这是个开始。
你可以运行 `pub serve`，然后在 Dartium 中打开页面来运行它：

```
$ pub serve
Loading source assets...
Loading angular2 and dart_to_js_script_rewriter transformers...
Serving google_maps_angular_dart web on [http://localhost:8080](http://localhost:8080)
Build completed successfully
```


## Google Maps integration

## 集成 Google Maps

To start with the Google Maps integration, put the following script tag into your `web/index.html`. Notice that you need to set your API key:

要开始集成 Google Maps，把下面的 script 标签放进你的 `web/index.html`。
注意，你需要填入自己的 API 密钥：

```
<script src="https://maps.googleapis.com/maps/api/js?key=**[YOUR_KEY_HERE]**"></script>
```


Fortunately there is a ready-to-use Google Maps Dart package on pub. Add it to your `pubspec.yaml`:

幸运的是，pub 上有一个开箱即用的 Google Maps Dart package。
把它添加到你的 `pubspec.yaml` 中：

```
dependencies:
  angular2: ^2.2.0
  **google_maps: ^3.0.0**
```


Then run `pub get` to download the package.

然后运行 `pub get` 下载这个 package。

We need to create a host element for the map area in our component template. We will start with basic styling, and use the `#mapArea` anchor to identify the element in the next step:

我们需要在组件模板中为地图区域创建一个宿主元素。
先加上基本样式，并使用 `#mapArea` 锚点，
以便在下一步中识别这个元素：

```
<div style="width: 300px; height: 300px" #**mapArea**>[map]</div>
```


In the component code, we can inject the element’s reference as follows:

在组件代码中，我们可以像下面这样注入该元素的引用：

```
@ViewChild('mapArea')
ElementRef mapAreaRef;
```


The element reference is not available immediately after the MapControl class has been created, so we need to hook into Angular’s lifecycle callbacks:

MapControl 类刚创建时，元素引用还不可用，
所以我们需要挂接 Angular 的生命周期回调（lifecycle callback）：

```
class MapControl **implements AfterViewInit** {

  @override
  void ngAfterViewInit() {
    // mapAreaRef is available now
  }
}
```


Tip: use the IDE to write the method bodies for you. For example, in IntelliJ, hit `CMD + N` (or `CTRL + N`), and select the “Implement Methods…” menu item. It will allow you to select the missing methods and you need to worry only about the method body:

提示：让 IDE 帮你生成方法体。例如在 IntelliJ 中，
按下 `CMD + N`（或 `CTRL + N`），选择 “Implement Methods…” 菜单项。
它会让你选择缺失的方法，你只需要关心方法体本身：

<DashImage src="images/1V9N-6dAV8vZjuT6cI1Sftw.webp" alt="A context menu in IntelliJ IDEA showing 'Generate' options like 'Constructor', 'Getter', and 'Implement Methods...'." />


As the following code shows, the Dart API is very similar to to the JavaScript one, with the added benefit that it is type checked.

如下面的代码所示，Dart API 与 JavaScript API 非常相似，
额外的好处是它有类型检查。

```
class MapControl implements AfterViewInit {
  // ...

@override
  void ngAfterViewInit() {
    GMap map = new GMap(
        mapAreaRef.nativeElement,
        new MapOptions()
          ..zoom = 2
          ..center = new LatLng(47.4979, 19.0402)
                             // ^ Budapest, Hungary
        );
    new Marker(new MarkerOptions()
      ..map = map
      ..position = new LatLng(47.4979, 19.0402)
      ..label = 'A');
  }
}
```


One example of the benefits of type checking is that when we listen for events, we don’t need to think about how to access properties. For example, the IDE can help us find the MouseEvent property (`latLng`) that holds the location of the marker.

类型检查好处的一个例子是：监听事件时，
我们不需要费心思考如何访问属性。
例如，IDE 可以帮我们找到 MouseEvent 上
保存标记位置的属性（`latLng`）。

Here is the code that reacts to dragging the marker:

下面是响应拖动标记的代码：

```
    marker.onDrag.listen((MouseEvent event) {
      print('New location while dragging: ${event.latLng}');
    });
```


Capturing click events on the map is similar:

捕获地图上的点击事件也类似：

```
    map.onClick.listen((MouseEvent event) {
      print('User clicked on position: ${event.latLng}');
    });
```


## Putting it together

## 把它们组合起来

To measure the distance between two coordinates, we will track two markers on the map. The user shall be able to drag the markers around or place them by clicking.

要测量两个坐标之间的距离，我们会在地图上跟踪两个标记。
用户应该能够拖动标记，或者通过点击来放置它们。

We need to keep track of the map and the markers as fields:

我们需要用字段来记录地图和标记：

```
  GMap _map;
  Marker _aMarker;
  Marker _bMarker;
```


Update the initialization to store the map reference and to register a click handler. The click handler updates the marker positions and the distance:

更新初始化代码，保存地图引用并注册点击处理器。
点击处理器会更新标记位置和距离：

```
  @override
  void ngAfterViewInit() {
    **_map** = new GMap(
        mapAreaRef.nativeElement,
        new MapOptions()
          ..zoom = 2
          ..center = new LatLng(47.4979, 19.0402)
                             // ^ Budapest, Hungary
        );
    **_map.onClick**.listen((MouseEvent event) {
      **_updatePosition**(event.latLng);
      **_updateDistance**();
    });
  }
```


Here is the code for the first part of the click handler:

下面是点击处理器第一部分的代码：

```
  void _updatePosition(LatLng position) {
    if (_aMarker == null) {
      _aMarker = _createMarker(_map, 'A', position);
    } else if (_bMarker == null) {
      _bMarker = _createMarker(_map, 'B', position);
    } else {
      _aMarker.position = _bMarker.position;
      _bMarker.position = position;
    }
  }
```


The code for marker instantiation is similar to the earlier example:

实例化标记的代码与前面的示例类似：

```
  Marker _createMarker(GMap map, String label, LatLng position) {
    final Marker marker = new Marker(new MarkerOptions()
      ..map = map
      ..draggable = true
      ..label = label
      ..position = position);
    marker.onDrag.listen((MouseEvent event) {
      _updateDistance();
    });
    return marker;
  }
```


With the help of utility functions from `dart:math`, we are able to crunch through the mathematics of the great circle distance calculation, and set the value in our `distance` field:

借助 `dart:math` 中的工具函数，
我们就能完成大圆距离计算的数学运算，
并把结果设置到 `distance` 字段中：

```
  /// Radius of the earth in km.
  const int radiusOfEarth = 6371;

double _toRadian(num degree) => degree * PI / 180.0;

void _updateDistance() {
    if (_aMarker == null || _bMarker == null) return;
    LatLng a = _aMarker.position;
    LatLng b = _bMarker.position;
    double dLat = _toRadian(b.lat - a.lat);
    double sLat = pow(sin(dLat / 2), 2);
    double dLng = _toRadian(b.lng - a.lng);
    double sLng = pow(sin(dLng / 2), 2);
    double cosALat = cos(_toRadian(a.lat));
    double cosBLat = cos(_toRadian(b.lat));
    double x = sLat + cosALat * cosBLat * sLng;
    double d = 2 * atan2(sqrt(x), sqrt(1 - x)) * radiusOfEarth;
    distance = '${d.round()} km';
  }
```


Have you ever wondered how far do you live from a relative, a famous location or a landmark? It is time to try out the application and check it for yourself. It turns out that my home is 9815 km from Google Headquarters in Mountain View:

你有没有想过，自己住的地方离亲戚、某个著名地点或地标有多远？
是时候试用这个应用，亲自验证一下了。
结果发现，我家距离位于山景城（Mountain View）的
Google 总部有 9815 公里：

<DashImage src="images/1AOtq_2d-f5cETtXb-ixzYA.webp" alt="Map showing the distance between Googleplex in Mountain View, California and the author's home in Budapest, Hungary." caption="The distance between Googleplex in Mountain View, California and the author’s home in Budapest, Hungary" />


## Polishing the application

## 打磨应用

The Google Maps integration in our Angular app is complete at this point. We are listening and reacting to map events and creating objects on the map. In this last section we will implement features that add a nice finish for our demo.

到这里，我们的 Angular 应用与 Google Maps 的集成就完成了。
我们已经能监听并响应地图事件，还能在地图上创建对象。
在最后这一节，我们将实现一些功能，为演示做个漂亮的收尾。

### Separate template and style

### 分离模板和样式

It is a good practice to put complex UI template in a separate .html file. We can do the same with CSS styles:

把复杂的 UI 模板放到单独的 .html 文件中是一种良好实践。
CSS 样式也可以同样处理：

```
@Component(
    selector: 'map-control',
    templateUrl: 'map_control.html',
    styleUrls: const <String>['map_control.css'])
class MapControl implements AfterViewInit {
```


The map element has a CSS class, map-area:

地图元素有一个 CSS 类：map-area：

```
<div class="map-area" #mapArea>[map]</div>
```


Our CSS file can be as simple as this:

我们的 CSS 文件可以简单成这样：

```
.map-area {
  width: 500px;
  height: 400px;
  margin: 10px;
}
```


### Handling the unit of distance

### 处理距离单位

Some people are fluent in km ⟷ miles conversions, but the rest of us would like a dropdown where we can select the distance unit. In the HTML template the dropdown can be a simple `&lt;SELECT&gt;` element with a model binding to the `unit` field.

有些人对公里 ⟷ 英里的换算很熟练，
但我们其余的人更想要一个可以选择距离单位的下拉框。
在 HTML 模板中，这个下拉框可以是一个简单的 `&lt;SELECT&gt;` 元素，
并与 `unit` 字段建立模型绑定（model binding）。

```
<label>Unit:</label>
<select [(ngModel)]="**unit**">
  <option value="km">km</option>
  <option value="miles">miles</option>
</select>
```


In the Dart code, we want to store the unit and to update the distance whenever the unit is updated:

在 Dart 代码中，我们要保存单位，并在单位更新时同步更新距离：

```
String _unit = 'km';

String get unit => _unit;

set unit(String value) {
  _unit = value;
  _updateDistance();
}
```


And don’t forget to update the previously hardcoded `km` in the distance calculation:

另外别忘了更新距离计算中之前硬编码的 `km`：

```
    /// Const value to convert from km to miles.
    const double milesPerKm = 0.621371;

    // ... same code as earlier
    if (unit == 'miles') {
      d *= milesPerKm;
    }
    distance = '${d.round()} $unit';
```


### Formatting the coordinates

### 格式化坐标

What if we are interested in publishing the position of our markers? The easiest way would be to expose the position values in Dart, so we can use `{{a}}` and `{{b}}` in our template:

如果我们想展示标记的位置呢？
最简单的办法是在 Dart 中暴露位置值，
这样就可以在模板中使用 `{{a}}` 和 `{{b}}`：

```
  // Expose the position values.
  LatLng get a => _aMarker?.position;
  LatLng get b => _bMarker?.position;
```


The template can hide the label when the marker is not initialized yet, preventing potential issues with null values:

当标记尚未初始化时，模板可以隐藏标签，
避免 null 值可能带来的问题：

```
  <div *ngIf="a != null">A: {{a}}</div>
  <div *ngIf="b != null">B: {{b}}</div>
```


However, `{{a}}` would translate to calling `LatLng.toString()`, and it would give us two really long double values, whereas a few digits would be just fine. One solution is to use pipes in the template:

不过，`{{a}}` 会被转换为调用 `LatLng.toString()`，
得到两个非常长的 double 值，而其实保留几位小数就够了。
一种解决办法是在模板中使用管道（pipe）：

```
<div *ngIf="a != null">A: {{a.lat | number : '1.4-4'}}, {{a.lng | number : '1.4-4'}}</div>
<div *ngIf="b != null">B: {{b.lat | number : '1.4-4'}}, {{b.lng | number : '1.4-4'}}</div>
```


The [template syntax guide](https://webdev.dartlang.org/angular/guide/template-syntax) suggests placing that logic in the controller class, for better testing:

[模板语法指南](https://webdev.dartlang.org/angular/guide/template-syntax)
建议把这类逻辑放到控制器类中，以便于测试：

```
  /// Formatted position of the 'A' marker.
  String get **aPosition** => _formatPosition(a);

  /// Formatted position of the 'B' marker.
  String get bPosition => _formatPosition(b);

  String _formatPosition(LatLng pos) {
    if (pos == null) return null;
    return '${pos.lat.toStringAsFixed(4)}, ' 
        '${pos.lng.toStringAsFixed(4)}';
  }
```


With that, the template can be much simpler:

这样一来，模板就可以简单得多：

```
<div *ngIf="a != null">A: {{**aPosition**}}</div>
<div *ngIf="b != null">B: {{**bPosition**}}</div>
```


### Clean up the template

### 清理模板

As a last step, move all of the remaining code parts from the template to the controller:

最后一步，把模板中剩余的所有代码逻辑都移到控制器中：

```
  /// Whether the 'A' marker's positions should be shown
  bool get **showA** => a != null;

  /// Whether the 'B' marker's positions should be shown
  bool get showB => b != null;

  /// Whether the 'distance' label should be shown
  bool get showDistance => distance != null;
```


Doing so, the template references only the getters:

这样，模板就只引用 getter 了：

```
<div *ngIf="**showA**">A: {{aPosition}}</div>
<div *ngIf="**showB**">B: {{bPosition}}</div>

<p *ngIf="showDistance">
  Distance: {{distance}}<br/>
</p>
```


## Closing notes

## 结束语

As you can see, implementing two-way integration with Google Maps is easy: the source code is clean and readable. With the full support of the Dart toolchain, it is easily extensible, without ever worrying about what we may break at other places.

如你所见，实现与 Google Maps 的双向集成很容易：
源代码干净且易读。在 Dart 工具链的全面支持下，
它很容易扩展，完全不用担心会破坏其他地方的功能。

As an exercise for the reader, you can add [heatmap visualization](https://developers.google.com/maps/documentation/javascript/earthquakes#heatmaps) to the map using the same API in Dart. Check out the [google_maps](https://pub.dartlang.org/packages/google_maps) package for all of the possibilities.

留给读者的练习：你可以在 Dart 中使用同一套 API，
为地图添加[热力图可视化](https://developers.google.com/maps/documentation/javascript/earthquakes#heatmaps)。
查看 [google_maps](https://pub.dartlang.org/packages/google_maps) package，
了解全部的可能性。
