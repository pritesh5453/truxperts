import 'package:flutter/material.dart';
import 'package:truxperts/customs/customappbar.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({Key? key}) : super(key: key);

  // Subcategories ka dummy data list ke liye
  final List<Map<String, dynamic>> subCategories = const [
    {
      'title': 'House Wiring',
      'desc': 'New wiring, rewiring & maintenance',
      'icon': Icons.bolt,
      'color': Colors.deepPurple,
    },
    {
      'title': 'Switch Board Repair',
      'desc': 'Installation & repair of switch boards',
      'icon': Icons.power,
      'color': Colors.blue,
    },
    {
      'title': 'Light & Fan Installation',
      'desc': 'Light, fan & chandelier installation',
      'icon': Icons.lightbulb_outline,
      'color': Colors.green,
    },
    {
      'title': 'MCB / Breaker Repair',
      'desc': 'MCB, fuse, breaker installation & repair',
      'icon': Icons.published_with_changes,
      'color': Colors.red,
    },
    {
      'title': 'Inverter Installation',
      'desc': 'Inverter wiring & installation',
      'icon': Icons.battery_charging_full,
      'color': Colors.blueAccent,
    },
    {
      'title': 'Electric Vehicle Charging',
      'desc': 'EV charger installation & repair',
      'icon': Icons.ev_station,
      'color': Colors.teal,
    },
    {
      'title': 'Electrical Inspection',
      'desc': 'Safety check & electrical inspection',
      'icon': Icons.gavel,
      'color': Colors.orange,
    },
    {
      'title': 'Generator Repair',
      'desc': 'Generator installation & repair',
      'icon': Icons.wb_iridescent,
      'color': Colors.indigo,
    },
    {
      'title': 'Earthing / Grounding',
      'desc': 'Earthing installation & testing',
      'icon': Icons.import_export,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Other Electrical Services',
      'desc': 'Other related electrical works',
      'icon': Icons.more_horiz,
      'color': Colors.blueGrey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001A4E), // Deep Blue background
      appBar: const CustomAppBar(title: 'Category Details'),
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
                // 1. Top Electrician Info Header Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    // Halka sa shadow effect jaisa image me clean look ke liye hai
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Large Icon Avatar
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.flash_on,
                          color: Colors.deepPurple,
                          size: 36,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Text Contents
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Electrician',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF001A4E),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Find trusted electricians for wiring, installation, repair & maintenance services.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              '120+ Professionals available',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 2. Sub Categories Section Title
                const Text(
                  'Sub Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001A4E),
                  ),
                ),
                const SizedBox(height: 12),

                // 3. Sub Categories List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subCategories.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: Color(0xFFF0F0F0)),
                  itemBuilder: (context, index) {
                    final item = subCategories[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: item['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          item['icon'],
                          color: item['color'],
                          size: 22,
                        ),
                      ),
                      title: Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF222222),
                        ),
                      ),
                      subtitle: Text(
                        item['desc'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onTap: () {
                        // Subcategory tap action yahan handle karein
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),

                // 4. Bottom "Can't find what you're looking for?" Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFF9F9FF,
                    ), // Halka bluish-white container tint
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFECECFF)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Can't find what you're looking for?",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF001A4E),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Post your service request and get\nresponses from professionals.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Post a Request Custom Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.send_rounded, size: 18),
                          label: const Text(
                            'Post a Request',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.deepPurple,
                            side: const BorderSide(
                              color: Colors.deepPurple,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
