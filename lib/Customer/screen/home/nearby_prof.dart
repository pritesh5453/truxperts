import 'package:flutter/material.dart';
import 'package:truxperts/Customer/customs/customappbar.dart';
import 'package:truxperts/utils/navbar.dart';
import 'package:truxperts/utils/appcolors.dart';

class NearbyExpertsScreen1 extends StatefulWidget {
  const NearbyExpertsScreen1({Key? key}) : super(key: key);

  @override
  State<NearbyExpertsScreen1> createState() => _NearbyExpertsScreen1State();
}

class _NearbyExpertsScreen1State extends State<NearbyExpertsScreen1> {
  // Filter state
  String selectedFilter = 'All';
  final List<String> filters = ['All', 'Electrician', 'Plumber', 'Carpenter', 'Painter', 'Cleaning'];

  // Dummy experts data
  final List<Map<String, dynamic>> experts = [
    {
      'name': 'Rajesh Kumar',
      'category': 'Electrician',
      'rating': 4.8,
      'reviews': 127,
      'distance': '1.2 km',
      'experience': '8 years',
      'price': '₹500/hr',
      'available': true,
      'image': null,
    },
    {
      'name': 'Amit Singh',
      'category': 'Plumber',
      'rating': 4.6,
      'reviews': 89,
      'distance': '2.5 km',
      'experience': '5 years',
      'price': '₹400/hr',
      'available': true,
      'image': null,
    },
    {
      'name': 'Suresh Patel',
      'category': 'Carpenter',
      'rating': 4.9,
      'reviews': 203,
      'distance': '0.8 km',
      'experience': '12 years',
      'price': '₹600/hr',
      'available': false,
      'image': null,
    },
    {
      'name': 'Priya Sharma',
      'category': 'Painter',
      'rating': 4.7,
      'reviews': 156,
      'distance': '3.1 km',
      'experience': '6 years',
      'price': '₹450/hr',
      'available': true,
      'image': null,
    },
    {
      'name': 'Vikram Reddy',
      'category': 'Cleaning',
      'rating': 4.5,
      'reviews': 72,
      'distance': '1.8 km',
      'experience': '4 years',
      'price': '₹350/hr',
      'available': true,
      'image': null,
    },
    {
      'name': 'Manoj Gupta',
      'category': 'Electrician',
      'rating': 4.3,
      'reviews': 45,
      'distance': '4.2 km',
      'experience': '3 years',
      'price': '₹380/hr',
      'available': false,
      'image': null,
    },
  ];

  List<Map<String, dynamic>> get filteredExperts {
    if (selectedFilter == 'All') return experts;
    return experts.where((e) => e['category'] == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CustomAppBar(
        title: 'Nearby Experts',
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const NavBarScreen()),
          );
        },
      ),
      body: Column(
        children: [
          // ---------- Filter Chips ----------
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF001A4E) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF001A4E) : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ---------- Results Count ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredExperts.length} experts found',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.sort, size: 18, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      'Sort',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ---------- Experts List ----------
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredExperts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final expert = filteredExperts[index];
                return _ExpertCard(expert: expert);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Expert Card Widget
// ---------------------------------------------------------------------
class _ExpertCard extends StatelessWidget {
  final Map<String, dynamic> expert;

  const _ExpertCard({required this.expert});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image / Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: expert['image'] != null
                ? Image.network(expert['image'], fit: BoxFit.cover)
                : Icon(
                    Icons.person_outline,
                    size: 30,
                    color: Colors.grey.shade500,
                  ),
          ),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      expert['name'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001A4E),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        expert['available'] ? 'Available' : 'Busy',
                        style: TextStyle(
                          fontSize: 10,
                          color: expert['available'] ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${expert['rating']}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${expert['reviews']} reviews)',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _infoChip(Icons.work_outline, expert['category']),
                    const SizedBox(width: 6),
                    _infoChip(Icons.location_on, expert['distance']),
                    const SizedBox(width: 6),
                    _infoChip(Icons.schedule, expert['experience']),
                  ],
                ),
              ],
            ),
          ),

          // Price & Action
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                expert['price'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001A4E),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3DFA),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  minimumSize: const Size(0, 30),
                ),
                child: const Text(
                  'Book',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: Colors.grey.shade600),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}