import 'package:flutter/material.dart';

class SubcategoryPopupWidget extends StatefulWidget {
  const SubcategoryPopupWidget({Key? key}) : super(key: key);

  @override
  State<SubcategoryPopupWidget> createState() => _SubcategoryPopupWidgetState();
}

class _SubcategoryPopupWidgetState extends State<SubcategoryPopupWidget> {
  // Demo Data array screenshot ke items aur icons ke sath
  final List<Map<String, dynamic>> subcategories = [
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
      'color': Colors.indigo,
    },
    {
      'title': 'Light & Fan Installation',
      'desc': 'Light, fan & chandelier installation',
      'icon': Icons.wb_twilight,
      'color': Colors.green,
    },
    {
      'title': 'MCB / Breaker Repair',
      'desc': 'MCB, fuse, breaker installation & repair',
      'icon': Icons.dataset_linked_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'Inverter Installation',
      'desc': 'Inverter wiring & installation',
      'icon': Icons.tv,
      'color': Colors.blue,
    },
    {
      'title': 'Other Electrical Services',
      'desc': 'Other related electrical works',
      'icon': Icons.water_drop_outlined,
      'color': Colors.teal,
    },
  ];

  // Default selected index (House Wiring pehla item selected dikhane ke liye)
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Keyboard open hone par bottom spacing handle karne ke liye padding media query
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height:
          MediaQuery.of(context).size.height *
          0.82, // Total screen ka 82% height
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // 1. Popup Top Header & Drag Indicator
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF001A4E)),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Select Subcategory',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001A4E),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 48,
                ), // Balance spacing maintaining center alignment
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 2. Search Bar Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[500]!.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey, size: 22),
                  hintText: 'Search subcategories...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 3. Scrollable List Section
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: subcategories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = subcategories[index];
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon Container Left side wala
                        Container(
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
                        const SizedBox(width: 14),

                        // Text Description center side wala
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF001A4E),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['desc'],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Blue Custom Radio Circle Button
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF3F3DFA)
                                  : Colors.grey.shade300,
                              width: isSelected ? 6 : 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 4. Bottom Fixed Action Button Container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  offset: const Offset(0, -4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: ElevatedButton(
                onPressed: () {
                  // Pass selected item data back to screen
                  Navigator.pop(context, subcategories[selectedIndex]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF3F3DFA,
                  ), // Exact royal blue shade button
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Select Subcategory',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
