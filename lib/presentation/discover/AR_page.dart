import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vectors;

class AugmentedRealityPage extends StatefulWidget {
  final String dinoType;
  AugmentedRealityPage({Key? key, required this.dinoType}) : super(key: key);
  @override
  _AugmentedRealityState createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedRealityPage> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  vectors.Vector3 scale = vectors.Vector3(0.2, 0.2, 0.2);
  vectors.Vector3 position = vectors.Vector3(0.0, 0.0, 0.0);
  vectors.Vector4 rotation = vectors.Vector4(1.0, 0.0, 0.0, 0.0);

  @override
  void initState(){

    if (widget.dinoType == "tyrannosaur_fight") scale = vectors.Vector3(0.7, 0.7, 0.7);
    if (widget.dinoType == "brachiosaurus_ar_card") scale = vectors.Vector3(2.0, 2.0, 2.0);
    if (widget.dinoType == "mosasaurus%20(1)") rotation = vectors.Vector4(-1.0, 0.0, 0.0, 1.5);
    if (widget.dinoType == "plesio") {
      rotation = vectors.Vector4(-1.0, 0.0, 0.0, 1.5);
      scale = vectors.Vector3(0.7, 0.7, 0.7);
      position = vectors.Vector3(0.0, 0.5, 0.0);
    }
      super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text('Bring it to Life!'),
          centerTitle: true,
        ),
        body: Container(
            child: Stack(children: [
              ARView(
                onARViewCreated: onARViewCreated,
                planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          primary: Colors.white),
                          onPressed: onRemoveEverything,
                          child: Text("Reset")),
                    ]),
              )
            ])));
  }

  void updateARSession() {
    arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true, // use the updated state variable
      customPlaneTexturePath: "assets/images/triangle.png",
      showWorldOrigin: false,
      handlePans: true,
      handleRotation: true,
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "assets/images/triangle.png",
      showWorldOrigin: false,
      handlePans: true,
      handleRotation: true,
    );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;
  }

  Future<void> onRemoveEverything() async {
    /*nodes.forEach((node) {
      this.arObjectManager.removeNode(node);
    });*/
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
            (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null) {
      var newAnchor =
      ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
      if (didAddAnchor!) {
        this.anchors.add(newAnchor);
        // Add note to anchor
        var newNode = ARNode(
            type: NodeType.webGLB,
            uri:
            "https://github.com/pedroarruda60663/3d-Models/blob/main/${widget.dinoType}.glb?raw=true",
            scale: scale,
            position: position,
            rotation: rotation);
        bool? didAddNodeToAnchor =
        await this.arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          this.nodes.add(newNode);
        } else {
          this.arSessionManager!.onError("Adding Node to Anchor failed");
        }
      } else {
        this.arSessionManager!.onError("Adding Anchor failed");
      }
    }
  }

  onPanStarted(String nodeName) {
    print("Started panning node " + nodeName);
  }

  onPanChanged(String nodeName) {
    print("Continued panning node " + nodeName);
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    print("Ended panning node " + nodeName);
    final pannedNode =
    this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    print("Started rotating node " + nodeName);
  }

  onRotationChanged(String nodeName) {
    print("Continued rotating node " + nodeName);
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    print("Ended rotating node " + nodeName);
    final rotatedNode =
    this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //rotatedNode.transform = newTransform;
  }
}