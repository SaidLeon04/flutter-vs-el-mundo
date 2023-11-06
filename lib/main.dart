import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map myMap = Map();
  // List<Flowers> flores;
  List? _outputs;
  File? image;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    loadModel().then((value){
      setState(() {
        isLoading = false;
      });
    });
  }

  loadModel () async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite",
    labels: "assets/labels.txt",
    numThreads: 2);
  }
  pickedImage()async{
    final ImagePicker picker = ImagePicker();
    var imagen = await picker.pickImage(source: ImageSource.gallery);
    if(imagen==null)return null;
    setState(() {
      isLoading = true;
      image = File(imagen.path.toString());
    });
   classifyImage(image!);
  }

  classifyImage(File image)async{
    var output = await Tflite.runModelOnImage(
        path: image.path,
    numResults: 5,
    threshold: 0.05,
    imageMean: 127.5,
    imageStd: 127.5);
    setState(() {
      isLoading = false;
      _outputs = output;
      print(_outputs);
      print(_outputs![0]["label"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clasificador de flores"),
        centerTitle: true,
      ),
      body: isLoading?Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ):Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,//double.infinity
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null ?Container():Image.file(image!),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: pickedImage,
        child: const Icon(Icons.image_search),
    ),
    );
  }
}

