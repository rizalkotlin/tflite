import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite_plugin_platform_interface.dart';

/// An implementation of [Bm5500FlutterPluginPlatform] that uses method channels.
class MethodChannelTflitePlugin extends TflitePluginPlatformInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tflite');

  @override
  Future<String?> loadModel({
    required String model,
    String labels = "",
    int numThreads = 1,
    bool isAsset = true,
    bool useGpuDelegate = false,
  }) async {
    return await methodChannel.invokeMethod('loadModel', {
      "model": model,
      "labels": labels,
      "numThreads": numThreads,
      "isAsset": isAsset,
      'useGpuDelegate': useGpuDelegate
    });
  }

  @override
  Future<List?> runModelOnImage({
    required String path,
    double imageMean = 117.0,
    double imageStd = 1.0,
    int numResults = 5,
    double threshold = 0.1,
    bool asynch = true,
  }) async {
    return await methodChannel.invokeMethod('runModelOnImage', {
      "path": path,
      "imageMean": imageMean,
      "imageStd": imageStd,
      "numResults": numResults,
      "threshold": threshold,
      "asynch": asynch,
    });
  }

  @override
  Future<List?> runModelOnBinary({
    required Uint8List binary,
    int numResults = 5,
    double threshold = 0.1,
    bool asynch = true,
  }) async {
    return await methodChannel.invokeMethod('runModelOnBinary', {
      "binary": binary,
      "numResults": numResults,
      "threshold": threshold,
      "asynch": asynch,
    });
  }

  @override
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
    return await methodChannel.invokeMethod(
      'runModelOnFrame',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "rotation": rotation,
        "numResults": numResults,
        "threshold": threshold,
        "asynch": asynch,
      },
    );
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

  @override
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
    return await methodChannel.invokeMethod(
      'detectObjectOnBinary',
      {
        "binary": binary,
        "model": model,
        "threshold": threshold,
        "numResultsPerClass": numResultsPerClass,
        "anchors": anchors,
        "blockSize": blockSize,
        "numBoxesPerBlock": numBoxesPerBlock,
        "asynch": asynch,
      },
    );
  }

  @override
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
    return await methodChannel.invokeMethod(
      'detectObjectOnFrame',
      {
        "bytesList": bytesList,
        "model": model,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "rotation": rotation,
        "threshold": threshold,
        "numResultsPerClass": numResultsPerClass,
        "anchors": anchors,
        "blockSize": blockSize,
        "numBoxesPerBlock": numBoxesPerBlock,
        "asynch": asynch,
      },
    );
  }

  @override
  Future close() async {
    return await methodChannel.invokeMethod('close');
  }

  @override
  Future<Uint8List?> runPix2PixOnImage(
      {required String path,
      double imageMean = 0,
      double imageStd = 255.0,
      String outputType = "png",
      bool asynch = true}) async {
    return await methodChannel.invokeMethod(
      'runPix2PixOnImage',
      {
        "path": path,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "asynch": asynch,
        "outputType": outputType,
      },
    );
  }

  @override
  Future<Uint8List?> runPix2PixOnBinary(
      {required Uint8List binary,
      String outputType = "png",
      bool asynch = true}) async {
    return await methodChannel.invokeMethod(
      'runPix2PixOnBinary',
      {
        "binary": binary,
        "asynch": asynch,
        "outputType": outputType,
      },
    );
  }

  @override
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
    return await methodChannel.invokeMethod(
      'runPix2PixOnFrame',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "rotation": rotation,
        "asynch": asynch,
        "outputType": outputType,
      },
    );
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

  @override
  Future<Uint8List?> runSegmentationOnImage(
      {required String path,
      double imageMean = 0,
      double imageStd = 255.0,
      List<int>? labelColors,
      String outputType = "png",
      bool asynch = true}) async {
    return await methodChannel.invokeMethod(
      'runSegmentationOnImage',
      {
        "path": path,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "labelColors": labelColors ?? pascalVOCLabelColors,
        "outputType": outputType,
        "asynch": asynch,
      },
    );
  }

  @override
  Future<Uint8List?> runSegmentationOnBinary(
      {required Uint8List binary,
      List<int>? labelColors,
      String outputType = "png",
      bool asynch = true}) async {
    return await methodChannel.invokeMethod(
      'runSegmentationOnBinary',
      {
        "binary": binary,
        "labelColors": labelColors ?? pascalVOCLabelColors,
        "outputType": outputType,
        "asynch": asynch,
      },
    );
  }

  @override
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
    return await methodChannel.invokeMethod(
      'runSegmentationOnFrame',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "rotation": rotation,
        "labelColors": labelColors ?? pascalVOCLabelColors,
        "outputType": outputType,
        "asynch": asynch,
      },
    );
  }

  @override
  Future<List?> runPoseNetOnImage(
      {required String path,
      double imageMean = 127.5,
      double imageStd = 127.5,
      int numResults = 5,
      double threshold = 0.5,
      int nmsRadius = 20,
      bool asynch = true}) async {
    return await methodChannel.invokeMethod(
      'runPoseNetOnImage',
      {
        "path": path,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "numResults": numResults,
        "threshold": threshold,
        "nmsRadius": nmsRadius,
        "asynch": asynch,
      },
    );
  }

  @override
  Future<List?> runPoseNetOnBinary(
      {required Uint8List binary,
      int numResults = 5,
      double threshold = 0.5,
      int nmsRadius = 20,
      bool asynch = true}) async {
    return await methodChannel.invokeMethod(
      'runPoseNetOnBinary',
      {
        "binary": binary,
        "numResults": numResults,
        "threshold": threshold,
        "nmsRadius": nmsRadius,
        "asynch": asynch,
      },
    );
  }

  @override
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
    return await methodChannel.invokeMethod(
      'runPoseNetOnFrame',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "rotation": rotation,
        "numResults": numResults,
        "threshold": threshold,
        "nmsRadius": nmsRadius,
        "asynch": asynch,
      },
    );
  }
}
