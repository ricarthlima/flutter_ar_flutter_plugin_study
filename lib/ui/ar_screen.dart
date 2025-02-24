import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar_flutter_plugin_study/ui/view/ar_view_model.dart';
import 'package:provider/provider.dart';

class ARScreen extends StatelessWidget {
  const ARScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arVM = Provider.of<ARViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          ARView(
            onARViewCreated: arVM.onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {},
              child: Text("SER INEVITÁVEL"),
            ),
          )
        ],
      ),
    );
  }
}
