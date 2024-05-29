
import 'package:flutter/material.dart';
class DialogUtlis{

  static void showLoading({required BuildContext context,required String message}){
 
 showDialog(
   barrierDismissible: true,
   context: context,
   
   builder:(context){
   return AlertDialog(
     content: Row(
       children: [
         const CircularProgressIndicator(),
         const SizedBox(width: 10,),
         Text(message)
       ],
     ),
   );
   }
     
   
    ,);
  }
  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);
  }
  static void showMessage({required BuildContext context,required String message,
     String? title,
    String?  posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction
  }) {
    List<Widget>actions = [];
    if (posActionName != null) {
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        if (posAction != null) {
          posAction.call();
        }
      }, child: Text(posActionName)));
    }
    if (negActionName != null) {
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        if (negAction != null) {
          negAction.call();
        }
      }, child: Text(negActionName)));
    }
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text(message),
        title: Text(title ?? '',style: Theme.of(context).textTheme.titleMedium,),
        actions: actions,

      );
    });
  }
}
