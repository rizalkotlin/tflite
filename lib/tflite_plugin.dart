import 'package:flutter/services.dart';
import 'package:tflite/tflite_plugin_platform_interface.dart';

class TflitePlugin {
  Future<String?> loadModel({
    required String model,
    String labels = "",
    int numThreads = 1,
    bool isAsset = true,
    bool useGpuDelegate = false,
  }) {
    return TflitePluginPlatformInterface.instance.loadModel(
        model: model,
        labels: labels,
        numThreads: numThreads,
        isAsset: isAsset,
        useGpuDelegate: useGpuDelegate);
  }

  Future<List?> runModelOnImage(
      {required String path,
      double imageMean = 117.0,
      double imageStd = 1.0,
      int numResults = 5,
      double threshold = 0.1,
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runModelOnImage(
        path: path,
        imageMean: imageMean,
        imageStd: imageStd,
        numResults: numResults,
        threshold: threshold,
        asynch: asynch);
  }

  Future<List?> runModelOnBinary(
      {required Uint8List binary,
      int numResults = 5,
      double threshold = 0.1,
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runModelOnBinary(
        binary: binary,
        numResults: numResults,
        threshold: threshold,
        asynch: asynch);
  }

  Future<List?> runModelOnFrame(
      {required List<Uint8List> bytesList,
      int imageHeight = 1280,
      int imageWidth = 720,
      double imageMean = 127.5,
      double imageStd = 127.5,
      int rotation = 90, // Android only
      int numResults = 5,
      double threshold = 0.1,
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runModelOnFrame(
        bytesList: bytesList,
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        imageMean: imageMean,
        imageStd: imageStd,
        rotation: rotation,
        numResults: numResults,
        threshold: threshold,
        asynch: asynch);
  }

  static const anchors = [
    0.57273,
    0.677385,
    1.87446,
    2.06253,
    3.33843,
    5.47434,
    7.88282,
    3.52778,
    9.77052,
    9.16828
  ];

  Future<List?> detectObjectOnImage({
    required String path,
    String model = "SSDMobileNet",
    double imageMean = 127.5,
    double imageStd = 127.5,
    double threshold = 0.1,
    int numResultsPerClass = 5,
    // Used in YOLO only
    List anchors = anchors,
    int blockSize = 32,
    int numBoxesPerBlock = 5,
    bool asynch = true,
  }) async {
    return TflitePluginPlatformInterface.instance.detectObjectOnImage(
        path: path,
        model: model,
        imageMean: imageMean,
        imageStd: imageStd,
        threshold: threshold,
        numResultsPerClass: numResultsPerClass,
        anchors: anchors,
        blockSize: blockSize,
        numBoxesPerBlock: numBoxesPerBlock,
        asynch: asynch);
  }

  Future<List?> detectObjectOnBinary({
    required Uint8List binary,
    String model = "SSDMobileNet",
    double threshold = 0.1,
    int numResultsPerClass = 5,
    // Used in YOLO only
    List anchors = anchors,
    int blockSize = 32,
    int numBoxesPerBlock = 5,
    bool asynch = true,
  }) async {
    return TflitePluginPlatformInterface.instance.detectObjectOnBinary(
        binary: binary,
        model: model,
        threshold: threshold,
        numResultsPerClass: numResultsPerClass,
        anchors: anchors,
        blockSize: blockSize,
        numBoxesPerBlock: numBoxesPerBlock,
        asynch: asynch);
  }

  Future<List?> detectObjectOnFrame({
    required List<Uint8List> bytesList,
    String model = "SSDMobileNet",
    int imageHeight = 1280,
    int imageWidth = 720,
    double imageMean = 127.5,
    double imageStd = 127.5,
    double threshold = 0.1,
    int numResultsPerClass = 5,
    int rotation = 90, // Android only

    // Used in YOLO only
    List anchors = anchors,
    int blockSize = 32,
    int numBoxesPerBlock = 5,
    bool asynch = true,
  }) async {
    return TflitePluginPlatformInterface.instance.detectObjectOnFrame(
        bytesList: bytesList,
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        imageMean: imageMean,
        imageStd: imageStd,
        rotation: rotation,
        numResultsPerClass: numResultsPerClass,
        anchors: anchors,
        blockSize: blockSize,
        numBoxesPerBlock: numBoxesPerBlock,
        asynch: asynch);
  }

  Future close() async {
    return TflitePluginPlatformInterface.instance.close();
  }

  Future<Uint8List?> runPix2PixOnImage(
      {required String path,
      double imageMean = 0,
      double imageStd = 255.0,
      String outputType = "png",
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runPix2PixOnImage(
        path: path,
        imageMean: imageMean,
        imageStd: imageStd,
        outputType: outputType,
        asynch: asynch);
  }

  Future<Uint8List?> runPix2PixOnBinary(
      {required Uint8List binary,
      String outputType = "png",
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runPix2PixOnBinary(
        binary: binary, outputType: outputType, asynch: asynch);
  }

  Future<Uint8List?> runPix2PixOnFrame({
    required List<Uint8List> bytesList,
    int imageHeight = 1280,
    int imageWidth = 720,
    double imageMean = 0,
    double imageStd = 255.0,
    int rotation = 90, // Android only
    String outputType = "png",
    bool asynch = true,
  }) async {
    return TflitePluginPlatformInterface.instance.runPix2PixOnFrame(
        bytesList: bytesList,
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        imageMean: imageMean,
        imageStd: imageStd,
        rotation: rotation,
        outputType: outputType,
        asynch: asynch);
  }

  // https://github.com/meetshah1995/pytorch-semseg/blob/master/ptsemseg/loader/pascal_voc_loader.py
  static List<int> pascalVOCLabelColors = [
    Color.fromARGB(255, 0, 0, 0).value, // background
    Color.fromARGB(255, 128, 0, 0).value, // aeroplane
    Color.fromARGB(255, 0, 128, 0).value, // biyclce
    Color.fromARGB(255, 128, 128, 0).value, // bird
    Color.fromARGB(255, 0, 0, 128).value, // boat
    Color.fromARGB(255, 128, 0, 128).value, // bottle
    Color.fromARGB(255, 0, 128, 128).value, // bus
    Color.fromARGB(255, 128, 128, 128).value, // car
    Color.fromARGB(255, 64, 0, 0).value, // cat
    Color.fromARGB(255, 192, 0, 0).value, // chair
    Color.fromARGB(255, 64, 128, 0).value, // cow
    Color.fromARGB(255, 192, 128, 0).value, // diningtable
    Color.fromARGB(255, 64, 0, 128).value, // dog
    Color.fromARGB(255, 192, 0, 128).value, // horse
    Color.fromARGB(255, 64, 128, 128).value, // motorbike
    Color.fromARGB(255, 192, 128, 128).value, // person
    Color.fromARGB(255, 0, 64, 0).value, // potted plant
    Color.fromARGB(255, 128, 64, 0).value, // sheep
    Color.fromARGB(255, 0, 192, 0).value, // sofa
    Color.fromARGB(255, 128, 192, 0).value, // train
    Color.fromARGB(255, 0, 64, 128).value, // tv-monitor
  ];

  Future<Uint8List?> runSegmentationOnImage(
      {required String path,
      double imageMean = 0,
      double imageStd = 255.0,
      List<int>? labelColors,
      String outputType = "png",
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runSegmentationOnImage(
        path: path,
        imageMean: imageMean,
        imageStd: imageStd,
        labelColors: labelColors,
        outputType: outputType,
        asynch: asynch);
  }

  Future<Uint8List?> runSegmentationOnBinary(
      {required Uint8List binary,
      List<int>? labelColors,
      String outputType = "png",
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runSegmentationOnBinary(
        binary: binary,
        labelColors: labelColors,
        outputType: outputType,
        asynch: asynch);
  }

  Future<Uint8List?> runSegmentationOnFrame(
      {required List<Uint8List> bytesList,
      int imageHeight = 1280,
      int imageWidth = 720,
      double imageMean = 0,
      double imageStd = 255.0,
      int rotation = 90, // Android only
      List<int>? labelColors,
      String outputType = "png",
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runSegmentationOnFrame(
        bytesList: bytesList,
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        imageMean: imageMean,
        imageStd: imageStd,
        rotation: rotation,
        labelColors: labelColors,
        outputType: outputType,
        asynch: asynch);
  }

  Future<List?> runPoseNetOnImage(
      {required String path,
      double imageMean = 127.5,
      double imageStd = 127.5,
      int numResults = 5,
      double threshold = 0.5,
      int nmsRadius = 20,
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runPoseNetOnImage(
        path: path,
        imageMean: imageMean,
        imageStd: imageStd,
        numResults: numResults,
        threshold: threshold,
        nmsRadius: nmsRadius,
        asynch: asynch);
  }

  Future<List?> runPoseNetOnBinary(
      {required Uint8List binary,
      int numResults = 5,
      double threshold = 0.5,
      int nmsRadius = 20,
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runPoseNetOnBinary(
        binary: binary,
        numResults: numResults,
        threshold: threshold,
        nmsRadius: nmsRadius,
        asynch: asynch);
  }

  Future<List?> runPoseNetOnFrame(
      {required List<Uint8List> bytesList,
      int imageHeight = 1280,
      int imageWidth = 720,
      double imageMean = 127.5,
      double imageStd = 127.5,
      int rotation = 90, // Android only
      int numResults = 5,
      double threshold = 0.5,
      int nmsRadius = 20,
      bool asynch = true}) async {
    return TflitePluginPlatformInterface.instance.runPoseNetOnFrame(
        bytesList: bytesList,
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        imageMean: imageMean,
        imageStd: imageStd,
        rotation: rotation,
        numResults: numResults,
        threshold: threshold,
        nmsRadius: nmsRadius,
        asynch: asynch);
  }
}
