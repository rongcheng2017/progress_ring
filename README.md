<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

简单的实现环形进度条。

## Features

![WX20220315-191757.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/393cc5c78c3b4b67a3cc4fd0550722f4~tplv-k3u1fbpfcp-watermark.image?)


## Getting started

```dart
dependencies:
  flutter:
    sdk: flutter

 //添加依赖
  progress_ring: ^0.0.3  
```

## Usage



```dart
import 'package:flutter/material.dart';
import 'package:progress_ring/progress_ring.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const ProgressRingPage(),
    );
  }

}

class ProgressRingPage extends StatefulWidget {
  const ProgressRingPage({Key? key}) : super(key: key);

  @override
  State<ProgressRingPage> createState() => _ProgressRingPageState();
}

class _ProgressRingPageState extends State<ProgressRingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("progress..")),
      body: const Center(
          //引入
        child: ProgressRing(
         	//尺寸
          size: Size(100, 100),
			//动画时长
          duration: Duration(seconds: 1),
			//百分比数值 0.00~1.00之间
          value: 0.6,
			//百分比背景环颜色
          circularRingColor: Color(0xFFF4F4F4),
			//进度条颜色
          progressColor:Color(0xFF1678FF),
			//百分比文案样式
          textStyle:  TextStyle(color: Color(0xFF111A34),fontSize: 16),
      //progerssController: _progressController,
        ),
      ),
    );
  }
}


```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
