import 'package:chat_app/core/constants.dart';
import 'package:chat_app/core/widgets/snackbar.dart';
import 'package:chat_app/features/auth/presentation/cupits/auth/auth_cubit.dart';
import 'package:chat_app/features/home/presentation/views/home/home.dart';
import 'package:chat_app/features/auth/presentation/views/login/components/custom_button.dart';
import 'package:chat_app/features/auth/presentation/views/login/components/custom_textform_field.dart';
import 'package:chat_app/features/auth/presentation/views/sIgn%20up/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  String email = "", password = "";
  bool isloading=false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
        }
        else if (state is AuthLoading) {
         isloading =true;
        }  else if (state is AuthFail){
         isloading =false;
         showSnackBar(context, state.exception);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isloading,
          child: Scaffold(
              backgroundColor: kPriamryColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.02 * width),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: .1 * height,
                        ),
                        Center(
                          child: Image.asset('assets/image/scholar.png'),
                        ),
                        Center(
                          child: Text(
                            'Scholar Chat',
                            style:
                                TextStyle(fontSize: 35.sp, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: .1 * height,
                        ),
                        Text(
                          'Sign in',
                          style: TextStyle(fontSize: 25.sp, color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: .02 * height,
                        ),
                        CustomTextFormField(
                          title: 'Email',
                          onchange: (data) {
                            email = data;
                          },
                        ),
                        SizedBox(
                          height: .02 * height,
                        ),
                        CustomTextFormField(
                          title: 'Password',
                          onchange: (data) {
                            password = data;
                          },
                        ),
                        SizedBox(
                          height: .05 * height,
                        ),
                        CustomButton(
                          title: 'Sign In',
                          width: width,
                          height: height,
                          onTap: () {
                            BlocProvider.of<AuthCubit>(context)
                               .login(email: email,password: password);
                          },
                        ),
                        SizedBox(
                          height: .01 * height,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have an account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15.sp),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 15.sp),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
