import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/Home/settings/Settings_tap.dart';
import 'package:todo_app/Home/task_list/add_Task_bottom_Sheet.dart';
import 'package:todo_app/Home/task_list/task_list.dart';
import 'package:todo_app/My_Theme.dart';
import 'package:todo_app/Providers/list_provider.dart';
import 'package:todo_app/auth/login/login_Screen.dart';
import 'Providers/app_config_provider.dart';
import 'Providers/auth_Provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selecteditem = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviders>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.20,
        title: Text(
          selectedMenuItem == selecteditem
              ? 'Todo List {${authProvider.currentUser!.name!}}'
              : provider.appLanguage == 'en'
                  ? AppLocalizations.of(context)!.settings
                  : AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.tasksList = [];
                authProvider.currentUser = null;
                Navigator.pushReplacementNamed(context, loginScreen.routeName);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Wrap(
          children: [
            BottomNavigationBar(
              currentIndex: selecteditem,
              onTap: (index) {
                selecteditem = index;
                setState(() {});
              },
              items: [
                 BottomNavigationBarItem(
                  icon: const Icon(Icons.list),
                  label: provider.appLanguage=='en'?
                  AppLocalizations.of(context)!.taskList:
                  AppLocalizations.of(context)!.taskList,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: provider.appLanguage == 'en'
                      ? AppLocalizations.of(context)!.settings
                      : AppLocalizations.of(context)!.settings,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBottomSheet();
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selecteditem == 0 ? taskList() : settingstap(),
    );
  }

  void showAddBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTaskBotttomSheet(),
    );
  }

  int selectedMenuItem = 0;
  void onSideMenuItemClick(int newSelectedMenuItem) {
    selectedMenuItem = newSelectedMenuItem;
    setState(() {});
  }
}
