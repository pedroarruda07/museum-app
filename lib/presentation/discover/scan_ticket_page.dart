import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/discover/layout1/discover_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  Future<void> _setTicketScanned() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ticket', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Start Exploring',
            style: TextStyle(color: Colors.white)),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 250,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.06, // Adjust the position as per your requirement
                  child: const Text(
                    'Scan QR Code',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white, // White text color for visibility
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.07, // Adjust the position as per your requirement
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9), // Adjust the maxWidth as needed
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10), // Adds some padding
                      child: const Text(
                        'Point your camera at the QR Code available after presenting your ticket',
                        maxLines: 3, // Adjust based on your requirement
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center, // Centers the text
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              color: Colors.black87, // Setting the background color
              child: Container(
                padding: const EdgeInsets.all(8.0), // Add some padding around the text
                child: TextButton(
                  onPressed: () {
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyTicketPage()));

                    //just for testing, rememebr to swap
                    _setTicketScanned();
                    Navigator.of(context).replace(
                      oldRoute: ModalRoute.of(context)!,
                      newRoute: MaterialPageRoute(builder: (context) => const DiscoverPage()),
                    );
                  },
                  child: const Text(
                    "Haven't bought a ticket yet?\n   Click here to buy tickets",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      //print(scanData.code);
      if (scanData.code == "StartMuseumVisit") {
        // Navigate to the desired page
        setState(() {
          _setTicketScanned();
          Navigator.of(context).replace(
            oldRoute: ModalRoute.of(context)!,
            newRoute: MaterialPageRoute(builder: (context) => const DiscoverPage()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
