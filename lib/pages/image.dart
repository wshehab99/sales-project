import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File imageFile;
  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.platform
        .pickImage(source: source, maxHeight: 400.0, maxWidth: 400.0)
        .then((PickedFile imagee) {
      setState(() {
        imageFile = File(imagee.path);
      });
      Navigator.pop(context);
    });
  }

  void _OpenImagePicker(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 130.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pick image',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('camera')
                    ],
                  )),
              FlatButton(
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.photo),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('galery')
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          OutlineButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              _OpenImagePicker(context);
            },
            child: Row(
              children: [
                Icon(Icons.add_a_photo),
                SizedBox(
                  width: 5.0,
                ),
                Text('Add Image')
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          imageFile == null
              ? Text('Plese pick an image')
              : Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                )
        ],
      ),
    );
  }
}
