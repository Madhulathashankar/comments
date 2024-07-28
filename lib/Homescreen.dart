import 'package:comments/provider/comment_provider.dart';
import 'package:comments/utils/color_const.dart';
import 'package:comments/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<CommentProvider>(context, listen: false).fetchComments();
  }

  @override
  Widget build(BuildContext context) {

    final commentProvider = Provider.of<CommentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 10),
            UiText(
              sTextName: "Comments",
              dTextSize: 24.0,
              colorOfText: Colors.white,
              iBoldness: 6,
            )
          ],
        ),
        backgroundColor: kBlueColor,
        automaticallyImplyLeading: false,
      ),

      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: StreamBuilder<List<Comment>>(
                  stream: commentProvider.commentsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: UiText(
                          sTextName: 'Error: ${snapshot.error}',
                          dTextSize: 20,
                          colorOfText: Colors.black,
                          iBoldness: 6,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: UiText(
                          sTextName: 'No comments available',
                          dTextSize: 20,
                          colorOfText: Colors.black,
                          iBoldness: 3,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final comment = snapshot.data![index];
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 13.0, 10.0),
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10.0, 16.0, 0.0, 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: circularAvatarBackgroundColor,
                                          radius: 27,
                                          child: UiText(
                                            sTextName: comment.email[0].toUpperCase(),
                                            dTextSize: 20,
                                            colorOfText: Colors.black,
                                            iBoldness: 6,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    UiText(
                                                      sTextName: 'Name: ',
                                                      dTextSize: 16,
                                                      colorOfText: Colors.grey,
                                                      iBoldness: 5,
                                                    ),
                                                    UiText(
                                                      sTextName: comment.name,
                                                      dTextSize: 16,
                                                      colorOfText: Colors.black,
                                                      iBoldness: 6,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  UiText(
                                                    sTextName: 'Email: ',
                                                    dTextSize: 16,
                                                    colorOfText: Colors.grey,
                                                    iBoldness: 5,
                                                  ),
                                                  UiText(
                                                    sTextName: comment.email,
                                                    dTextSize: 16,
                                                    colorOfText: Colors.black,
                                                    iBoldness: 6,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              UiText(
                                                sTextName: comment.body,
                                                dTextSize: 14,
                                                colorOfText: Colors.black,
                                                iBoldness: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
