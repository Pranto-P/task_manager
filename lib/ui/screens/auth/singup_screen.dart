import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_response.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utils/urls.dart';
import 'package:task_manager_project/widgets/screen_background.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({Key? key}) : super(key: key);

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signupProgress = false;

  Future<void> UserSignUp() async{
    _signupProgress = true;
    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().postRequest(urls.registration, <String, dynamic>{
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
        "password": _passwordTEController.text,
        "photo":""
    });
    _signupProgress = false;
    if(mounted) {
      setState(() {

      });
    }
    if (response.isSuccess) {
      _emailTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
      _passwordTEController.clear();
      if(mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Registration success!")));
      }
    } else {
      if(mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Registration faild!")));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 65),
                  Text('Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email'
                    ),
                    validator: (String? value){
                      if(value?.isEmpty ?? true){
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),

                  TextFormField(
                    controller: _firstNameTEController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'First Name'
                    ),
                    validator: (String? value){
                      if(value?.isEmpty ?? true){
                        return 'Enter Your First Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),

                  TextFormField(
                    controller: _lastNameTEController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Last Name'
                    ),
                    validator: (String? value){
                      if(value?.isEmpty ?? true){
                        return 'Enter Your Last Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),

                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Mobile'
                    ),
                    validator: (String? value){
                      if((value?.isEmpty ?? true) || value!.length < 11){
                        return 'Enter Your valid mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),

                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                    validator: (String? value){
                      if((value?.isEmpty ?? true) || value!.length <= 6){
                        return 'Enter a password more then 6 letters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _signupProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: (){
                            if(!_formKey.currentState!.validate()){
                              return;
                            }
                            UserSignUp();
                          },
                          child: Icon(Icons.arrow_circle_right_outlined)),
                    ),
                  ),
                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5
                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text('Sing In'))
                    ],
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
