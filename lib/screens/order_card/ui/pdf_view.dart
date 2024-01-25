import 'dart:async';
import 'dart:typed_data';

import 'package:europharm_flutter/network/models/order_dto.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:europharm_flutter/screens/order_card/bloc/file_signing_bloc.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/app_loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class PDFViewPage extends StatefulWidget {
  final List<int> pdfBytes;
  final OrderDTO order;

  PDFViewPage({required this.pdfBytes, required this.order});

  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  late PDFViewController _pdfController;
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileSigningBloc(
          repository: context.read<GlobalRepository>(), orderId: widget.order.id),
      child: BlocConsumer<FileSigningBloc, FileSigningState>(
        listener: (context, state) {
          if (state is OrderDocumentsIsLoadedState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          return AppLoaderOverlay(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Просмотр №${widget.order.id}',
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: PDFView(
                filePath: null,
                pdfData: Uint8List.fromList(widget.pdfBytes),
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageSnap: true,
                pageFling: false,
                onRender: (pages) {
                  setState(() {
                    this.pages = pages;
                  });
                },
                onError: (error) {},
                onPageError: (page, error) {},
                fitPolicy: FitPolicy.BOTH,
                onViewCreated: (PDFViewController controller) {
                  _pdfController = controller;
                  _controller.complete(controller);
                },
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.only(left: 25),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.black,
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      label: const Text('Подписать', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () async {
                            if (currentPage! > 0) {
                              await _pdfController.setPage(currentPage! - 1);
                              int newPage = await _pdfController.getCurrentPage() ?? 0;
                              setState(() {
                                currentPage = newPage;
                              });
                            }
                          },
                          tooltip: 'Предыдущая страница',
                          child: Icon(Icons.arrow_back),
                        ),
                        SizedBox(width: 16),
                        FloatingActionButton(
                          onPressed: () async {
                            if (currentPage! < pages! - 1) {
                              await _pdfController.setPage(currentPage! + 1);
                              int newPage = await _pdfController.getCurrentPage() ?? 0;
                              setState(() {
                                currentPage = newPage;
                              });
                            }
                          },
                          tooltip: 'Следующая страница',
                          child: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          );
        },
      ),
    );
  }
  // Future<void> _launchUrl() async {
  //   if (!await launchUrl()) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }
}