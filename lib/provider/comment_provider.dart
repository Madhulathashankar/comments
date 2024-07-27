
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comment {
  final String name;
  final String email;
  final String body;

  Comment({required this.name, required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

class CommentProvider with ChangeNotifier {
  List<Comment> _comments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchComments() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

      if (response.statusCode == 200) {
        final List<dynamic> commentJson = json.decode(response.body);
        _comments = commentJson.map((json) => Comment.fromJson(json)).toList();
      } else {
        _errorMessage = 'Failed to load comments';
      }
    } catch (error) {
      _errorMessage = 'An error occurred';
    }

    _isLoading = false;
    notifyListeners();
  }
}
