import 'dart:io';

import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar_flutter_plugin_study/ui/utils/model_paths.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart';

class ARViewModel extends ChangeNotifier {
  late ARSessionManager _arSessionManager;
  late ARObjectManager _arObjectManager;
  late ARAnchorManager _arAnchorManager;
  late ARLocationManager _arLocationManager;

  ARNode? fileSystemNode;

  ARNode? localObjectNode;

  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) {
    _arSessionManager = sessionManager;
    _arObjectManager = objectManager;
    _arAnchorManager = anchorManager;
    _arLocationManager = locationManager;

    _arSessionManager.onInitialize(
      showFeaturePoints: true,
      showPlanes: true,
      showAnimatedGuide: true,
      showWorldOrigin: true,
      handleTaps: false,
    );

    _downloadFile(ModelPaths.thanos, "thanos.glb");
  }

  Future<void> onLocalObjectAtOriginButtonPressed() async {
    if (localObjectNode != null) {
      _arObjectManager.removeNode(localObjectNode!);
      localObjectNode = null;
    } else {
      var newNode = ARNode(
        type: NodeType.webGLB,
        uri: ModelPaths.fur003,
        scale: Vector3(0.1, 0.1, 0.1),
        position: Vector3(0.0, 0.0, 0.0),
        rotation: Vector4(0, 0.0, 0.0, 0.0),
      );
      bool? didAddLocalNode = await _arObjectManager.addNode(newNode);
      localObjectNode = (didAddLocalNode!) ? newNode : null;
    }
  }

  Future<File> _downloadFile(String url, String filename) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    print("Downloading finished, path: " '$dir/$filename');
    return file;
  }

  Future<void> onFileSystemObjectAtOriginButtonPressed() async {
    if (fileSystemNode != null) {
      _arObjectManager.removeNode(fileSystemNode!);
      fileSystemNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.fileSystemAppFolderGLB,
          uri: "thanos.glb",
          scale: Vector3(0.2, 0.2, 0.2));
      bool? didAddFileSystemNode = await _arObjectManager.addNode(newNode);
      fileSystemNode = (didAddFileSystemNode!) ? newNode : null;
    }
  }
}
