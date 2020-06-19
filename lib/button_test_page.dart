import 'package:flutter/material.dart';

///
/// FloatingActionButton按钮测试 和  普通 RaisedButton按钮测试
///
class ButtonTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // 前景色,也就是图标的颜色
        foregroundColor: Colors.amber,
        // 背景色
        backgroundColor: Colors.red,
        // 指定形状,可以使用属性shape
        // shape: ,

        // 未点击时候的阴影
        elevation: 20,

        // 点击时候的阴影
        highlightElevation: 50,

        child: Icon(Icons.select_all),
        onPressed: () {
          print('1111222');
        },
      ),

      // 设置 floatingActionButton的位置.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),

          // 想要写一个按钮,平铺整个屏幕
          // 就先写一个Row, Row组件默认的 MainAxisSize mainAxisSize = MainAxisSize.max,
          // 然后内部嵌套一个Expand, 就直接占满Row了
          // 里面再写RaisedButton即可.如果想要指定高度,就需要加一个Container就好了
          Row(
            children: <Widget>[
              Expanded(
//                child: Container(
//                  margin: EdgeInsets.all(20),
//                  height: 100,
                child: RaisedButton(
                  child: Text('1111'),
                  color: Colors.amberAccent,
                  onPressed: () {
                    print('11122');
                  },
//                  ),
                ),
              )
            ],
          ),

          // 带Icon的Button
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {
              print('sss');
            },
          ),

          // 按钮栏, 没啥用
          ButtonBar(
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}

///
/// 自定义自己的Button, 直接组合RaiseButton就好了, 一般不继承RaisedButton
///
class MyButton extends RaisedButton {}

class MyButton2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
