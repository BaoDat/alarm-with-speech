import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/firebase_options.dart';
import 'package:alarm_with_speech/screens/home.dart';
import 'package:alarm_with_speech/utils/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setupLogging(showDebugLogs: true);

  await Alarm.init();

  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: false),
      home: const ExampleAlarmHomeScreen(),
    ),
  );
}
