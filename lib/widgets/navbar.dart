import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massup/services/auth_service.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 22, 216, 223),
        elevation: 0,
        titleSpacing: 0,
        leading: isLargeScreen
            ? null
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png', width: 50, height:50),
              if (isLargeScreen) Expanded(child: _navBarItems(context))
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: _ProfileIcon()),
          )
        ],
      ),
      drawer: isLargeScreen ? null : _drawer(),
    );
  }

  Widget _drawer() => Drawer(
        child: ListView(
          children: _menuItems
              .map((item) => ListTile(
                    onTap: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    title: Text(item['item']),
                  ))
              .toList(),
        ),
      );

  Widget _navBarItems(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: FirebaseAuth.instance.currentUser?.uid == null
            ? _menuItems
                .map(
                  (item) => InkWell(
                    onTap: () {
                      context.go(item['route']);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 16),
                      child: Text(
                        item['item'],
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                )
                .toList()
            : _menuItems2
                .map(
                  (item) => InkWell(
                    onTap: () {
                      context.go(item['route']);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 16),
                      child: Text(
                        item['item'],
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                )
                .toList(),
      );
}

final List<Map> _menuItems = [
  {'item': 'Feeds', 'route': '/feeds'},
  {'item': 'Login', 'route': '/login'},
  {'item': 'Register', 'route': '/register'},
  {'item': 'Create', 'route': '/create_post'},
];

final List<Map> _menuItems2 = [
  {'item': 'Feeds', 'route': '/feeds'},
  {'item': 'Create', 'route': '/create_post'},
];

enum Menu { itemOne, itemTwo, itemThree }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();

    return PopupMenuButton<Menu>(
        icon: const Icon(Icons.person),
        offset: const Offset(0, 40),
        onSelected: (Menu item) {},
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              PopupMenuItem<Menu>(
                onTap: () {
                  context
                      .go('/profile/${FirebaseAuth.instance.currentUser?.uid}');
                },
                value: Menu.itemOne,
                child: Text('Account'),
              ),
              PopupMenuItem<Menu>(
                onTap: () {
                  context.go(
                      '/editprofile/${FirebaseAuth.instance.currentUser?.uid}');
                },
                value: Menu.itemTwo,
                child: Text('Edit'),
              ),
              PopupMenuItem<Menu>(
                onTap: () {
                  auth.signOut();
                  context.go('/');
                },
                value: Menu.itemThree,
                child: Text('Sign Out'),
              ),
            ]);
  }
}
