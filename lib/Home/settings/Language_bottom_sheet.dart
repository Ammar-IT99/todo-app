
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_config_provider.dart';
class LanguageBottomSheet extends StatefulWidget{
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
                provider.ChangeLanguage('en');
         },
         child: provider.appLanguage=='en'?
         GetSelectedItem(AppLocalizations.of(context)!.english):
         GetUnSelectedItem(AppLocalizations.of(context)!.english) ,
       ),
       const SizedBox(height: 10,),
       InkWell(
         onTap: (){
            provider.ChangeLanguage('ar');
         },
         child: provider.appLanguage=='ar'?
    GetSelectedItem(AppLocalizations.of(context)!.arabic):
                    GetUnSelectedItem(AppLocalizations.of(context)!.arabic),
       ),

     ],
 ),
    );

  }

 Widget GetSelectedItem(String text){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith
              (color: Theme.of(context).primaryColor,fontWeight:FontWeight.bold)),
        Icon(Icons.check,size: 25,color: Theme.of(context).primaryColor,)
      ],
    );

 }
  Widget GetUnSelectedItem(String text){
    return
        Text(text,
          style: Theme.of(context).textTheme.titleSmall,);


  }
}