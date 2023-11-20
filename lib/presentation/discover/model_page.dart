import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ModelViewerPage extends StatelessWidget {

  final String model;
  final GlobalKey _oneKey = GlobalKey();

  ModelViewerPage({Key? key, required this.model}) : super(key: key);

  Future<bool> _checkIfTutorialShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tutorialAR') ?? false;
  }

  Future<void> _setTutorialShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorialAR', true);
  }

  @override
  Widget build(BuildContext context) {

    _checkIfTutorialShown().then((tutorialShown) {
      if (!tutorialShown) {
        Future.delayed(Duration.zero, () {
          ShowCaseWidget.of(context).startShowCase([
            _oneKey,

          ]);
          _setTutorialShown();
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        title: const Text('Interact With It!'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: ModelViewer(
              src: 'assets/models/$model.glb',
              alt: "A 3D model",
              ar: true,
              autoRotate: true,
              cameraControls: true,
              backgroundColor: Colors.transparent,
              autoPlay: true,
            ),
          ),
          _buildCenteredShowcase(context, "View this exhibit right in front of your eyes!", _oneKey)
        ],
      ),
    );
  }

  Widget _buildCenteredShowcase(BuildContext context, String text, GlobalKey key) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Showcase(
        key: key, // Replace with your GlobalKey
        showArrow: true,
        title: text,
        titleAlignment: TextAlign.center,
        description: '',
        child: const SizedBox(width: 70, height: 70), // Empty Container as a placeholder
        // Other properties...
      ),
    );
  }

}

