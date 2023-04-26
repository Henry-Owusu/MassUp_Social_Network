import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massup/services/auth_service.dart';
import 'package:massup/services/post_service.dart';
import 'package:massup/services/user_service.dart';
import 'package:massup/widgets/navbar.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _titleController = TextEditingController();

  AppUser user = AppUser();
  AuthService auth = AuthService();

  onSubmit() async {
    bool success = false;
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String content = _contentController.text;

      await submitPost(title, content).then((value) => success = true);

      if (success) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Post created successfully!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    context.go('/feeds');
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@ashesi\.edu\.gh$');

    return Center(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: NavBar(),
          title: const Center(child: Text('Sign Up')),
        ),
        body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Ashesi2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, 
        children: [
          Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: 500,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter post title ',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a titkle';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      TextFormField(
                          controller: _contentController,
                          decoration: const InputDecoration(
                            labelText: 'Post content',
                            hintText: 'Enter post content',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a content';
                            }
                            return null;
                          }),
                      const SizedBox(height: 32),
                      ElevatedButton(
                          child: const Text('Create Post'),
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              onSubmit();
                              // Handle form submission
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      ),
    )
      )
    );
  }
}


