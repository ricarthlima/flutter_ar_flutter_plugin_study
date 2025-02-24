import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ARViewModel extends ChangeNotifier {
  late ARSessionManager _arSessionManager;
  late ARObjectManager _arObjectManager;
  late ARAnchorManager _arAnchorManager;
  late ARLocationManager _arLocationManager;

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
  }

  Future<void> onLocalObjectAtOriginButtonPressed() async {
    if (localObjectNode != null) {
      _arObjectManager.removeNode(localObjectNode!);
      localObjectNode = null;
    } else {
      var newNode = ARNode(
        type: NodeType.webGLB,
        uri: "asset/thanos.glb",
        scale: Vector3(0.2, 0.2, 0.2),
        position: Vector3(0.0, 0.0, 0.0),
        rotation: Vector4(1.0, 0.0, 0.0, 0.0),
      );
      bool? didAddLocalNode = await _arObjectManager.addNode(newNode);
      localObjectNode = (didAddLocalNode!) ? newNode : null;
    }
  }
}
