import 'package:authentication_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:authentication_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:authentication_bloc/screens/home_screen.dart';
import 'package:authentication_bloc/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) {
            return previous is AuthInitialState;
          },
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return const HomeScreen();
              
            } else if (state is AuthLoggedOutState){
            return const SignInScreen();
              
            }
            else{
              return const Scaffold();
            }
          },
        ),
      ),
    );
  }
}
