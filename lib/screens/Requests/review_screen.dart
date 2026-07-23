import 'package:flutter/material.dart';
import 'package:truxperts/screens/Requests/thank_you_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    super.key,
    this.vendorName = 'Amit Electricals',
    this.rating = 4.7,
    this.reviewCount = 128,
    this.amount = 1200,
  });

  final String vendorName;
  final double rating;
  final int reviewCount;
  final int amount;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _selectedStars = 5;
  bool? _wouldRecommend = true;
  final TextEditingController _reviewController = TextEditingController(
    text:
        'He did a great job. Very professional and on time. Highly recommended!',
  );
  final int _maxReviewLength = 300;

  static const List<String> _ratingLabels = [
    '',
    'Poor',
    'Fair',
    'Good',
    'Very Good',
    'Excellent',
  ];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _buildVendorCard(),
            const SizedBox(height: 20),
            _buildExperienceSection(),
            const SizedBox(height: 20),
            _buildReviewTextSection(),
            const SizedBox(height: 20),
            _buildPhotosSection(),
            const SizedBox(height: 20),
            _buildRecommendSection(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Submit Review',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bg,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    );
  }

  Widget _buildVendorCard() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.chipUnselected,
          backgroundImage: NetworkImage(
            'https://randomuser.me/api/portraits/men/32.jpg',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.vendorName,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.verified_rounded,
                      color: AppColors.blueAccent, size: 15),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star_rounded,
                      color: AppColors.star, size: 15),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.rating} (${widget.reviewCount} Reviews)',
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How was your experience?',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final int starValue = index + 1;
            final bool isFilled = starValue <= _selectedStars;
            return IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              constraints: const BoxConstraints(),
              onPressed: () => setState(() => _selectedStars = starValue),
              icon: Icon(
                isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                color: AppColors.primaryPurple,
                size: 34,
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Center(
          child: Text(
            _ratingLabels[_selectedStars],
            style: const TextStyle(
              color: AppColors.success,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewTextSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Write a Review (Optional)',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.fieldBorder),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _reviewController,
                maxLength: _maxReviewLength,
                maxLines: 4,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    null,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: 'Share your experience...',
                  hintStyle: TextStyle(color: AppColors.hintText),
                ),
                onChanged: (_) => setState(() {}),
              ),
              Text(
                '${_reviewController.text.length}/$_maxReviewLength',
                style: const TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotosSection() {
    final List<String> photoUrls = [
      'https://picsum.photos/seed/wiring1/200/200',
      'https://picsum.photos/seed/wiring2/200/200',
      'https://picsum.photos/seed/wiring3/200/200',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Photos (Optional)',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: photoUrls.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index == photoUrls.length) {
                return DottedAddTile(onTap: () {});
              }
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  photoUrls[index],
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Would you recommend this vendor?',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _recommendButton(
                label: 'Yes',
                icon: Icons.thumb_up_alt_outlined,
                isSelected: _wouldRecommend == true,
                onTap: () => setState(() => _wouldRecommend = true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _recommendButton(
                label: 'No',
                icon: Icons.chat_bubble_outline_rounded,
                isSelected: _wouldRecommend == false,
                onTap: () => setState(() => _wouldRecommend = false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _recommendButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryPurple : AppColors.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primaryPurple : AppColors.fieldBorder,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : AppColors.textDark,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ThankYouScreen(
          amount: widget.amount,
          starRating: _selectedStars,
        ),
      ),
    );
  }
}

class DottedAddTile extends StatelessWidget {
  const DottedAddTile({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.chipUnselected,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.fieldBorder,
          ),
        ),
        child: const Icon(
          Icons.add_rounded,
          color: AppColors.textGrey,
          size: 24,
        ),
      ),
    );
  }
}