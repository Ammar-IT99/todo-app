

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/my_users.dart';
import 'package:todo_app/model/task.dart';


class FirebaseUtlis{

  static CollectionReference<Task> getTasksCollection(String uId){
   return getUserCollection().doc(uId).collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: ((snapshot, options) =>Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task,options)=>task.toFireStore()
    );

  }
  static Future<void> addTaskToFirStore(Task task,String uId ){
      var taskCollection=  getTasksCollection( uId);
    DocumentReference<Task> taskDocRef=   taskCollection.doc();
   task.id = taskDocRef.id;//auto id generated
   return taskDocRef.set(task);


  }


  static Future<void> deleteTaskFromFireStore(Task task,String uId) {
   return getTasksCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUserCollection(){
  return  FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>(
        fromFirestore: ((snapshot, options) =>MyUser.fromFireStore(snapshot.data()!)),
    toFirestore: (user,options)=>user.toFireStore()
    );
  }

  static Future<void>  addUserToFireStore(MyUser myUser) {
  return  getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId)async{
    getUserCollection().doc(uId).get();
    var querySnapShot= await getUserCollection().doc(uId).get();

    return querySnapShot.data();
  }
}
