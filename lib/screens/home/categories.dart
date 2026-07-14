import 'package:flutter/material.dart';
import 'package:truxperts/customs/customappbar.dart';
import 'package:truxperts/screens/home/subcategories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  // Popular Categories ka dummy data (Grid ke liye)
  final List<Map<String, dynamic>> popularCategories = const [
    {'name': 'Electrician', 'icon': Icons.flash_on, 'color': Colors.purple},
    {'name': 'Plumber', 'icon': Icons.plumbing, 'color': Colors.blue},
    {'name': 'Carpenter', 'icon': Icons.construction, 'color': Colors.orange},
    {'name': 'Painter', 'icon': Icons.format_paint, 'color': Colors.red},
    {'name': 'AC Repair', 'icon': Icons.ac_unit, 'color': Colors.blueAccent},
    {'name': 'Cleaning', 'icon': Icons.cleaning_services, 'color': Colors.green},
    {'name': 'Pest Control', 'icon': Icons.bug_report, 'color': Colors.redAccent},
    {'name': 'Washing Machine', 'icon': Icons.local_laundry_service, 'color': Colors.indigo},
    {'name': 'Laptop Repair', 'icon': Icons.laptop, 'color': Colors.deepPurple},
    {'name': 'Mobile Repair', 'icon': Icons.phone_android, 'color': Colors.teal},
    {'name': 'Appliance Repair', 'icon': Icons.kitchen, 'color': Colors.orangeAccent},
    {'name': 'More', 'icon': Icons.apps, 'color': Colors.grey},
  ];

  // All Categories ka dummy data (List ke liye)
  final List<Map<String, String>> allCategories = const [
    {'name': 'Electrician', 'desc': 'Wiring, Installation, Repair'},
    {'name': 'Plumber', 'desc': 'Pipes, Fixtures, Tank Cleaning'},
    {'name': 'Carpenter', 'desc': 'Furniture, Repair, Wood Work'},
    {'name': 'Painter', 'desc': 'Home Painting, Wall Painting'},
    {'name': 'AC Repair', 'desc': 'AC Service, Gas Refill, Installation'},
    {'name': 'Cleaning', 'desc': 'Home, Office, Deep Cleaning'},
    {'name': 'Pest Control', 'desc': 'Termite, Cockroach, Rodent Control'},
    {'name': 'Washing Machine Repair', 'desc': 'Washing Machine Service & Repair'},
    {'name': 'Refrigerator Repair', 'desc': 'Fridge Service & Repair'},
    {'name': 'TV Repair', 'desc': 'LED, LCD, Smart TV Repair'},
    {'name': 'Mobile Repair', 'desc': 'All Brands, Screen, Battery'},
    {'name': 'Laptop Repair', 'desc': 'All Brands, Hardware, Software'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001A4E), // Appbar se match karta background
      appBar: const CustomAppBar(title: 'All Categories'),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.grey),
                      hintText: 'Search categories...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 2. Popular Categories Section Title
                const Text(
                  'Popular Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // 3. Popular Categories Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: popularCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = popularCategories[index];
                    return InkWell(
  borderRadius: BorderRadius.circular(12),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CategoryDetailsScreen(),
      ),
    );
  },
  child: Column(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: item['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          item['icon'],
          color: item['color'],
          size: 28,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        item['name'],
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),
);
                  },
                ),
                const SizedBox(height: 24),

                // 4. All Categories Section Title
                const Text(
                  'All Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // 5. All Categories List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allCategories.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF0F0F0)),
                  itemBuilder: (context, index) {
                    final item = allCategories[index];
                    // Grid wale map se icon and color fetch karne ke liye matching logic
                    final matchedIconInfo = popularCategories.firstWhere(
                      (p) => item['name']!.contains(p['name']),
                      orElse: () => {'icon': Icons.build, 'color': Colors.blueGrey},
                    );

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: matchedIconInfo['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(matchedIconInfo['icon'], color: matchedIconInfo['color'], size: 20),
                      ),
                      title: Text(
                        item['name']!,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        item['desc']!,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                      onTap: () {},
                    );
                  },
                ),
                const SizedBox(height: 16),

                // 6. View More Categories Button
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Text(
                      'View More Categories',
                      style: TextStyle(color: Color(0xFF001A4E), fontWeight: FontWeight.bold),
                    ),
                    label: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF001A4E)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}