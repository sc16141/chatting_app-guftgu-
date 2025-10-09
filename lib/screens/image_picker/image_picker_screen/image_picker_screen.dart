import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prajna_ai/screens/image_picker/image_picker_bloc.dart';
import 'package:prajna_ai/screens/image_picker/image_picker_event.dart';
import 'package:prajna_ai/screens/image_picker/image_picker_state.dart';



class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc,ImagePickerState>(builder: (context, state){
      if(state.file == Null){
        return InkWell(
          onTap: (){context.read<ImagePickerBloc>().add(ImagePickedcamera());},
          child: CircleAvatar(
            child:
            Icon(Icons.camera_alt_outlined),
          ),
        );
      } else{
        return  Image.file(
            File(state.file!.path));
      }

    });
  }
}
