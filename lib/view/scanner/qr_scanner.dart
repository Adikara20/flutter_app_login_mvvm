import 'package:flutter/material.dart';
import 'package:flutter_application_location/res/colors.dart';
import 'package:flutter_application_location/utils/routes/routes_name.dart';
import 'package:flutter_application_location/view/scanner/qr_scanner_overlay.dart';
import 'package:flutter_application_location/view/scanner/result_qr_scanner.dart';
import 'package:flutter_application_location/view_model/scanner_view_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../res/components/text_costum.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;

  MobileScannerController mobileScannerController = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    final scannerViewModel = Provider.of<ScannerViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         setState(() {
      //           isFlashOn = !isFlashOn;
      //         });

      //         mobileScannerController.toggleTorch();
      //       },
      //       icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
      //       color: isFlashOn ? AppColors.buttonColor : AppColors.titleTextColor,
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         setState(() {
      //           isFrontCamera = !isFrontCamera;
      //         });

      //         mobileScannerController.switchCamera();
      //       },
      //       icon: const Icon(Icons.camera_front),
      //       color: isFrontCamera
      //           ? AppColors.buttonColor
      //           : AppColors.titleTextColor,
      //     )
      //   ],
      // ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  TextCostum(
                    colorText: AppColors.titleTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    text: "Place QR code in the area",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextCostum(
                    colorText: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    text: "Scanning will be started automatically",
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: mobileScannerController,
                    allowDuplicates: false,
                    onDetect: ((barcode, args) {
                      if (!isScanCompleted) {
                        String code = barcode.rawValue ?? '---';
                        isScanCompleted = true;
                        scannerViewModel.setTest(code);
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ResultQRScanner(
                        //         code: code, closeScreen: closeScreen),
                        //   ),
                        // );
                      }
                    }),
                  ),
                  const QRScannerOverlay(overlayColour: Colors.white),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  TextCostum(
                    colorText: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    text: !isScanCompleted ? "please wait ....." : "Completed",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isFlashOn = !isFlashOn;
                              });

                              mobileScannerController.toggleTorch();
                            },
                            icon: Icon(
                                isFlashOn ? Icons.flash_on : Icons.flash_off),
                            color: isFlashOn
                                ? AppColors.buttonColor
                                : AppColors.titleTextColor,
                            iconSize: 35,
                          ),
                          const TextCostum(
                            colorText: AppColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            text: "Flash On",
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isFrontCamera = !isFrontCamera;
                              });

                              mobileScannerController.switchCamera();
                            },
                            icon: const Icon(Icons.camera_front),
                            color: isFrontCamera
                                ? AppColors.buttonColor
                                : AppColors.titleTextColor,
                            iconSize: 35,
                          ),
                          const TextCostum(
                            colorText: AppColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            text: "Camera",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
