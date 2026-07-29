import 'package:flutter/material.dart';
import 'package:truxperts/screens/Requests/advance/quote_screen.dart';
import 'package:truxperts/utils/appcolors.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLightBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Request Details',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Card (Service Info, Request ID, Status)
            _buildHeaderCard(),
            const SizedBox(height: 12),

            // 2. Event Date & Location Cards
            _buildDateAndLocationRow(),
            const SizedBox(height: 20),

            // 3. Request Summary Section
            _buildRequestSummary(),
            const SizedBox(height: 24),

            // 4. Quotes Received Header & Info Banner
            _buildQuotesHeader(),
            const SizedBox(height: 12),
            _buildInfoBanner(),
            const SizedBox(height: 16),

            // 5. List of Service Cards
            _buildQuoteCard( context,
              title: 'Click Magic Studios',
              isVerified: true,
              isRecommended: true,
              rating: '5.0',
              reviews: '128 Reviews',
              experience: '7 Years in Business',
              price: '₹55,000',
              validity: 'Valid Till: 12 Jul 2025',
              features: const [
                'Full Day Coverage',
                'Cinematic Video',
                'Photo Album (40 pages)',
                'Drone Shoot',
              ],
              extraFeaturesCount: '+2 more',
              imageUrl: 'https://i.pravatar.cc/150?img=11',
            ),
            const SizedBox(height: 16),

            _buildQuoteCard( context,
              title: 'Picture Perfect',
              isVerified: true,
              isRecommended: false,
              rating: '4.8',
              reviews: '96 Reviews',
              experience: '5 Years in Business',
              price: '₹48,000',
              validity: 'Valid Till: 10 Jul 2025',
              features: const [
                'Full Day Coverage',
                'Cinematic Video',
                'Photo Album (30 pages)',
                'Drone Shoot',
              ],
              extraFeaturesCount: '+1 more',
              imageUrl: 'https://i.pravatar.cc/150?img=12',
            ),
            const SizedBox(height: 16),

            _buildQuoteCard( context,
              title: 'Shutter Stories',
              isVerified: true,
              isRecommended: false,
              rating: '4.6',
              reviews: '72 Reviews',
              experience: '6 Years in Business',
              price: '₹45,000',
              validity: 'Valid Till: 11 Jul 2025',
              features: const [
                'Full Day Coverage',
                'Cinematic Video',
                'Photo Album (20 pages)',
              ],
              imageUrl: 'https://i.pravatar.cc/150?img=33',
            ),
            const SizedBox(height: 16),

            _buildQuoteCard( context,
              title: 'Frame Masters',
              isVerified: true,
              isRecommended: false,
              rating: '4.4',
              reviews: '54 Reviews',
              experience: '4 Years in Business',
              price: '₹40,000',
              validity: 'Valid Till: 09 Jul 2025',
              features: const [
                '8 Hours Coverage',
                'Cinematic Video',
                'Photo Album (20 pages)',
              ],
              imageUrl: 'https://i.pravatar.cc/150?img=68',
            ),
            const SizedBox(height: 16),

            // 6. Bottom Banner (Need more options?)
            _buildBottomBanner(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Header Card ---
  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.iconPhotographerBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: AppColors.iconPhotographerFg,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Wedding Photography',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.advanceBannerBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Advance Booking',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Request ID: ADV-250708-1024',
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text(
                      'Status : ',
                      style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.badgePendingBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Looking for Quotes',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.badgePendingText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Date & Location ---
  Widget _buildDateAndLocationRow() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoBox(
            icon: Icons.calendar_month_outlined,
            iconBg: AppColors.advanceBannerBg,
            iconFg: AppColors.primaryPurple,
            label: 'Event Date',
            value: '15 Aug 2025',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoBox(
            icon: Icons.location_on_outlined,
            iconBg: AppColors.advanceBannerBg,
            iconFg: AppColors.primaryPurple,
            label: 'Location',
            value: 'Pune, Maharashtra',
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconFg, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: AppColors.textGrey),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- Request Summary ---
  Widget _buildRequestSummary() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.cardBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Action Button Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Request Summary',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: AppColors.primaryPurple,
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        
        // Description Text
        const Text(
          'We need a professional photographer for our wedding on 15th Aug. Full day coverage including candid, traditional, cinematic video and album.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textGrey,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        
        // Tags / Metadata Row (Guests & Event Type)
        Row(
          children: [
            const Icon(
              Icons.people_outline,
              size: 16,
              color: AppColors.primaryPurple,
            ),
            const SizedBox(width: 6),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                children: [
                  TextSpan(text: 'Guests: '),
                  TextSpan(
                    text: '200 – 300',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            const Icon(
              Icons.assignment_outlined,
              size: 16,
              color: AppColors.primaryPurple,
            ),
            const SizedBox(width: 6),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                children: [
                  TextSpan(text: 'Event Type: '),
                  TextSpan(
                    text: 'Wedding',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}
  // --- Quotes Header ---
  Widget _buildQuotesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Quotes Received (4)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Row(
            children: [
              Icon(Icons.info_outline, size: 14, color: AppColors.primaryPurple),
              SizedBox(width: 4),
              Text(
                'How it works?',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // --- Info Banner ---
  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.advanceBannerBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.shield_outlined, color: AppColors.primaryPurple, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Choose the best professional for your event.\nYou won\'t be charged until you confirm the booking.',
              style: TextStyle(fontSize: 11, color: AppColors.textDark, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  // --- Quote Card Widget ---
  Widget _buildQuoteCard( BuildContext context, {
    required String title,
    required bool isVerified,
    required bool isRecommended,
    required String rating,
    required String reviews,
    required String experience,
    required String price,
    required String validity,
    required List<String> features,
    String? extraFeaturesCount,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.check_circle, color: AppColors.blueAccent, size: 16),
                        ]
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.star, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          ' ($reviews)',
                          style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      experience,
                      style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              if (isRecommended)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.advanceBannerBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ),
          ],
          ),
          const SizedBox(height: 12),

          // Price & Features
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price side
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Text(
                    'Total Package Price',
                    style: TextStyle(fontSize: 10, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.check, color: AppColors.success, size: 12),
                      SizedBox(width: 2),
                      Text(
                        'Includes all taxes',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.success,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Features list side
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...features.map(
                        (feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.grid_view_rounded,
                                size: 12,
                                color: AppColors.primaryPurple,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textDark,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (extraFeaturesCount != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            extraFeaturesCount,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.primaryPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Footer (Validity & Buttons)
          Row(
            children: [
              Expanded(
                child: Text(
                  validity,
                  style: const TextStyle(fontSize: 10, color: AppColors.textGrey),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const QuoteDetailsScreen()));
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.borderLight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Select & Book',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // --- Bottom Banner ---
  Widget _buildBottomBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.advanceBannerBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.shield_outlined, color: AppColors.primaryPurple, size: 20),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need more options?',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'We\'ll notify more professionals for you.',
                    style: TextStyle(fontSize: 10, color: AppColors.textGrey),
                  ),
                ],
              ),
            ],
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: AppColors.borderLight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Notify More',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}