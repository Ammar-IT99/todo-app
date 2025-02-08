
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../my_theme.dart';
import '../../Providers/app_config_provider.dart';
class ThemeBottomSheet extends StatefulWidget{
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<AppConfigProvider>(context);
    return Container(

     margin: const EdgeInsets.all(15),
 child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
     children: [

       InkWell(
         onTap: (){
                provider.changeTheme(ThemeMode.dark);
                //change to dark Theme.
         },
         child: provider.isDarkMode()?
         getSelectedItem(AppLocalizations.of(context)!.dark):
         getUnSelectedItem(AppLocalizations.of(context)!.dark) ,
       ),
       const SizedBox(height: 10,),
       InkWell(
         onTap: (){
            provider.changeTheme(ThemeMode.light);
           //change to Light Theme.
         },
         child: provider.isDarkMode()?
    getUnSelectedItem(AppLocalizations.of(context)!.light):
                    getSelectedItem(AppLocalizations.of(context)!.light),
       ),

     ],
 ),
    );

  }

 Widget getSelectedItem(String text){
   var provider= Provider.of<AppConfigProvider>(context);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith
              (color: provider.isDarkMode()?
            MyTheme.primaryColor:
            MyTheme.backGroundDarkColor,fontWeight:FontWeight.bold)),
        Icon(Icons.check,size: 25,color:provider.isDarkMode()?
        MyTheme.primaryColor:
        MyTheme.backGroundDarkColor,)
      ],
    );

 }
  Widget getUnSelectedItem(String text){
    var provider= Provider.of<AppConfigProvider>(context);
    return
        Container(
          width: double.infinity,
          color: provider.isDarkMode()?
          MyTheme.whiteColor:
          MyTheme.primaryColor,
          child: Text(text,
            style: Theme.of(context).textTheme.titleMedium,),
        );


  }
}