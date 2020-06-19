import 'package:flutter/material.dart';

///
/// 演示ChangeNotifier使用
///
class ChangeNotifierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangeNotifierState();
  }
}

class ChangeNotifierState extends State<ChangeNotifierPage> {
  // class ChangeNotifier implements Listenable

  // ChangeNotifier 内部为我们维护了一组监听器(观察者), 同时为我们提供了 hasListeners  addListener removeListener 和 notifyListeners这些方法
  //
  //        @protected
  //        bool get hasListeners {
  //          assert(_debugAssertNotDisposed());
  //          return _listeners.isNotEmpty;
  //        }
  //
  //        /// Register a closure to be called when the object changes.
  //        ///
  //        /// This method must not be called after [dispose] has been called.
  //        @override
  //        void addListener(VoidCallback listener) {
  //          assert(_debugAssertNotDisposed());
  //          _listeners.add(listener);
  //        }
  //
  //        @override
  //        void removeListener(VoidCallback listener) {
  //          assert(_debugAssertNotDisposed());
  //          _listeners.remove(listener);
  //        }
  //
  //
  //        @protected
  //        @visibleForTesting
  //        void notifyListeners() {
  //        }

  // 我们可以先添加监听器. 然后在特定的时机调用 notifyListeners 来通知监听器回调.

  // ScrollController就是通过ChangeNotifier来实现的.

  // 另外, 还提供了 ValueNotifier
  // ChangeNotifier 和  ValueNotifier二者的关系如下:
  // class ValueNotifier<T> extends ChangeNotifier implements ValueListenable<T>
  // ValueNotifier 就是比 ChangeNotifier 多维护了一个Value
  //          @override
  //          T get value => _value;
  //          T _value;
  //          set value(T newValue) {
  //            if (_value == newValue)
  //              return;
  //            _value = newValue;
  //            notifyListeners();
  //          }

  // 只要这个 这个value发生变化, 内部会自动调用notifyListeners. 然后监听器就会回调了.
  // TextEditingController 就是通过ValueNotifier来实现的.

  MyChangeNotifier myChangeNotifier = new MyChangeNotifier();

  MyValueNotifier myValueNotifier = new MyValueNotifier(1);

  @override
  void initState() {
    myChangeNotifier.addListener(() {
      // 注册一个监听
      print('ChangeNotifier监听器1号');
    });

    myChangeNotifier.addListener(() {
      // 注册一个监听
      print('ChangeNotifier监听器2号 ${myChangeNotifier.data}');
    });

    myValueNotifier.addListener(() {
      // 注册一个监听
      print('ValueNotifier监听器1号');
    });

    myValueNotifier.addListener(() {
      // 注册一个监听
      print('ValueNotifier监听器2号  ${myValueNotifier.value}');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            child: Text('ChangeNotifier 直接触发'),
            onPressed: () {
              // 一调用notify, 上面注册的监听器就会回调了.
              myChangeNotifier.notifyListeners();
            },
          ),
          RaisedButton(
            child: Text('ChangeNotifier 通过修改里面的值来触发'),
            onPressed: () {
              myChangeNotifier.data = 256;
            },
          ),
          RaisedButton(
            child: Text('ValueNotifier 触发'),
            onPressed: () {
              // 直接set value即可,其内部会自动调用notifyListeners, 然后上面注册的监听器就会回调了.
              myValueNotifier.value = DateTime.now().millisecondsSinceEpoch;
            },
          )
        ],
      ),
    );
  }
}

///
/// 由于ChangeNotifier里面没有携带数据, 这里继承自ChangeNotifier, 然后自己维护一个数据
/// 如果是只维护一个数据, 也可以直接使用 ValueNotifier
/// 但是如果多个数据, 就只能使用ChangeNotifier 了
///
class MyChangeNotifier extends ChangeNotifier {
  int _data = 0;

  set data(int d) {
    this._data = d;
    // 手动调用
    notifyListeners();
  }

  get data {
    return _data;
  }
}

class MyValueNotifier extends ValueNotifier {
  MyValueNotifier(value) : super(value);
}
