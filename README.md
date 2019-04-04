# debit
&emsp;&emsp;Flutter 自从2018年底发布1.0 以来，热度一直居高不下，虽然现在目前许多公司并没有使用这个平台，毕竟公司追求的是稳定，但是我认为 Flutter 从目前各个方面的性能来看应该是大势所趋，所以也就研究并实战了 Flutter 技术。
&emsp;&emsp;经过一个多月的学习和编码，终于完成了一个完整的 Flutter 项目。完成这个项目还是收获颇丰。不管是 Widget 组件的使用，还是 Flutter 状态的刷新，都有耳目一新的感觉。由于一直没有接触过 IOS 开发，对 IOS 的打包、签名和安装都有了一个突破性的认识。应该来说，通过这个小项目，让我对移动开发有了一个较为深入的理解。
&emsp;&emsp;下面列出几个我认为比较重要并且是难点的地方。
项目大致包括：
- 自定义的拖动条
- 跑马灯
- 图片的选择和相机的使用
- 省份选择器
- 状态管理 Flutter_redux 的使用
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190404195826688.gif)


 ## 一.Widget 控件的使用
 [Flutter 常用框架](https://pub.dartlang.org/packages)
 [Flutter 之 常用按钮控件集锦一](https://zhuanlan.zhihu.com/p/38500192)
 
在 Android 中，View 是屏幕上显示的所有内容的基础。在 Flutter 中，View 相当于 Widget 。然而，与 View 相比，Widget 有一些不同之处。首先，Widget 仅支持一帧，并且在每一帧上，Flutter 的框架都会创建一个 Widget实例树。相比之下，在 Android 上 View 绘制结束后，就不会重绘，直到调用 invalidate 时才会重绘。

在 Android 中，你可以通过直接对 View 进行改变更新视图。然而，在 Flutter 中 Widget 是不可变的，不会直接更新，而必须使用 Widget 的状态。这是 Stateful 和 Stateless Widget 的概念的来源。一个 Stateless Widget 就想它的名字，是一个没有状态信息的 Widget。如果你希望通过 HTTP 动态请求的数据更改用户界面，则必须使用 Stateful Widget ，并告诉 Flutter 框架该 Widget ，并告诉 Flutter 框架该 Widget的状态已更新，以便可以更新该 Widget。有状态和无状态 Widget 核心是一样的，每一帧它们都会重新构建，不同之处在于 Stateful Widget 有一个 State 对象，它可以跨帧存储状态数据并恢复它。

Flutter 的 Widget 的其他具体细节需间项目。
 ## 二.Flutter_redux 的使用
 Flutter 的许多灵感是来自 React ，它的设计思路是数据与视图分离，由数据映射渲染视图。所以在 Flutter 中，它的 Widget 是 immutable 的，而它的动态部分全部放到了状态（state）中。于是状态管理自然便成了我们密切关注的对象。

在我们一开始构建应用的时候，是很简单。我们的一些状态，直接把他们映射成视图就可以了。这种简单的的状态不需要状态管理。但是随着功能的增加，应用程序将会有几十个甚至上百个状态。这个时候我们就很难在清楚的测试维护我们的状态，因为它看上去是在是太复杂了！而且还会有多个页面共享一个状态，例如像本项目的，当你成功上传自己的信息时，会返回的上一个界面，上一个界面会显示你上传成功的信息，这个时候就需要同步这两个状态。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190404203530247.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dhbmxpZ3VvZHU=,size_16,color_FFFFFF,t_70)
- 我们在Redux中，所有的状态都存储在 **Store** 里，这个 Store 户放在 APP 顶层。
- View 拿到 Store 存储的状态（State）并把它映射成视图。View 还会与用户进行交互，用户点击按钮滑动屏幕等，这时会因为交互需要数据发生改变。
- Redux 让我们不能让 View 直接操作数据，而是通过一个 action 来告诉 Reducer ，状态得以改变。
- 这个时候 Reducer 接收到了这个 action ，它就回去遍历 action表，然后找到那个匹配的 action ，根据 action 生成新的状态并把新的状态放到 Store 中。
- Store 丢掉了老的状态对象，存储了新的对象后，就通知所有使用到这个状态的 View 更新（类似 setState） ，这样我们就可以同步不同 View 中的状态了。

具体是使用过程可见本项目的用户信息状态的改变。
 ## 三.dio 网络框架的使用
 这一部分在 Flutter 中文官网上讲的已经非常清楚多了，直接给出连接：
 [在Flutter中发起HTTP网络请求](https://flutterchina.club/networking/)
 [JSON和序列化](https://flutterchina.club/json/)
 ## 四.IOS 的签名过程
IOS 的打包 ----> 签名 ----> 分发 ，我可是费了很大力气。首先，最好有 Mac 电脑，我开始本来用虚拟机上安装Mac系统，但是，当我费了九牛二虎之力成功安装 Mac 系统后，XCode 就是怎么也安装不上，没法我只好借用同事的 Mac 电脑。安装 Flutter 中文官网上，入门: [在macOS上搭建Flutter开发环境](https://flutterchina.club/setup-macos/)，这个过程中也遇到许多问题，都可以用百度或google来解决。

### 4.1打包
我使用的XCode 10.1进行打包 ipa ,你最好有一个 iOS Developer 开发者账号，这个账号可以不用付费。这个账号可以用来Xcode 自带的虚拟机进行测试。但是真机是测试不了的，必须是已付费的账号或经过第三方进行签名才可以。接下来，我们怎么得到打包的文件呢？
首先，我们先在终端使用命名生成一个 Runner.app:
```
flutter build ios
```
输出结果：
```
Building "com.bat.debit" for device (ios-release)...
Automatically signing iOS for device deployment using specified development team in Xcode project: xxxxxxx
Running pod install...                                       1.3s
Starting Xcode build...                                          
 ├─Building Dart code...                             26.7s                                                                                                                                                                                                                        
 ├─Generating dSYM file...                            0.9s                                                                                                                                                                                                                        
 ├─Stripping debug symbols...                         0.7s                                                                                                                                                                                                                        
 ├─Assembling Flutter resources...                    1.2s                                                                                                                                                                                                                        
 └─Compiling, linking and signing...                 15.3s                                                                                                                                                                                                                        
Xcode build done.                                           54.3s
Built /Users/xxx/Code/Flutter/fluwx/example/build/ios/iphoneos/Runner.app.
```
然后找到 **/Users/xxx/Code/Flutter/fluwx/example/build/ios/iphoneos/Runner.app** 这个文件，
可以用 **open /Users/xxx/Code/Flutter/fluwx/example/build/ios/iphoneos**打开这个文件夹，然后我们要创建一个名为Playload的文件夹，注意名字不能错，然后把Runner.app粘贴到Playload文件下，然后对Playload压缩成.zip。然后将Runner.zip重命名为Runner.ipa 。

### 4.2 签名
这时这个 Runner.ipa 就可以交给第三方或是某包上进行签名，拿到签名后就需要分发了。
### 4.3 分发
自定义分发的话可以看，[iOS app分发](https://www.jianshu.com/p/7143892939d6)这篇文章，还是比较复杂的。
我选择的是用第三方的分发网站，如:[财神分发](https://cn7l.cn)，这个分发有100免费的下载次数，个人测试的也是够用了。
