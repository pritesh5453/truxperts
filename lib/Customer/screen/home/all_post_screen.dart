import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

class _Post {
  final String author;
  final String category;
  final String time;
  final String caption;
  final int likes;
  final int comments;
  final Color color;

  const _Post({
    required this.author,
    required this.category,
    required this.time,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.color,
  });
}

class AllPostsScreen extends StatelessWidget {
  const AllPostsScreen({super.key});

  static const List<_Post> _posts = [
    _Post(
      author: 'Amit Photography',
      category: 'Photographer',
      time: '2h ago',
      caption: 'Pre-wedding shoot available for this season. Book your date!',
      likes: 26,
      comments: 8,
      color: Color(0xFFE8D9C4),
    ),
    _Post(
      author: 'Drawn Wedding Planners',
      category: 'Wedding Planner',
      time: '3h ago',
      caption: 'Make your big day memorable with our expert planning.',
      likes: 32,
      comments: 5,
      color: Color(0xFFF3C9D6),
    ),
    _Post(
      author: 'Bing Ceremony Experts',
      category: 'Caterer',
      time: '4h ago',
      caption: 'Bing and ceremony services for your special moments.',
      likes: 41,
      comments: 12,
      color: Color(0xFFD9C9F3),
    ),
    _Post(
      author: 'Shah Etesh Events',
      category: 'Decorator',
      time: '5h ago',
      caption: 'Book a caterer, decorator, and photographers.',
      likes: 27,
      comments: 6,
      color: Color(0xFFD6C9B0),
    ),
    _Post(
      author: 'DJ Rhythmix',
      category: 'DJ',
      time: '6h ago',
      caption: 'Weekend slots open! Sound & lighting setup included.',
      likes: 19,
      comments: 4,
      color: Color(0xFFB9C4FF),
    ),
    _Post(
      author: 'Makeover by Priya',
      category: 'Makeup Artist',
      time: '7h ago',
      caption: 'Bridal packages now available with trial session.',
      likes: 38,
      comments: 9,
      color: Color(0xFFFFC9A6),
    ),
    _Post(
      author: 'Royal Events',
      category: 'Wedding Planner',
      time: '9h ago',
      caption: 'Full-service wedding planning, from venue to vows.',
      likes: 22,
      comments: 3,
      color: Color(0xFFA6D8FF),
    ),
    _Post(
      author: 'Dream Decorators',
      category: 'Decorator',
      time: '10h ago',
      caption: 'Fairy-light mandap setups starting this month.',
      likes: 30,
      comments: 7,
      color: Color(0xFFFFB9D6),
    ),
    _Post(
      author: 'Taste Affairs',
      category: 'Caterer',
      time: '12h ago',
      caption: 'New festive menu live now — book a tasting slot.',
      likes: 24,
      comments: 5,
      color: Color(0xFFE0F7EF),
    ),
    _Post(
      author: 'Shah Elah Events',
      category: 'Decorator',
      time: '1d ago',
      caption: 'Limited slots left for this wedding season.',
      likes: 18,
      comments: 2,
      color: Color(0xFFEFE9FF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Latest Posts from Professionals',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                itemCount: _posts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, index) => _PostCard(post: _posts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final _Post post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: post.color,
                child: const Icon(Icons.person, size: 12, color: Colors.white),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      '${post.category} • ${post.time}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 7,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: post.color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.image, color: Colors.white70, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            post.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
              color: AppColors.textDark,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.favorite_border, size: 10, color: AppColors.textGrey),
              const SizedBox(width: 2),
              Text('${post.likes}',
                  style: const TextStyle(fontSize: 7, color: AppColors.textGrey)),
              const SizedBox(width: 8),
              const Icon(Icons.mode_comment_outlined, size: 10, color: AppColors.textGrey),
              const SizedBox(width: 2),
              Text('${post.comments}',
                  style: const TextStyle(fontSize: 7, color: AppColors.textGrey)),
            ],
          ),
        ],
      ),
    );
  }
}