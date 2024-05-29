import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_utlis.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> tasksList=[];
  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFireStore(String uId)async{
    QuerySnapshot<Task>querySnapshot= await FirebaseUtlis.getTasksCollection(uId).get();
    tasksList= querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

   tasksList = tasksList.where((task) {
      if(selectedDate.day==task.dateTime?.day &&
      selectedDate.month==task.dateTime?.month &&
          selectedDate.year==task.dateTime?.year){
        return true;
      }
      return false;
    }).toList();
   ///sorting Tasks ;
    tasksList.sort((task1,task2 ){
      return  task1.dateTime!.compareTo(task2.dateTime!);

    });

    notifyListeners();
  }
  void changeSelectedDate(DateTime newSelectDate,String uId){
    selectedDate=newSelectDate;
      getAllTasksFromFireStore(uId);

  }
}