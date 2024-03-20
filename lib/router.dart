import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:social_crossplatform/features/auth/screens/login_screen.dart';
import 'package:social_crossplatform/features/extensions/chatbot/chat_bot_screen.dart';
import 'package:social_crossplatform/features/community/screens/add_mods_screen.dart';
import 'package:social_crossplatform/features/community/screens/community_screen.dart';
import 'package:social_crossplatform/features/community/screens/create_community_screen.dart';
import 'package:social_crossplatform/features/community/screens/edit_community_screen.dart';
import 'package:social_crossplatform/features/community/screens/mod_tools_screen.dart';
import 'package:social_crossplatform/features/extensions/extensions_screen.dart';
import 'package:social_crossplatform/features/home/screens/home_screen.dart';
import 'package:social_crossplatform/features/extensions/image_to_text/image_to_text_screen.dart';
import 'package:social_crossplatform/features/live_stream/start_live_stream_screen.dart';
import 'package:social_crossplatform/features/post/screens/add_post_screen.dart';
import 'package:social_crossplatform/features/post/screens/add_post_type_screen.dart';
import 'package:social_crossplatform/features/post/screens/comments_screen.dart';
import 'package:social_crossplatform/features/extensions/speech_to_text/speech_to_text_screen.dart';
import 'package:social_crossplatform/features/user_profile/screens/edit_user_profile_screen.dart';
import 'package:social_crossplatform/features/user_profile/screens/user_profile_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (context) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (context) => const MaterialPage(child: HomeScreen()),
  '/create-community': (context) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/c/:name': (context) => MaterialPage(
        child: CommunityScreen(
          name: context.pathParameters['name']!,
        ),
      ),
  '/mod-tools/:name': (context) => MaterialPage(
        child: ModToolsScreen(
          name: context.pathParameters['name']!,
        ),
      ),
  '/edit-community/:name': (context) => MaterialPage(
        child: EditCommunityScreen(
          name: context.pathParameters['name']!,
        ),
      ),
  '/add-mods/:name': (context) => MaterialPage(
        child: AddModsScreen(
          name: context.pathParameters['name']!,
        ),
      ),
  '/u/:uid': (context) => MaterialPage(
        child: UserProfileScreen(
          uid: context.pathParameters['uid']!,
        ),
      ),
  '/edit-user-profile/:uid': (context) => MaterialPage(
        child: EditUserProfileScreen(
          uid: context.pathParameters['uid']!,
        ),
      ),
  '/add-post/:type': (context) => MaterialPage(
        child: AddPostTypeScreen(
          type: context.pathParameters['type']!,
        ),
      ),
  '/post/:postId/comments': (context) => MaterialPage(
        child: CommentsScreen(
          postId: context.pathParameters['postId']!,
        ),
      ),
  '/add-post': (context) => const MaterialPage(child: AddPostScreen()),
  
  '/extensions': (context) => const MaterialPage(child: ExtensionsScreen()),
  '/chat-bot': (context) => const MaterialPage(child: ChatBotScreen()),
  '/speech-to-text': (context) => const MaterialPage(child: SpeechToTextScreen()),
  '/image-to-text': (context) => const MaterialPage(child: ImageToTextScreen()),
  '/start-live-stream': (context) => const MaterialPage(child: StartLiveStreamScreen()),
});
