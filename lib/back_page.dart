import 'dart:async';

import 'package:flutter/material.dart';

///
/// 返回的测试
/// Flutter 中 ，通过 WillPopScope 嵌套，可以用于监听处理 Android 返回键的逻辑。其实 WillPopScope 并不是监听返回按键，如名字一般，是当前页面将要被pop时触发的回调。
/// 通过 onWillPop 回调返回的 Future，判断是否响应 pop 。下方代码实现按下返回键时，弹出提示框，按下确定退出App。
///
class BackPage extends StatelessWidget {
  // 弹出对话框提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    // Returns a [Future] that resolves to the value (if any) that was passed to
    // [Navigator.pop] when the dialog was closed.

    // showDialog方法的返回值是一个 Future<T> 对象.
    // 我们可以使用Future.value(value) 来生成一个Future 对象.
    // value 是啥呢?  value 是 当Dialog 被关闭的时候, 传入到 Navigator.pop()方法里的值.

    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              content: new Text("是否退出"),
              actions: <Widget>[
                new FlatButton(onPressed: () => Navigator.of(context).pop('11'), child: new Text("取消")),
                new FlatButton(
                    onPressed: () {
                      // 这样写, showDialog的返回值就是  Future.value(true)
                      Navigator.of(context).pop(true);

                      // 这样写, showDialog的返回值就是  Future.value('aaaa');
                      // Navigator.of(context).pop('aaaa');

                    },
                    child: new Text("确定"))
              ],
            )).then((value) {
      // 因为showDialog返回一个Future<value>,所以能继续then.
      // then()这里的value,就是在Dialog消失的时候, 传入 Navigator.of(context).pop()方法中的参数.
      print('the value is $value');
      return Future.value(value);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 当前页面将要被pop时触发的回调
      onWillPop: () {
        //如果返回 return new Future.value(false); pop 就不会被处理, 返回键点击后就没用
        //如果返回 return new Future.value(true); pop 就会触发, 返回键点击后就会关闭当前页面
        //return Future.value(false);

        //这里可以通过 showDialog 弹出确定框，在返回时通过 Navigator.of(context).pop(true);决定是否退出
        return _dialogExitApp(context);
      },
      child: new Container(),
    );
  }
}
