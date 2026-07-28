import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Internal ServiceItem model (duplicate to avoid imports)
// ---------------------------------------------------------------------
class _ServiceItem {
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;

  const _ServiceItem({
    required this.label,
    required this.icon,
    required this.bg,
    required this.fg,
  });
}

// ---------------------------------------------------------------------
// Advance Category Popup Widget (fully self-contained)
// ---------------------------------------------------------------------
class AdvanceCategoryPopupWidget extends StatefulWidget {
  const AdvanceCategoryPopupWidget({Key? key}) : super(key: key);

  @override
  State<AdvanceCategoryPopupWidget> createState() =>
      _AdvanceCategoryPopupWidgetState();
}

class _AdvanceCategoryPopupWidgetState
    extends State<AdvanceCategoryPopupWidget> {
  // Advance services list – colors hardcoded
  static const List<_ServiceItem> _advanceServices = [
    _ServiceItem(
      label: 'Photographer',
      icon: Icons.camera_alt,
      bg: Color(0xFFE3F2FD), // light blue
      fg: Colors.blue,
    ),
    _ServiceItem(
      label: 'Wedding Planner',
      icon: Icons.favorite,
      bg: Color(0xFFFFF3E0), // light orange
      fg: Colors.deepOrange,
    ),
    _ServiceItem(
      label: 'Decorator',
      icon: Icons.celebration,
      bg: Color(0xFFF3E5F5), // light purple
      fg: Colors.purple,
    ),
    _ServiceItem(
      label: 'Catering',
      icon: Icons.restaurant,
      bg: Color(0xFFE8F5E9), // light green
      fg: Colors.green,
    ),
    _ServiceItem(
      label: 'Makeup Artist',
      icon: Icons.brush,
      bg: Color(0xFFFFF8E1), // light amber
      fg: Colors.amber,
    ),
    _ServiceItem(
      label: 'DJ',
      icon: Icons.music_note,
      bg: Color(0xFFFCE4EC), // light pink
      fg: Colors.pink,
    ),
    _ServiceItem(
      label: 'Mehendi Artist',
      icon: Icons.back_hand,
      bg: Color(0xFFE0F7FA), // light cyan
      fg: Colors.cyan,
    ),
    _ServiceItem(
      label: 'Event Planner',
      icon: Icons.mic,
      bg: Color(0xFFEFEBE9), // light brown
      fg: Colors.brown,
    ),
    _ServiceItem(
      label: 'Tutor',
      icon: Icons.menu_book,
      bg: Color(0xFFE8EAF6), // light indigo
      fg: Colors.indigo,
    ),
    _ServiceItem(
      label: 'Pandit',
      icon: Icons.star,
      bg: Color(0xFFFFF8E1), // light amber
      fg: Colors.amber,
    ),
    _ServiceItem(
      label: 'Interior Designer',
      icon: Icons.chair_alt,
      bg: Color(0xFFFBE9E7), // light deep orange
      fg: Colors.deepOrange,
    ),
  ];

  int _selectedIndex = 0;
  String _searchQuery = '';

  List<_ServiceItem> get _filteredServices {
    if (_searchQuery.isEmpty) return _advanceServices;
    return _advanceServices
        .where((item) =>
            item.label.toLowerCase().contains(_searchQuery.toLowerCase()))
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
          // Drag indicator
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
                const Expanded(
                  child: Center(
                    child: Text(
                      'Select Advance Service',
                      style: TextStyle(
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

          // Search bar
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
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey, size: 22),
                  hintText: 'Search services...',
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
                itemCount: _filteredServices.length,
                itemBuilder: (context, index) {
                  final item = _filteredServices[index];
                  final originalIndex = _advanceServices.indexOf(item);
                  final isSelected = originalIndex == _selectedIndex;
                  return _buildTile(item, isSelected);
                },
              ),
            ),
          ),

          // Bottom button
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
                  Navigator.pop(context, _advanceServices[_selectedIndex].label);
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
                  'Select Service',
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

  Widget _buildTile(_ServiceItem item, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = _advanceServices.indexOf(item);
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