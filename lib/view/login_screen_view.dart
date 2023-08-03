import 'package:crypto_statistics/utils/enums.dart';
import 'package:crypto_statistics/view/home_tap_controller_screen.dart';
import 'package:crypto_statistics/view_model/login_screen_view_model.dart';
import 'package:crypto_statistics/widget/custom_text_from_field.dart';
import 'package:crypto_statistics/widget/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tracerID = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // List<String> loginMessage = ["Successful Login", "Invalid Creditnails"];

  @override
  Widget build(BuildContext context) {
    Color noramlText = const Color(0xffFFFFFF);

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff14162E),
        body: Container(
          // elevation: 4,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: Color(0xff14162E),
          ),

          child: Material(
            elevation: 5,
            color: const Color(0xff14162E),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    const Color(0xff01E4BF).withOpacity(0.5),
                    const Color(0xff14162E).withOpacity(0.9),
                    const Color(0xff14162E).withOpacity(0.9),
                    // const Color(0xff14162E).withOpacity(0.9),
                    // const Color(0xff14162E).withOpacity(0.9),
                    // const Color(0xff14162E),
                  ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopMenu(noramlText, size),
                        SizedBox(
                          height: size.height * 0.3,
                        ),
                        Text(
                          "Welcome to",
                          style: TextStyle(
                              color: noramlText,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Crypto Dashboard",
                          style: TextStyle(
                              color: noramlText,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Lets Dive together...",
                            style: TextStyle(color: noramlText, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/imgs/login_logo.png",
                          height: size.height * 0.8,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Welcom to your Dashboard",
                        //   style: TextStyle(color: noramlText, fontSize: 18),
                        // ),
                        SizedBox(
                          height: size.height * 0.2,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 12.0),
                        //   child: Text(
                        //     "Please Fill the Below Form to Proceed",
                        //     style: TextStyle(color: noramlText, fontSize: 14),
                        //   ),
                        // ),
                        _builLoginForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form _builLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Fill to sign in...",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          CustomTextFormField(
            controller: _tracerID,
            hintText: "Enter Tracer ID..",
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Tracer ID";
              }
              return null;
            },
            icon: const Icon(
              Icons.wordpress,
              color: Color(0xff14162E),
            ),
            hintTextStyle:
                const TextStyle(color: Color(0xff4F555A), fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: CustomTextFormField(
              controller: _userName,
              hintText: "Enter Username..",
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Username";
                }
                return null;
              },
              icon: const Icon(
                Icons.person,
                color: Color(0xff14162E),
              ),
              hintTextStyle:
                  const TextStyle(color: Color(0xff4F555A), fontSize: 12),
            ),
          ),
          CustomTextFormField(
            controller: _password,
            hintText: "Enter Password..",
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Password";
              }
              return null;
            },
            isPassword: true,
            hintTextStyle:
                const TextStyle(color: Color(0xff4F555A), fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Consumer<LoginViewModel>(
                builder: (context, loginViewModel, child) {
              var snackBar = const SnackBar(
                  content: Text(
                "Invalid Credintails",
                style: TextStyle(color: Color(0xffFFFFFF)),
              ));
              return CustomButton(
                buttonName: "Sign In",
                isLoading: loginViewModel.state,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // loginViewModel.setLoadingState(LoadingState.loading);
                    //Now signing
                    await loginViewModel.singIn(
                        BigInt.from(int.parse(_tracerID.text)),
                        _userName.text,
                        _password.text);
                    // adding future delay for fun
                    Future.delayed(const Duration(seconds: 2), () {
                      if (loginViewModel.state == LoadingState.loaded &&
                          loginViewModel.successfulLogin) {
                        // context
                        //     .read<DashboardViewModel>()
                        //     .fetchUserPortfolo(context);
                        // context
                        //     .read<TransactionViewModel>()
                        //     .fetchTransactions(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeTapController(),
                            ));
                        loginViewModel.setLoadingState(LoadingState.intial);
                      } else {
                        loginViewModel.setLoadingState(LoadingState.intial);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }
                  // clearing fields
                  // loginViewModel.cleartInputs(_userName, _password);
                },
              );
            }),
          )
        ],
      ),
    );
  }

  Row _buildTopMenu(Color noramlText, Size size) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Home",
          style: TextStyle(
            color: noramlText,
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),

        Text(
          "Sign in",
          style: TextStyle(
            color: noramlText,
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        // const Spacer(),
        Text(
          "English",
          style: TextStyle(color: noramlText),
        ),
        Icon(
          Icons.arrow_drop_down,
          color: noramlText,
        ),
      ],
    );
  }
}
