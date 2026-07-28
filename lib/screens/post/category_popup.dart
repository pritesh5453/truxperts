import 'package:flutter/material.dart';

// If you have a shared file for ServiceItem, import it here.
// Otherwise, define it locally (we'll repeat it for completeness).

class ServiceItem {
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;
  const ServiceItem({
    required this.label,
    required this.icon,
    required this.bg,
    required this.fg,
  });
}

class CategoryPopupWidget extends StatefulWidget {
  final List<ServiceItem> categories;
  final String title;

  // Default list = Instant Services
  const CategoryPopupWidget({
    Key? key,
    this.categories = const [
      ServiceItem(
          label: 'Electrician',
          icon: Icons.electric_bolt,
          bg: Color(0xFFFFF3E0),
          fg: Colors.orange),
      ServiceItem(
          label: 'Plumber',
          icon: Icons.plumbing,
          bg: Color(0xFFE3F2FD),
          fg: Colors.blue),
      ServiceItem(
          label: 'AC Repair',
          icon: Icons.ac_unit,
          bg: Color(0xFFE8F5E9),
          fg: Colors.green),
      ServiceItem(
          label: 'Carpenter',
          icon: Icons.carpenter,
          bg: Color(0xFFFBE9E7),
          fg: Colors.deepOrange),
      ServiceItem(
          label: 'RO Service',
          icon: Icons.water_drop,
          bg: Color(0xFFE0F7FA),
          fg: Colors.cyan),
      ServiceItem(
          label: 'Cleaning',
          icon: Icons.cleaning_services,
          bg: Color(0xFFF3E5F5),
          fg: Colors.purple),
      ServiceItem(
          label: 'Grocery',
          icon: Icons.shopping_basket,
          bg: Color(0xFFFFF8E1),
          fg: Colors.amber),
      ServiceItem(
          label: 'Medicine',
          icon: Icons.medical_services,
          bg: Color(0xFFE8EAF6),
          fg: Colors.indigo),
      ServiceItem(
          label: 'Pest Control',
          icon: Icons.pest_control,
          bg: Color(0xFFFCE4EC),
          fg: Colors.pink),
      ServiceItem(
          label: 'Auto / Cab',
          icon: Icons.directions_car,
          bg: Color(0xFFE0F2F1),
          fg: Colors.teal),
      ServiceItem(
          label: 'Courier',
          icon: Icons.local_shipping,
          bg: Color(0xFFEFEBE9),
          fg: Colors.brown),
    ],
    this.title = 'Select Category',
  }) : super(key: key);

  @override
  State<CategoryPopupWidget> createState() => _CategoryPopupWidgetState();
}

class _CategoryPopupWidgetState extends State<CategoryPopupWidget> {
  int selectedIndex = 0;
  String searchQuery = '';

  List<ServiceItem> get filteredCategories {
    if (searchQuery.isEmpty) return widget.categories;
    return widget.categories
        .where((cat) => cat.label.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
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
          // drag indicator
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

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF001A4E)),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001A4E),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[500]!.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey, size: 22),
                  hintText: 'Search categories...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final item = filteredCategories[index];
                  final originalIndex = widget.categories.indexOf(item);
                  final isSelected = originalIndex == selectedIndex;
                  return _buildTile(item, isSelected);
                },
              ),
            ),
          ),

          // Bottom Button
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
                  Navigator.pop(context, widget.categories[selectedIndex].label);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3DFA),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Select Category',
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

  Widget _buildTile(ServiceItem item, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = widget.categories.indexOf(item);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? const Color(0xFF3F3DFA) : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: item.bg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, color: item.fg, size: 18),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected ? const Color(0xFF001A4E) : Colors.grey.shade700,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}