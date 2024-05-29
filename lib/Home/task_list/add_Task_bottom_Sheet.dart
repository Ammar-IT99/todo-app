import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/My_Theme.dart';
import 'package:todo_app/dialog_utlis.dart';
import 'package:todo_app/firebase_utlis.dart';
import 'package:todo_app/model/task.dart';

import '../../Providers/auth_Provider.dart';
import '../../Providers/list_provider.dart';


class AddTaskBotttomSheet extends StatefulWidget {
  const AddTaskBotttomSheet({super.key});

  @override
  State<AddTaskBotttomSheet> createState() => _AddTaskBotttomSheetState();
}

class _AddTaskBotttomSheetState extends State<AddTaskBotttomSheet> {
  var SelectedDate= DateTime.now();
  var FormKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider= Provider.of<ListProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(

          children: [
            Text(
              'Add Todo Task',
               style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 22,
                  color: MyTheme.blackcolor,
                  fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Form(
              key:FormKey ,
                child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text){
                        title=text;
                    },
                    validator: (text){
                      if(text!.isEmpty){
                        return 'Please Enter Task Title';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter task title',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (text){
                      description=text;
                    },
                    validator: (text){
                      if(text!.isEmpty){
                        return 'Please Enter Task Description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Task Description',
                    ),
                    maxLines: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:1),
                  child: Text('Select Date',style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: (){
                      showSelectedDate();
                    },
                    child: Text('${SelectedDate.day}/${SelectedDate.month}/${SelectedDate.year}',style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400
                    ),
                        textAlign: TextAlign.center
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){
                    addTask();
                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.primaryColor, // Text color
                 // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Button border radius
                    ),

                  ), child: Text('Add',style: Theme.of(context).textTheme.titleSmall,),
                 
                ),
                ),
              ],
            )),

          ],
        ),
      ),
    );
  }

  void showSelectedDate() async{
   var chosenDate= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365))
    );
   if(chosenDate!=null){
     SelectedDate=chosenDate;
   }
   setState(() {

   });

  }

  void addTask() {
  if(FormKey.currentState?.validate()==true){
    Task task=Task(title: title, description: description, dateTime: SelectedDate);
    var authProvider = Provider.of<AuthProviders>(context,listen: false);

      FirebaseUtlis.addTaskToFirStore(task,authProvider.currentUser!.id
      !).then((value) {
        print('task added SuccessFully');
        Navigator.pop(context);
        DialogUtlis.showMessage(context: context, message: 'task added SuccessFully',
        posActionName: 'OK' );
        print('after dialog');
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);

      })
          .timeout(Duration(milliseconds: 500),
      onTimeout: (){
        print('task added SuccessFully');
        DialogUtlis.showMessage(context: context, message: 'task added SuccessFully');
        // refresh tasks
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
      });
  }
  }
}
