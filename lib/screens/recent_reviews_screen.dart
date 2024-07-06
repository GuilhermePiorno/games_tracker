import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/model/review.dart';

class RecentReviewsScreen extends StatefulWidget {
  @override
  _RecentReviewsScreenState createState() => _RecentReviewsScreenState();
}

class _RecentReviewsScreenState extends State<RecentReviewsScreen> {
  final DashboardController _controller = DashboardController();
  List<Review> _recentReviews = [];

  @override
  void initState() {
    super.initState();
    _fetchRecentReviews();
  }

  void _fetchRecentReviews() async {
    List<Review> reviews = await _controller.recentReviews();
    setState(() {
      _recentReviews = reviews;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews Recentes'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _recentReviews.length,
          itemBuilder: (context, index) {
            Review review = _recentReviews[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('${review.game_name}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nota: ${review.score}'),
                    Text('Descrição: ${review.description}'),
                    Text('Data: ${review.date}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
