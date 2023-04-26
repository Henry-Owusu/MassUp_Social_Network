import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massup/services/user_service.dart';
import 'package:massup/widgets/navbar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _yearGroupController = TextEditingController();
  late TextEditingController _favoriteFoodController = TextEditingController();
  late TextEditingController _bestMovieController = TextEditingController();
  late TextEditingController _majorController = TextEditingController();
  late TextEditingController _campusResidence = TextEditingController();

  AppUser user = AppUser();
  Future<void> _fetchProfileData() async {
    try {
      final data =
          await user.getProfile(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        _yearGroupController = TextEditingController(text: data['yearGroup']);
        _favoriteFoodController = TextEditingController(text: data['bestfood']);
        _bestMovieController = TextEditingController(text: data['bestmovie']);
        _majorController = TextEditingController(text: data['major']);
        _campusResidence = TextEditingController(text: data['residence']);
      });
    } catch (e) {
      // throw Exception();
      print(e.toString());
      // print('An error occurred while fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  handleSubmit() async {
    Map<String, dynamic> data = {
      'major': _majorController.text,
      'yearGroup': _yearGroupController.text,
      'bestfood': _favoriteFoodController.text,
      'bestmovie': _bestMovieController.text,
      'residence': _campusResidence.text
    };

    try {
      await AppUser.updateProfile(data, FirebaseAuth.instance.currentUser!.uid);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Profile'),
          content: const Text('Updated'),
          actions: [
            TextButton(
              onPressed: () => context
                  .go('/profile/${FirebaseAuth.instance.currentUser!.uid}'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print("error occured while updating profile  $e ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 107, 151, 228),
        appBar: AppBar(
          flexibleSpace: NavBar(),
        ),
        body: Center(
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
                      Image.asset('images/logo.png'),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _yearGroupController,
                        decoration: const InputDecoration(
                          labelText: 'Year Group',
                          hintText: 'Enter your year group',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your favorite food';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _majorController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Major',
                          hintText: 'Enter your major',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your school ID';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _campusResidence,
                        decoration: const InputDecoration(
                          labelText: 'Campus Residence',
                          hintText: 'Enter Campus Residence',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your campus residence';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _bestMovieController,
                        decoration: const InputDecoration(
                          labelText: 'Favorite Movie',
                          hintText: 'Enter your favorite movie',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your favorite food';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _favoriteFoodController,
                        decoration: const InputDecoration(
                          labelText: 'Favorite Food',
                          hintText: 'Enter your favorite food',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your favorite food';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                          child: const Text('Update'),

                          //     TextButton(
                          //       onPressed()=>{context.go('/dash')}, child: const Text('Or sign up here? ', style: TextStyle(
                          // color: Colors.white10,
                          //     ),

                          onPressed: () {
                            handleSubmit();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
