import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;

class UploadImages extends StatefulWidget {
  const UploadImages({Key? key}) : super(key: key);

  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  bool spiner=false;
  File? image;
  final imagePicker=ImagePicker();
  Future getImage()async{
    var imagePic=await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 85);
    if(imagePic!=null){
      setState(() {
        image=File(imagePic.path);
      });
    }
    else{
      print("Not Pic");
    }
  }
  Future uploadImage()async{
    var stream=http.ByteStream(image!.openRead());
    stream.cast();

    var length=await image!.length();
    
    var uri=Uri.parse('https://fakestoreapi.com/products');
    
    var request=http.MultipartRequest('POST',uri);
    request.fields['title']='Title';

    var multiport=http.MultipartFile(
        'image',
        stream,
        length
    );

    request.files.add(multiport);
    var response=await request.send();
    if(response.statusCode==200)
      {
        print("Upload");
      }
    else{
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Images"),),
      body: spiner?Center(child: CircularProgressIndicator(),):Column(
         children: [
          image==null?InkWell(
            onTap: (){
              getImage();
            },
            child: Container(
              child: Center(child: Text("Pick image"),),
            ),
          ):Container(child: Image.file(File(image!.path).absolute),),
           ElevatedButton(onPressed: (){
             uploadImage();
           }, child: Text("Upload")),
         ],
      ),
    );
  }
}
