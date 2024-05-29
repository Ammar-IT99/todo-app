import 'package:firebase_auth/firebase_auth.dart';

class MyUser{
  static const String collectionName='users';
  // data class
 String? id ;
 String? name;
 String? email;
 MyUser({required this.id,required this.email,required this.name});

 // json => object;
  MyUser.fromFireStore(Map<String,dynamic>data):this(
    id: data?['id'] as String,
    name: data?['name']as String,
    email: data?['email']
  );
  Map<String,dynamic> toFireStore(){
    return{
      'id':id,
      'name':name,
      'email':email,

    };
  }
}