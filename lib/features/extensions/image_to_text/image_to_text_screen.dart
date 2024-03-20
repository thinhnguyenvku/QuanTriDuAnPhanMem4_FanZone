import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:file_picker/file_picker.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageToTextScreen extends StatefulWidget {
  const ImageToTextScreen({Key? key}) : super(key: key);

  @override
  _ImageToTextScreenState createState() => _ImageToTextScreenState();
}

class _ImageToTextScreenState extends State<ImageToTextScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;
  File? _selectedImage;
  String _extractedText = '';
  bool _showCamera = false;

  @override
  void initState() {
    super.initState();

    // Khởi tạo camera
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeCameraControllerFuture =
        _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
        _extractedText = '';
        _showCamera = false;
      });

      await _extractTextFromImage();
    }
  }

  Future<void> _extractTextFromImage() async {
    final textRecognizer = GoogleVision.instance.textRecognizer();
    final visionImage = GoogleVisionImage.fromFile(_selectedImage!);
    final visionText = await textRecognizer.processImage(visionImage);

    String extractedText = '';
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          extractedText += (element.text ?? '') + ' ';
        }
        extractedText += '\n';
      }
      extractedText += '\n';
    }

    setState(() {
      _extractedText = extractedText;
    });

    textRecognizer.close();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeCameraControllerFuture;

      final tempDir = await getTemporaryDirectory();
      final filePath = path.join(tempDir.path, 'temp_image.jpg');

      final XFile capturedImage = await _cameraController.takePicture();

      final imageBytes = await capturedImage.readAsBytes();
      await File(filePath).writeAsBytes(imageBytes);

      setState(() {
        _selectedImage = File(filePath);
        _extractedText = '';
        _showCamera = false;
      });

      await _extractTextFromImage();
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
      _extractedText = '';
      _showCamera = false;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image to Text'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Select Image'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _cameraController.dispose();
                      _initializeCamera();
                      _selectedImage = null;
                      _extractedText = '';
                      _showCamera = true;
                    });
                  },
                  child: const Text('Open Camera'),
                ),
              ),
              if (_selectedImage != null)
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clearImage,
                    child: const Text('Clear'),
                  ),
                ),
            ],
          ),
          if (_showCamera)
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: screenSize.width,
                    height: screenSize.width,
                    color: Colors.black,
                  ),
                  Center(
                    child: SizedBox(
                      width: screenSize.width,
                      height: screenSize.width,
                      child: CameraPreview(_cameraController),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: _takePicture,
                      child: const Text('Take Picture'),
                    ),
                  ),
                ],
              ),
            ),
          if (_selectedImage != null)
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: screenSize.width,
                    height: screenSize.width,
                    color: Colors.black,
                  ),
                  Image.file(
                    _selectedImage!,
                    width: screenSize.width,
                    height: screenSize.width,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  _extractedText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
