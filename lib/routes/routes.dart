import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massup/pages/edit_profile_page.dart';
import 'package:massup/pages/home_page2.dart';
import 'package:massup/pages/login.dart';
import 'package:massup/pages/profile_page.dart';
import 'package:massup/pages/register.dart';
import 'package:massup/widgets/navbar.dart';

import '../pages/create_posts_page.dart';

final GoRouter app_router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            if (FirebaseAuth.instance.currentUser == null) {
              return LoginPage();
            } else {
              return FeedsPage();
            }
          },
        ),
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return RegisterPage();
          },
        ),
        GoRoute(
          path: 'create_post',
          builder: (BuildContext context, GoRouterState state) {
            if (FirebaseAuth.instance.currentUser == null) {
              return LoginPage();
            } else {
              return const CreatePostPage();
            }
          },
        ),
        GoRoute(
          path: 'profile/:profileId',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfilePage();
          },
        ),
        GoRoute(
          path: 'try',
          builder: (BuildContext context, GoRouterState state) {
            return NavBar();
          },
        ),
        GoRoute(
          path: 'editprofile/:id',
          builder: (BuildContext context, GoRouterState state) {
            return const EditProfilePage();
          },
        ),
        GoRoute(
          path: 'feeds',
          builder: (BuildContext context, GoRouterState state) {
            if (FirebaseAuth.instance.currentUser == null) {
              return LoginPage();
            } else {
              return const FeedsPage();
            }
          },
        ),
      ],
    ),
  ],
);
