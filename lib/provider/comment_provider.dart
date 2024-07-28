import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Comment {
  final String name;
  final String email;
  final String body;

  Comment({
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

class CommentProvider with ChangeNotifier {
  List<Comment> commentsData = [];
  String sFetchDataUrl = 'https://jsonplaceholder.typicode.com/comments';
  bool bIsLoading = false;
  String? sErrorMessage;

  final StreamController<List<Comment>> commentsDataStreamController = StreamController<List<Comment>>.broadcast();

  List<Comment> get comments => commentsData;
  bool get isLoading => bIsLoading;
  String? get errorMessage => sErrorMessage;
  Stream<List<Comment>> get commentsStream => commentsDataStreamController.stream;

  CommentProvider() {
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    fetchComments();
  }

  Future<void> fetchComments() async {
    bIsLoading = true;
    sErrorMessage = null;
    _safeNotifyListeners();

    try {
      final response = await http.get(Uri.parse(sFetchDataUrl));

      if (response.statusCode == 200) {
        final List<dynamic> commentJson = json.decode(response.body);
        final bool shouldMaskEmail = await _getShouldMaskEmail();
        print('Remote Config - should_mask_email: $shouldMaskEmail');

        commentsData = commentJson.map((json) => Comment.fromJson(json)).toList();

        final User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String loggedInEmail = user.email!;
          if (loggedInEmail.isNotEmpty) {
            loggedInEmail = loggedInEmail[0].toUpperCase() + loggedInEmail.substring(1);
          }
          print("loggedInEmail: $loggedInEmail");

          if (shouldMaskEmail) {
            loggedInEmail = _maskEmail(loggedInEmail);
            commentsData = commentsData.map((comment) {
              return Comment(
                name: comment.name,
                email: _maskEmail(comment.email),
                body: comment.body,
              );
            }).toList();
          }

          commentsData = commentsData.where((comment) => comment.email == loggedInEmail).toList();
        }

        commentsDataStreamController.add(commentsData);
      } else {
        sErrorMessage = 'Failed to load comments: ${response.statusCode}';
        commentsDataStreamController.addError(sErrorMessage!);
      }
    } catch (error) {
      sErrorMessage = 'An error occurred: $error';
      commentsDataStreamController.addError(sErrorMessage!);
    } finally {
      bIsLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<bool> _getShouldMaskEmail() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(minutes: 1),
      ));
      await remoteConfig.fetchAndActivate();
      return remoteConfig.getBool('should_mask_email');
    } catch (e) {
      print('Remote Config fetch failed: $e');
      return false;
    }
  }

  String _maskEmail(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex <= 3) {
      return email;
    }
    final masked = email.substring(0, 3) + '****' + email.substring(atIndex);
    return masked;
  }

  void _safeNotifyListeners() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    commentsDataStreamController.close();
    super.dispose();
  }
}
