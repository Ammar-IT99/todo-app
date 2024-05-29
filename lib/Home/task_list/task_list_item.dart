
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/My_Theme.dart';
import 'package:todo_app/dialog_utlis.dart';

import 'package:todo_app/firebase_utlis.dart';
import '../../Providers/auth_Provider.dart';
import '../../Providers/list_provider.dart';
import '../../model/task.dart';

class taskListitem extends StatefulWidget {
  Task task;
  taskListitem({super.key, required this.task});
  @override
  State<taskListitem> createState() => _taskListitemState();
}

class _taskListitemState extends State<taskListitem> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviders>(context,listen: false);

var listprovider= Provider.of<ListProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
         child: Slidable(

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        extentRatio: 0.25,
      // A motion is a widget used to control how the pane animates.
      motion: const DrawerMotion(),

      children:  [
      // A SlidableAction can have an icon and/or a label.
      SlidableAction(
      onPressed: (context){
        //delete task
        FirebaseUtlis.deleteTaskFromFireStore(widget.task,authProvider.currentUser!.id!).then((value) {
          print('Task deleted Successfully');
          DialogUtlis.showMessage(context: context, message: 'Task deleted SuccessFully');
          listprovider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        })
            .timeout(const Duration(milliseconds: 500),onTimeout: (){
          print('Task deleted Successfully');
          listprovider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        });
      },
        borderRadius:  BorderRadius.circular(15),
      backgroundColor: MyTheme.redColor,
      foregroundColor: MyTheme.whiteColor,
      icon: Icons.delete,
      label: 'Delete',
      ),

          ],
      ),
        child: Container(
          padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyTheme.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: MyTheme.primaryColor,
                height: MediaQuery.of(context).size.height * 0.11,
                width: 6,
              ),
              const SizedBox(
               width: 10,
              ),
               Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title?? '',style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: MyTheme.primaryColor
                ),
                ),
                  Text(widget.task.description?? '',style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: MyTheme.blackcolor
                  ),)],
              )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15), color: MyTheme.primaryColor),
                child: Icon(
                  Icons.check,
                  color: MyTheme.whiteColor,
                  size: 30,
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
