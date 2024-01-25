import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:europharm_flutter/screens/order_finish/bloc/point_page_bloc.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_dialog.dart';
import 'package:europharm_flutter/widgets/camera/camera_shape.dart';
import 'package:europharm_flutter/widgets/snackbar/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

class ScanBarcodePage extends StatefulWidget {
  final GlobalRepository repository;
  final PointPageBloc pointPageBloc;
  const ScanBarcodePage({Key? key, required this.pointPageBloc, required this.repository})
      : super(key: key);

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodePageState();
}

class _ScanBarcodePageState extends State<ScanBarcodePage> {
  MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.unrestricted,
    facing: CameraFacing.back,
    torchEnabled: true,
  );
  List<String> codes = [];
  List<bool> isSuccessForSendList = [];
  List<String> successfullySentCodes = [];
  final assetsAudioPlayer = AssetsAudioPlayer();
  final canVibrate = Haptics.canVibrate();
  // int count = 0;

  @override
  void initState() {
    super.initState();
    loadData(); // Загрузка данных при запуске
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

// Загрузка данных
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      codes = prefs.getStringList('codes') ?? [];
      isSuccessForSendList = (prefs.getStringList('isSuccessForSendList') ?? [])
          .map((String value) => value == 'true')
          .toList();
      successfullySentCodes = prefs.getStringList('successfullySentCodes') ?? [];
    });
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('codes', codes);
    await prefs.setStringList('isSuccessForSendList', isSuccessForSendList.map((bool value) => value.toString()).toList());
    await prefs.setStringList('successfullySentCodes', successfullySentCodes);
  }

  @override
  Widget build(BuildContext context) {
    theme: ThemeData(useMaterial3: true);
    return Scaffold(
        body: BlocProvider.value(
          value: widget.pointPageBloc,
          child: BlocConsumer<PointPageBloc, PointPageState>(
            listener: (context, state) async {
              if (state is PointPageStateError) {
                showAppDialog(
                  context,
                  title: state.error.message,
                  onTap: () => Navigator.pop(context),
                );
              }
              if (state is PointPageStateLoaded) {
                //Navigator.pop(context);
                showCustomSnackbar(
                  context,
                  'Успешно отсканировано!',
                  color: ColorPalette.green,
                );
                assetsAudioPlayer.open(
                  Audio("assets/sound/done.mp3"),
                );
              }
              if (state is PointPageStateContainerAccepted) {
                showCustomSnackbar(
                  context,
                  'Отправлен на сервер! $codes',
                    color: Colors.blue,
                );
              }
              if (state is PointPageStateContainerAccepted) {
                assetsAudioPlayer.open(
                  Audio("assets/sound/done.mp3"),
                );
                await Haptics.vibrate(HapticsType.success);
              }
              if (state is PointPageStateError) {
                showCustomSnackbar(
                  context,
                  'Ошибка!',
                  color: Colors.red,
                );
                assetsAudioPlayer.open(
                  Audio("assets/sound/error.mp3"),
                );
                await Haptics.vibrate(HapticsType.warning);
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        final Uint8List? image = capture.image;
                        for (Barcode barcode in barcodes) {
                          debugPrint('Barcode found! ${barcode.rawValue ?? "Unknown"}');
                        }
                        final String code = barcodes.first.rawValue ?? "Unknown";
                        log("BARCODE CODE::::: $code");
                        if (codes.contains(code)) {
                          log("Code already scanned");
                        } else {
                          codes.add(code);
                          BlocProvider.of<PointPageBloc>(context)
                              .add(PointPageEventScanBarcode(code: code));
                        }
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: CameraShaper(
                          paintHeight: MediaQuery.of(context).size.width - 200,
                          paintWidth: MediaQuery.of(context).size.width - 200,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: MediaQuery.of(context).size.height / 4,
                      child: const Center(
                        child: Text(
                          'Отсканируйте штрих код на обороте коробки',
                          style: TextStyle(color: ColorPalette.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/svg/arrow_back.svg",
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Text(
                                "ФОТО",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/svg/thunder_lightning_notifications.svg",
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  controller.toggleTorch();
                                },
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                  },
                  label: Text('Подтвердите кол. ${codes.length}'),
                  icon: Icon(Icons.send, color: Colors.indigoAccent,),
                ),
              );
            },
          ),
        ),
    );
  }
}