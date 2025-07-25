import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/home.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/repositories/applicant_repository.dart';
import 'package:job_portal/screens/home/home_screen.dart';
import 'package:job_portal/screens/collect_info_recommend/steper.dart';
import 'package:provider/provider.dart';

class FormContent extends StatefulWidget {
  FormContent({Key? key}) : super(key: key);

  @override
  State<FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<FormContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _rememberMe = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<ApplicantProvider>();

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _gap(),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }

                return null;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(67, 177, 183, .4),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(67, 177, 183, .8),
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _gap(),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 4) {
                  return 'Password must be at least 4 characters';
                }
                // return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(67, 177, 183, .4),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(67, 177, 183, .8),
                    width: 2,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: Text(
                'Remember me',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            _gap(),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF43B1B7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // userProvider.isLoading
                      //     ? SizedBox(
                      //         width: 20,
                      //         height: 20,
                      //         child: CircularProgressIndicator(
                      //           color: Colors.white,
                      //           strokeWidth: 3,
                      //         ),
                      //       )
                      //     :
                      SizedBox(width: 0),
                      SizedBox(width: 15),
                      Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            // background: Color(0xFF43B1B7),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // do something
                    try {
                      await userProvider.setPassword(_passwordController.text);
                      await userProvider.getApplicant(
                        _emailController.text,
                        _passwordController.text,
                      ); //bắt đầu ktra, fetch và gán giá trị vào cho _user
                      // await UserReposotory.login(_emailController.text,
                      //     _passwordController.text, 'applicant');
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: e.toString().replaceFirst("Exception:", ""),
                        fontSize: 17,
                        backgroundColor: Colors.redAccent,
                        gravity: ToastGravity.BOTTOM,
                      );
                      return;
                    }
                    Fluttertoast.showToast(
                        msg: "Login successfully!",
                        fontSize: 18,
                        backgroundColor: Theme.of(context).primaryColor,
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_SHORT);
                    //kiểm tra xem có thông tin chưa. nếu chưa có thì tiến hành
                    //chuyển vào trang onboarding, nếu có rồi chuyển vào trang login
                    if (userProvider.applicant.field == null ||
                        userProvider.applicant.field == "") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnboardingScreen()),
                        (rount) => false,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                        (rount) => false,
                      );
                    }

                    //tiến hành kiểm tra đã có thông tin gợi ý hay chưa
                    //--nếu chưa-> hiển thị form điền thông tin->home()
                    //--nếu có->  home()
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "* By signing up, you accepted all of our terms and policies.",
              style: TextStyle(
                  fontSize: 14, color: const Color.fromRGBO(158, 158, 158, 1)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
