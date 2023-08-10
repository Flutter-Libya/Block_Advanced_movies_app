import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/presentation_main_app/controller/main_bloc.dart';
import 'package:movies_app/presentation_main_app/controller/main_event.dart';
import 'package:movies_app/presentation_main_app/controller/main_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                MainBloc.get(context).add(ChangeCurrentIndexEvent(index));
              },
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                bottomNavigationBarItem(
                    icon: Icons.movie, label: "Movies".toUpperCase()),
                bottomNavigationBarItem(
                    icon: Icons.tv, label: "Tvs".toUpperCase()),
                bottomNavigationBarItem(
                    icon: Icons.search, label: "Search".toUpperCase()),
                bottomNavigationBarItem(
                    icon: Icons.settings, label: "settings".toUpperCase()),
              ],
            ),
            body: state.screens[state.currentIndex],
          );
        },
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text(AppString.connectionFaild),
          content: const Text(AppString.internetError),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}

BottomNavigationBarItem bottomNavigationBarItem({
  required IconData icon,
  required String label,
}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
    backgroundColor: Colors.black,
  );
}
