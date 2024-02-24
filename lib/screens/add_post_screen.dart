import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_paw/models/user_model.dart';

import 'package:pet_paw/resources/firestore_methods.dart';
import 'package:pet_paw/screens/feed_screen.dart';
import 'package:pet_paw/utils/colors.dart';
import 'package:pet_paw/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isLoading = false;
  String uid = '';
  String userName = '';
  String profileImage = '';
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a picture'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: const Text(
                  'Close',
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> fetchUserData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      var userData = await FirestoreMethods().getUserById(userId);
      setState(() {
        _user = userData;
        print("userId : ${_user.userName}");

        // Assign other properties if needed
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void clearFile() {
    setState(() {
      _file = null;
    });
  }

  void postImage(
    String uid,
    String userName,
    String profileImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, userName, profileImage);
      print('priniting from post Image $res');
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        clearFile();
        showSnackBar('Posted!', context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const FeedScreen()),
        );
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedScreen()),
            );
            clearFile();
          },
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 246, 246)),
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          if (_file != null)
            IconButton(
              onPressed: () =>
                  postImage(_user.uid, _user.userName, _user.photoUrl),
              icon: const Icon(
                Icons.send,
                color: mobileBackgroundColor,
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                ),
                style: const TextStyle(color: Colors.black),
                maxLength: 255,
                maxLines: 5,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _selectImage(context),
                    icon: const Icon(Icons.image),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        hintText: 'Add location (optional)',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              if (_file != null)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: MemoryImage(
                          _file!), // Use MemoryImage to load image from Uint8List
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              if (_isLoading) const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
