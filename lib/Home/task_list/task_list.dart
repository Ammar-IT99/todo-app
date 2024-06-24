import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/task_list/task_list_item.dart';
import 'package:todo_app/My_Theme.dart';
import 'package:todo_app/Providers/list_provider.dart';

import '../../Providers/auth_Provider.dart';
class taskList extends StatefulWidget{
  @override
  State<taskList> createState() => _taskListState();
}

class _taskListState extends State<taskList> {

  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context,listen: false);
    if(listprovider.tasksList.isEmpty){
      listprovider.getAllTasksFromFireStore(authProvider.currentUser?.id??'');
    }
    return Column(
      children: [
          CalendarTimeline(
          initialDate: listprovider.selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date){
            listprovider.changeSelectedDate(date,authProvider.currentUser!.id!);
          },
          leftMargin: 20,
          monthColor: MyTheme.blackcolor,
          dayColor: MyTheme.blackcolor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: MyTheme.primaryColor,
          dotsColor: const Color(0xFF333A47),
          selectableDayPredicate: (date) => true,
          locale: 'ar',
       ),
        Expanded(
          child: ListView.builder(itemBuilder: (context,index){
            return taskListitem(task: listprovider.tasksList[index],);
          },
            itemCount: listprovider.tasksList.length,
          ),
        ),
      ],
    );
  }


}