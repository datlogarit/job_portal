import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/repositories/application_repository.dart';
import 'package:job_portal/repositories/user_reposotory.dart';
import 'package:job_portal/screens/start/login/login.dart';

class FormContentRegister extends StatefulWidget {
  FormContentRegister({Key? key}) : super(key: key);

  @override
  State<FormContentRegister> createState() => __FormContentRegisterState();
}

class __FormContentRegisterState extends State<FormContentRegister> {
  bool _isPasswordVisible = false;
  bool _isRetypePasswordVisible = false;
  bool _isAgree = true;
  // bool _autoValidate = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autocorrect: false,
              controller: _nameController,
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                return null;
              },
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your name',
                hintStyle: TextStyle(color: Colors.grey),
                // labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.person_outline),
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
            _gap(),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter some texte';
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
                hintStyle: TextStyle(color: Colors.grey),
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
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.grey),
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
                  )),
            ),
            _gap(),
            TextFormField(
              controller: _retypePasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                if (value != _passwordController.text) {
                  return 'Password not match';
                }
                return null;
              },
              obscureText: !_isRetypePasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Retype Password',
                  hintText: 'Retype Password',
                  hintStyle: TextStyle(color: Colors.grey),
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
                    icon: Icon(_isRetypePasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isRetypePasswordVisible = !_isRetypePasswordVisible;
                      });
                    },
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            CheckboxListTile(
              value: _isAgree,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _isAgree = value;
                });
              },
              title: Text(
                'I have read and accept terms and policies',
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
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF43B1B7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        // background: Color(0xFF43B1B7),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    /// do something
                    try {
                      await UserReposotory.registerApplicant(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text);
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: e.toString().replaceFirst("Exception: ", ""),
                        backgroundColor: Colors.redAccent,
                        fontSize: 17,
                        gravity: ToastGravity.BOTTOM,
                      );
                      return;
                    }
                    Fluttertoast.showToast(
                        msg: "Đăng ký thành công !",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Theme.of(context).primaryColor,
                        fontSize: 16);
                    await Future.delayed(Duration(milliseconds: 1500));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 20);
}
