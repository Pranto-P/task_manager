import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/auth_utility.dart';
import 'package:task_manager_project/data/models/login_model.dart';
import 'package:task_manager_project/data/models/network_response.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utils/urls.dart';
import 'package:task_manager_project/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager_project/ui/screens/email_verification_screen.dart';
import 'package:task_manager_project/ui/screens/auth/singup_screen.dart';
import 'package:task_manager_project/widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _loginProgress = false;

  Future<void> login() async {
    _loginProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> responseBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text
    };
    final NetworkResponse response = await NetworkCaller()
        .postRequest(urls.login, responseBody, isLogin: true);
    _loginProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (mounted) {
      if (response.isSuccess) {
        LoginModel model = LoginModel.fromJson(response.body!);
        await AuthUtility.saveUserInfo(model);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
            (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect email or password')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 65),
            Text(
              'Get Started With',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _emailTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: _passwordTEController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Visibility(
                visible: _loginProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Icon(Icons.arrow_circle_right_outlined)),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailVerificationScreen()));
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, letterSpacing: 0.5),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingupScreen()));
                    },
                    child: Text('Sing up'))
              ],
            )
          ],
        ),
      )),
    );
  }
}
