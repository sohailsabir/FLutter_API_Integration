import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  File? image;
  void getImage()async{
    ImagePicker _picker=ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);

    if(pickedFile!= null ){
      image = File(pickedFile.path);
    }else {
      print('no image selected');
    }
  }
  Future register()async{
   try{
     Response response=await post(
       Uri.parse("https://reqres.in/api/register"),
       body: {
         'email': email.text,
         'password': pass.text,
       }
     );
     if(response.statusCode==200)
       {
         var data=jsonDecode(response.body.toString());
         print(data);
         print('Successfully');
       }
     else {
       print('failed');
     }
   }catch(e){
     print(e.toString());
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Upload"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TextFormField(
          //   controller: email,
          // ),
          // TextFormField(
          //   controller: pass,
          // ),
          // ElevatedButton(onPressed: (){
          //   register();
          // }, child: Text('Signup'))
          GestureDetector(
            onTap: (){
              getImage();
            },
            child: Container(
              child: image == null ? Center(child: Text('Pick Image'),)
                  :
              Container(
                child: Center(
                  child: Image.file(
                    File(image!.path).absolute,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
