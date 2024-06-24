import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../My_Theme.dart';
import '../../Providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Language_bottom_sheet.dart';
import 'Theme_bottom_sheet.dart';
class settingstap extends StatefulWidget{
  @override
  State<settingstap> createState() => _settingstapState();
}

class _settingstapState extends State<settingstap> {
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<AppConfigProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,
            style:   Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 10,),
          InkWell(
            onTap: (){
              showLanguageBottomsheet();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: MyTheme.primaryColor,
                  borderRadius:BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text( provider.appLanguage=='en'?
                  AppLocalizations.of(context)!.english:
                  AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.titleSmall,),
                  const Icon(Icons.arrow_drop_down,size: 30,),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Text(AppLocalizations.of(context)!.theme,
            style:   Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 15,),
          InkWell(
            onTap: (){
              showThemeBottomsheet();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: MyTheme.primaryColor,
                  borderRadius:BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text( provider.isDarkMode()?
                  AppLocalizations.of(context)!.dark:
                  AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.titleSmall,),
                  const Icon(Icons.arrow_drop_down,size: 30,),
                ],
              ),
            ),
          ),
        ],
      ),


    );
  }

  showLanguageBottomsheet() {
    showModalBottomSheet(context: context, builder:(context) => const LanguageBottomSheet(),
    );

  }

  void showThemeBottomsheet() {
    showModalBottomSheet(context: context, builder: (context) => const ThemeeBottomSheet(),);
  }
}