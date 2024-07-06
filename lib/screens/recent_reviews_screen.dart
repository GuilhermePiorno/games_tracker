import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/model/review.dart';
import 'package:games_tracker/model/user.dart';
import 'package:games_tracker/screens/review_details_screen.dart';

class RecentReviewsScreen extends StatefulWidget {
  final User user;

  const RecentReviewsScreen({super.key, required this.user});

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
                title: Text('Review número: ${review.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nota: ${review.score}'),
                    Text('Data: ${review.date}'),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewDetailsScreen(
                            review: review, user: widget.user)),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
