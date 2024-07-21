import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:developer';

class AudioClassificationHelper {
  static const _modelsPath = 'assets/models/yamnet.tflite';
  static const _labelsPath = 'assets/models/yamnet_label_list.txt';


  late Interpreter _interpreter;
  late final List<String> _labels;
  late Tensor _inputTensor;
  late Tensor _outputTensor;


  Future<void> _loadModel() async {
    final options = InterpreterOptions();

    // loading the models from assets
    _interpreter = await Interpreter.fromAsset(_modelsPath, options: options);

    _inputTensor = _interpreter.getInputTensors().first;

    log(_inputTensor.shape.toString());

    _outputTensor = _interpreter.getOutputTensors().first;
    log(_outputTensor.shape.toString());
    log('interpreter loaded succesfully');
    
  }
}