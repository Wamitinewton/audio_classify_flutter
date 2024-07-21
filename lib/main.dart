import 'package:audio_classify_flutter/audio_classification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const AudioClassificationApp());
}

class AudioClassificationApp extends StatelessWidget {
  const AudioClassificationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const platform = MethodChannel('org.tensorflow.audio_classification/audio_record');

  static const _sampleRate = 16000;
  static const _expectAudioLength = 975;
  final int _requiredInputBuffer = 
  (16000 * (_expectAudioLength / 1000)).toInt();

  late AudioClassificationHelper _helper;
  List<MapEntry<String, double>> _classification = List.empty();
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

