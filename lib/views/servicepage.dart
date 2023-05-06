import 'dart:developer';
import 'dart:io';

import 'package:boxfile/views/editfilepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../widgets/loading.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  var camera = const Icon(
    Icons.camera,
    size: 32,
  );

  var image = const Icon(
    Icons.image,
    size: 32,
  );

  var multiimage = const Icon(
    Icons.filter,
    size: 32,
  );

  var imagetopng = const Icon(
    Icons.sync,
    size: 32,
  );

  var signature = const Icon(
    Icons.edit,
    size: 32,
  );
  File? croppedimage;
  XFile? _image;
  File? imageFile;
  List<XFile> imageFileList = [];
  final picker = ImagePicker();
  bool loading = false;
  bool completed = false;
  // TextDetector? _textDetector;
  TextEditingController script = TextEditingController();
  String? date;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  @override
  void dispose() {
    script.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final now = DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    date = formatter;
    super.initState();
  }

  Future<bool> getImage(String from) async {
    try {
      if (from == "CAMERA") {
        final pickedFile = await picker.pickImage(source: ImageSource.camera);
        _image = XFile(pickedFile!.path);
      }
      if (from == "GALLARY") {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        _image = XFile(pickedFile!.path);
      }
      await _cropImage();
      await _recognizetext();
      setState(() {
        loading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditfilePage("New File", script.text, true, '0', date)),
      );
    } catch (e) {
      return true;
    }

    return true;
  }

  Future _recognizetext() async {
    final inputImage = InputImage.fromFilePath(croppedimage!.path);
    final RecognizedText text = await textRecognizer.processImage(inputImage);
    for (TextBlock block in text.blocks) {
      if (block.lines.length == 1) {
        script.text = script.text + block.text.toString() + '\n';
      } else {
        for (TextLine line in block.lines) {
          for (TextElement word in line.elements) {
            setState(() {
              script.text = script.text + " " + word.text;
            });
          }
        }
      }
    }
    log(script.text);
  }

  Future<bool> getMultipleImage() async {
    try {
      imageFileList.clear();
      script.text = "";
      final List<XFile>? selectedImages = await picker.pickMultiImage();
      if (selectedImages!.isNotEmpty) {
        imageFileList.addAll(selectedImages);
      }
      setState(() {});
      await convertmultileimage(imageFileList);
      setState(() {
        loading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditfilePage("New File", script.text, true, '0', date)),
      );
    } catch (e) {
      return true;
    }
    return true;
  }

  Future<void> convertmultileimage(List<XFile> imageFileList) async {
    script.text = "";
    for (var image in imageFileList) {
      // _getImageSize(File(image.path));
      final currentimage = InputImage.fromFilePath(image.path);

      final RecognizedText text =
          await textRecognizer.processImage(currentimage);
      for (TextBlock block in text.blocks) {
        if (block.lines.length == 1) {
          script.text = script.text + block.text.toString() + '\n';
        } else {
          for (TextLine line in block.lines) {
            for (TextElement word in line.elements) {
              setState(() {
                script.text = script.text + " " + word.text;
              });
            }
          }
        }
      }
      script.text = script.text + '\n\n';
    }
    log(script.text);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GridView.count(
        primary: false,
        padding: EdgeInsets.only(top: 1.5.h, left: 6.w, right: 6.w),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
              onTap: () async {
                setState(() {
                  loading = true;
                });

                completed = await getImage("CAMERA");
                if (completed) {
                  setState(() {
                    loading = false;
                  });
                }
              },
              child: scanbox(1, "Capture image from camera", "", camera)),
          GestureDetector(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                completed = await getImage("GALLARY");
                if (completed) {
                  setState(() {
                    loading = false;
                  });
                }
              },
              child: scanbox(2, "Select image from gallery", "", image)),
          GestureDetector(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                completed = await getMultipleImage();
                if (completed) {
                  setState(() {
                    loading = false;
                  });
                }
                // getImage();
              },
              child: scanbox(3, "Select multiple images", "", multiimage)),
          scanbox(4, "Convert image to PDF", "Soon", imagetopng),
          scanbox(5, "Sign your files", "Soon", signature),

          // scanbox(2, "text", "icon"),
          // scanbox(3, "text", "icon"),
          // scanbox(4, "text", "icon"),
          // scanbox(5, "text", "icon")
        ],
      ),
      loading ? MyAppCiricleProgress("Loading") : Container()
    ]);
  }

  Widget scanbox(int box, String text, String update, Icon icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.5,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 3.0))
            ]),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(update,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        textStyle: GoogleFonts.leagueSpartan(
                      color: const Color(Colorz.white),
                      fontSize: 15.sp,
                    ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: GoogleFonts.leagueSpartan(
                color: const Color(Colorz.grey),
                // textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              )),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      croppedimage = File(croppedFile.path);
      // _image = croppedFile.path;
      // Uint8List bytes = croppedFile.readAsBytesSync();
      // var utf = ByteData.view(bytes.buffer)
      // _image = XFile.fromData(bytes);
      // setState(() {
      //   state = AppState.cropped;
      // });
    }
  }
}
