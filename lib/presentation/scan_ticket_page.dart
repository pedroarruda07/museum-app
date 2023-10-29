import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Scan Ticket', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
                    cutOutSize: 300,
                  ),
                ),
                const Positioned(
                  top: 100, // Adjust the position as per your requirement
                  child: Text(
                    'Natural History Museum',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text color for visibility
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100, // Adjust the position as per your requirement
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 380), // Adjust the maxWidth as needed
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), // Adds some padding
                      child: const Text(
                        'Point your camera at the QR Code available after presenting your ticket',
                        maxLines: 3, // Adjust based on your requirement
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center, // Centers the text
                        style: TextStyle(
                          fontSize: 20,
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Haven't bought a ticket yet?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      padding: EdgeInsets.all(
                          8.0), // Add some padding around the text
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Set the border color
                          width: 2.0, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            4.0), // Optionally add a border radius
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Link to the ticket buying page
                        },
                        child: Text(
                          'Click here to buy tickets',
                          style: TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // Do something with the scanned data
        print('QR Code Scanned: ${scanData.code}');
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
