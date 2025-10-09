import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prajna_ai/screens/image_picker/image_picker_event.dart';
import 'package:prajna_ai/screens/image_picker/image_picker_state.dart';
import 'package:prajna_ai/utils/image_picker_utls.dart';

class ImagePickerBloc extends Bloc<ImagePickerEnvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc({required this.imagePickerUtils})
    : super(const ImagePickerState()) {
    on<ImagePickedcamera>(_onImagePickedCamera);
    on<ImagePickedGallery>(_onImagePickedGallery);
  }

  Future<void> _onImagePickedCamera(
    ImagePickedcamera event,
    Emitter<ImagePickerState> emit,
  ) async {
    final XFile? file = await imagePickerUtils.imagepickedfromecamera();
    emit(state.copyWith(file: file));
  }

  Future<void> _onImagePickedGallery(
    ImagePickedGallery event,
    Emitter<ImagePickerState> emit,
  ) async {
    final XFile? file = await imagePickerUtils.imagepickedfromthegallery();
    emit(state.copyWith(file: file));
  }
}
