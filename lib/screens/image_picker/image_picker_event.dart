import 'package:equatable/equatable.dart';

abstract class ImagePickerEnvent extends Equatable{
  const ImagePickerEnvent();
  @override
  List<Object > get props =>[];
}
class ImagePickedcamera extends ImagePickerEnvent{}
class ImagePickedGallery extends ImagePickerEnvent{}