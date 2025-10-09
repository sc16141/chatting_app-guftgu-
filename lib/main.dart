// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prajna_ai/app_routes/app_routes.dart';
import 'package:prajna_ai/firebase_options.dart';
import 'package:prajna_ai/screens/image_picker/image_picker_bloc.dart';
import 'package:prajna_ai/screens/login/login_bloc/login_bloc.dart';
import 'package:prajna_ai/screens/login/widgets/login_auth.dart';
import 'package:prajna_ai/utils/image_picker_utls.dart';

// TODO: Update these import paths to match your project structure


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap your app with the providers
    return RepositoryProvider(
      create: (context) => AuthService(),
      child: BlocProvider(
         create: (context) => LoginBloc(
          // The BLoC gets the AuthService from the RepositoryProvider
          RepositoryProvider.of<AuthService>(context),
        ),
    // return MultiBlocProvider(providers: [
    //   BlocProvider(create: (_) => ImagePickerBloc(
    //     imagePickerUtils: ImagePickerUtils(),
    //   )),


        child: MaterialApp.router(
          routerConfig: AppRoutes.router,
          debugShowCheckedModeBanner: false,
          title: 'Prajna AI',
        ),
      )
    );
  }
}