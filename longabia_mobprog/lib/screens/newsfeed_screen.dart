import 'package:flutter/material.dart';

import '../widgets/newsfeed_card.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewsFeedCard(
          userName: 'Justine Longabia',
          postContent: 'Kamusta mga troooopaaaaaaaaaaaa',
          numOfLikes: 100,
          numOfComments: 12,
          date: 'October 11',
          profileImage: 'assets/images/Full_image_of_Tung_Tung_Tung_Sahur.png',
        ),
        NewsFeedCard(
          userName: 'Ryan Acoba',
          postContent: 'Kicking off the holiday season with my 100million morning trade!',
          numOfLikes: 200,
          numOfComments: 42,
          date: 'December 2',
          imagePath: 'assets/images/trading_sesh.jpg',
          profileImage: 'assets/images/mogger_ryan.jpg',
        ),
      ],
    );
  }
}
