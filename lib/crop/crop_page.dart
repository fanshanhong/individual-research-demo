import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

///
/// 图片裁剪页面
///
class CropPage extends StatefulWidget {
  final String title;

  CropPage({this.title});

  @override
  CropState createState() => CropState();
}

///
/// 当前的状态
/// 闲着,已经选了一张图片,已经裁剪完成
/// 不同的状态会有不同的操作
///
enum AppState {
  free,
  picked,
  cropped,
}

class CropState extends State<CropPage> {
  AppState state;
  File imageFile;

  @override
  void initState() {
    super.initState();
    // 默认为闲着的状态
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: imageFile != null ? Image.file(imageFile) : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          // 如果是闲着,就去选图片
          // 如果已经选择好了,就去裁剪
          // 如果已经裁剪完了,就clear
          if (state == AppState.free)
            _pickImage();
          else if (state == AppState.picked)
            _cropImage();
          else if (state == AppState.cropped) _clearImage();
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  // 根据不同状态,构建不同的FloatActionButton
  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  ///
  /// 选择图片
  Future<Null> _pickImage() async {
    // 从图库中
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    // 拍照选择图片
    // imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    // imageFile 就是拿到选择的图片, 是个文件
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  ///
  /// 裁剪图片
  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        // 原图片的绝对路径, the absolute path of an image file.

        maxWidth: 50,
        //maximum cropped image width.
        maxHeight: 50,
        //maximum cropped image Height.

        // 裁剪的形状
        cropStyle: CropStyle.circle,
        // 压缩后的图片格式
        compressFormat: ImageCompressFormat.jpg,
        // 压缩质量
        compressQuality: 90,

        // controls the aspect ratio of crop bounds. If this values is set, the cropper is locked and user can't change the aspect ratio of crop bounds.
        // 长宽比, 如果设置此值，则裁剪器将被锁定，并且用户无法更改裁剪范围的纵横比。
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),

        // 如果设置了aspectRatio, aspectRatioPresets是不是就没用了.

        // controls the list of aspect ratios in the crop menu view. In Android, you can set the initialized aspect ratio when starting the cropper by setting the value of AndroidUiSettings.initAspectRatio.

        // 控制裁剪菜单视图中的纵横比列表。
        // 在Android中，可以通过设置AndroidUiSettings.initAspectRatio的值来设置启动裁切器时的初始化纵横比。
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square, // 正方形 1:1
                CropAspectRatioPreset.ratio3x2, // 长方形 3:2
                CropAspectRatioPreset.original, // 原始的
                CropAspectRatioPreset.ratio4x3, // 4:3
                CropAspectRatioPreset.ratio16x9 // 16:9
              ]
            : [
                // iOS有如下的比例
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],

        // Android平台裁剪页面的样式
        androidUiSettings: AndroidUiSettings(
          // 标题
          toolbarTitle: '哈哈哈',
          // toolbar颜色
          toolbarColor: Colors.red,
          // toolbar上的组件颜色
          toolbarWidgetColor: Colors.green,

          // 启动裁纸器时，将应用所需的宽高比
          initAspectRatio: CropAspectRatioPreset.square,
          // 是否锁定
          lockAspectRatio: true,

          // 状态栏颜色
          statusBarColor: Colors.cyan,
          // 整个背景
          backgroundColor: Colors.blueGrey,
          // 选中的那个控制的颜色, 默认黄色
          activeControlsWidgetColor: Colors.black12,
          // 可以用的组件的颜色
//          activeWidgetColor: Colors.white,
//            this.dimmedLayerColor,
          // 裁剪的框框的颜色
          cropFrameColor: Colors.red,
          //裁剪的九宫格Grid的颜色
          cropGridColor: Colors.brown,
          cropFrameStrokeWidth: 50,
//            this.cropGridRowCount,
//            this.cropGridColumnCount,
//            this.cropGridStrokeWidth,
//            this.showCropGrid,
//            this.lockAspectRatio,
//            this.hideBottomControls,
//            this.initAspectRatio
        ),

        // iOS平台,裁剪页面的样式
        iosUiSettings: IOSUiSettings(
//            minimumAspectRatio:
//            rectX:
//            rectY:
          rectWidth: 100,
          rectHeight: 100,
//            showActivitySheetOnDone:
          showCancelConfirmationDialog: false,
          rotateClockwiseButtonHidden: false,
          hidesNavigationBar: false,
          rotateButtonsHidden: false,
          resetButtonHidden: false,
          aspectRatioPickerButtonHidden: false,
          resetAspectRatioEnabled: true,
          aspectRatioLockDimensionSwapEnabled: true,
          aspectRatioLockEnabled: true,
          title: '裁剪',
          doneButtonTitle: '确定',
          cancelButtonTitle: '取消',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}
