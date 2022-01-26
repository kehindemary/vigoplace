import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vigoplace/core/colors/colors.dart';
import 'package:vigoplace/core/constants/sizes.dart';
import 'package:vigoplace/core/constants/utils.dart';
import 'package:vigoplace/core/providers/user.dart';
import 'package:vigoplace/core/services/firebase_method.dart';
import 'package:vigoplace/widgets/button.dart';
import 'package:vigoplace/widgets/top_nav.dart';

class PostScreen extends StatefulWidget {
  static String routeName = 'PostScreen';
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          TopNavigation(
              title: 'Create Post',
              widget: Button(
                  buttonText: 'Share',
                  color: kPurple,
                  textColor: kWhite,
                  onPressed: () => postImage(
                        userProvider.getUser.uid,
                        userProvider.getUser.username,
                        userProvider.getUser.photoUrl,
                      ),
                  width: 100,
                  fontSize: 14)),
          SizedBox(
            height: sizeFit(false, 20, context),
          ),
          _file == null
              ? Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.upload,
                    ),
                    onPressed: () => _selectImage(context),
                  ),
                )
              : Column(
                  children: <Widget>[
                    isLoading
                        ? const LinearProgressIndicator()
                        : const Padding(padding: EdgeInsets.only(top: 0.0)),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://i.stack.imgur.com/Jkfme.png?s=256&g=1',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                                hintText: "Write a caption...",
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          height: 45.0,
                          width: 45.0,
                          child: AspectRatio(
                            aspectRatio: 487 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                                image: MemoryImage(_file!),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                )
        ],
      ),
    ));
  }
}
