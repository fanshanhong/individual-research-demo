import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 针对 TextEditingController 的测试
///
class ControllerTestPage extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  final TextEditingController controller2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = '11';

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),

            // RawMaterialButton 是基于[Semantics], [Material], and [InkWell] 创建的一个组件
            // Creates a button based on [Semantics], [Material], and [InkWell]
            // widgets.

            // 对于那些未指定的参数, 这个类 不使用 当前的Theme 或者  ButtonTheme 来作为默认值.
            // This class does not use the current [Theme] or [ButtonTheme] to
            // compute default values for unspecified parameters.

            // 旨在用于自定义的Material Button组件
            // It's intended to be used for custom Material buttons that optionally incorporate defaults
            // from the themes or from app-specific sources.

            // [RaisedButton] and [FlatButton] 是基于 [Theme] and [ButtonTheme] 配置了一个 RawMaterialButton,所以说RawMaterialButton更原始,更底层.
            // [RaisedButton] and [FlatButton] configure a [RawMaterialButton] based
            // on the current [Theme] and [ButtonTheme].
            new RawMaterialButton(
                fillColor: Colors.red,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                padding: const EdgeInsets.all(0.0),
                // 无内边距
                constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                child: Text('一个没有任何修饰的Button,点击将文本设置为"123"'),
                onPressed: () {
                  // tip:这里直接通过修改 controller.value 就可以改变TextField的文本内容
                  // TextEditingController 本质是一个 ValueNotifier
                  // 设置  controller的 value, 如下:
                  //          set value(T newValue) {
                  //            if (_value == newValue)
                  //              return;
                  //            _value = newValue;
                  //            notifyListeners();
                  //          }
                  //调用 notifyListeners()了, 因此不需要setState()

                  controller.value = TextEditingValue(text: "123");
                }),
            new RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.all(0.0),
                constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                child: new Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text('横铺屏幕的按钮,通过[controller.text]修改文本'),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.blueGrey,
                    )
                  ],
                ),
                onPressed: () {
                  // tip:
                  // 设置 TextEditingController 本质是修改 ChangeNotifier 中的value
                  // 也是调用 set value(T newValue)
                  // 内容会调用notifyListeners(), 因此不需要setState()
                  controller.text = 'bbb';
                }),
            Text('用户名'),
            TextField(controller: controller),
            Text('密码'),
            TextField(controller: controller2),
          ],
        ),
      ),
    );
  }
}
