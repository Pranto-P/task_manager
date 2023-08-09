import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_response.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utils/urls.dart';
import 'package:task_manager_project/widgets/user_profile_banner.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  bool _addNewTaskInProgress = false;
  
  Future<void> addNewTask() async{
    _addNewTaskInProgress = true;
    if(mounted){
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
        "title": _titleTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status":"New"
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(urls.createTask, requestBody);
    _addNewTaskInProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      _titleTEController.clear();
      _descriptionTEController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task addes successfully')));
      } else {
        if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task addes failed!')));
        }
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileBanner(),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(
                      hintText: 'Title'
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Description'
                    ),
                  ),

                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _addNewTaskInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()
                      ),
                      child: ElevatedButton(
                          onPressed: (){
                            addNewTask();
                          },
                          child: Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
