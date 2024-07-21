import 'dart:typed_data';

import 'package:flutter/services.dart';
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

  // load labels from the assets

  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString(_labelsPath);
    _labels = labelTxt.split('\n');
  }

  Future<void> initHelper() async {
    await _loadLabels();
    await _loadModel();
  }

  Future<Map<String, double>> inference(Float32List input) async {
    final output = [List<double>.filled(521, 0.0)];
    _interpreter.run(List.of(input), output);
    var classification = <String, double>{};

    for (var i = 0; i < output[0].length; i++) {
      
      classification[_labels[i]] = output[0][i];
    }

    return classification;
  }

  closeInterpreter() {
    _interpreter.close();
  }
}