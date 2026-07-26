import 'package:flutter/material.dart';
import 'package:truxperts/customs/customappbar.dart';
import 'package:truxperts/utils/navbar.dart';
import 'package:truxperts/screens/home/homescreen.dart';
import 'package:truxperts/screens/post/post_appbar.dart';
import 'package:truxperts/screens/post/select_subcategory.dart';

class PostRequestScreen extends StatefulWidget {
  const PostRequestScreen({Key? key}) : super(key: key);

  @override
  State<PostRequestScreen> createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  // UI state variables
  String selectedSubcategoryText = "Select a subcategory";
  String selectedCategory = "Electrician"; // Default selected category
  bool isInstantBooking = true; // Booking type: Instant (true) / Advance (false)

  // Static Category List
  final List<Map<String, String>> popularCategories = [
    {"name": "Electrician", "icon": "assets/icons/electrician.png"},
    {"name": "Plumber", "icon": "assets/icons/plumber.png"},
    {"name": "Carpenter", "icon": "assets/icons/carpenter.png"},
    {"name": "Painter", "icon": "assets/icons/painter.png"},
    {"name": "Cleaning", "icon": "assets/icons/cleaning.png"},
    {"name": "More", "icon": "assets/icons/more.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Post Request',
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const NavBarScreen()),
          );
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full-width Banner Image (Text & description removed)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/post_banner.png',
                    width: double.infinity,
                    height: 180, // adjust height as per your banner
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),

                // 1. Select Booking Type
                _sectionTitle("1. Select Booking Type"),
                Row(
                  children: [
                    Expanded(
                      child: _bookingTypeCard(
                        icon: Icons.bolt,
                        title: "Instant",
                        subtitle: "Get immediate service\nfrom available experts",
                        isInstantOption: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _bookingTypeCard(
                        icon: Icons.calendar_today,
                        title: "Advance Booking",
                        subtitle: "Book for a future date\nand time",
                        isInstantOption: false,
                      ),
                    ),
                  ],
                ),
                if (isInstantBooking)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, size: 16, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Instant Booking is available for selected services only.",
                            style: TextStyle(fontSize: 11, color: Colors.deepPurple.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),

                // 2. Select Service Category
                _sectionTitle("2. Select a Service Category"),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularCategories.length,
                    itemBuilder: (context, index) {
                      final item = popularCategories[index];
                      final isSelected = selectedCategory == item['name'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = item['name']!;
                          });
                        },
                        child: _categoryItem(
                          item['name']!,
                          item['icon']!,
                          isSelected,
                        ),
                      );
                    },
                  ),
                ),

                // 3. Select Subcategory
                _sectionTitle("3. Select a Subcategory"),
                GestureDetector(
                  onTap: () async {
                    final result =
                        await showModalBottomSheet<Map<String, dynamic>>(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const SubcategoryPopupWidget(),
                        );

                    if (result != null && mounted) {
                      setState(() {
                        selectedSubcategoryText = result['title'];
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedSubcategoryText,
                          style: TextStyle(
                            color:
                                selectedSubcategoryText ==
                                    "Select a subcategory"
                                ? Colors.grey
                                : Colors.black,
                            fontSize: 13,
                            fontWeight:
                                selectedSubcategoryText ==
                                    "Select a subcategory"
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),

                // 4. Describe Your Requirement
                _sectionTitle("4. Describe Your Requirement"),
                _customTextField(
                  "E.g. Need wiring repair in 2BHK flat. Switchboard issue and 3 tube lights not working.",
                  4,
                  "0/300",
                ),

                // Quick Add Chips
                const SizedBox(height: 10),
                const Text(
                  "Quick Add",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _quickChip("Wiring Repair"),
                    _quickChip("New Installation"),
                    _quickChip("Short Circuit"),
                    _quickChip("Other"),
                  ],
                ),

                // 5. Add Photos (Optional)
                _sectionTitle("5. Add Photos (Optional)"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _uploadBox(),
                      const SizedBox(width: 8),
                      _safeImagePlaceholder("Switchboard"),
                      const SizedBox(width: 8),
                      _safeImagePlaceholder("Tubelight"),
                    ],
                  ),
                ),

                // 6. Location
                _sectionTitle("6. Location"),
                _customDropdownWithIcon(
                  Icons.location_on,
                  "Pune, Maharashtra",
                  "Tap to change location",
                ),

                // 7 & 8 Row
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _infoBox(
                        "7. Preferred Time",
                        Icons.calendar_today,
                        "Select Date & Time",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _infoBox(
                        "8. Budget (Optional)",
                        Icons.currency_rupee,
                        "Select Budget Range",
                      ),
                    ),
                  ],
                ),

                // 9. Additional Notes
                _sectionTitle("9. Additional Notes (Optional)"),
                _customTextField("Any additional information...", 2, "0/200"),

                const SizedBox(height: 15),
                // Info Banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFF001A4E),
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Your request will be sent to nearby verified professionals. You'll receive offers and can choose the best one.",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF001A4E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Fixed Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001A4E),
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send, size: 16, color: Colors.orange),
                        SizedBox(width: 8),
                        Text(
                          "Post Request",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Send to Nearby Professionals",
                      style: TextStyle(fontSize: 9, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Components ---

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF001A4E),
        ),
      ),
    );
  }

  // Instant / Advance Booking selectable card
  Widget _bookingTypeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isInstantOption,
  }) {
    final bool selected = isInstantBooking == isInstantOption;
    return GestureDetector(
      onTap: () {
        setState(() {
          isInstantBooking = isInstantOption;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.deepPurple : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selected
              ? Colors.deepPurple.withOpacity(0.05)
              : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  selected ? Icons.radio_button_checked : Icons.radio_button_off,
                  size: 18,
                  color: selected ? Colors.deepPurple : Colors.grey,
                ),
                const SizedBox(width: 6),
                Icon(
                  icon,
                  size: 15,
                  color: selected ? Colors.deepPurple : Colors.black54,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.deepPurple : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10.5,
                color: Colors.grey,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(String name, String icon, bool isSelected) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isSelected
            ? Colors.deepPurple.withOpacity(0.05)
            : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 26, height: 26, fit: BoxFit.contain),
          const SizedBox(height: 5),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.deepPurple : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customTextField(String hint, int lines, String count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          maxLines: lines,
          enabled: false, // Abhi ke liye purely static representation
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(count, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _quickChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 11, color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      side: BorderSide(color: Colors.grey.shade300),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _uploadBox() {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepPurple.withOpacity(0.02),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_photo_alternate_outlined, color: Colors.grey),
          Text(
            "Upload Photos",
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
          ),
          Text(
            "(Max 5 photos)",
            style: TextStyle(fontSize: 7, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Safe internal UI representation instead of broken HTTP URLs
  Widget _safeImagePlaceholder(String label) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.image, color: Colors.grey, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 9, color: Colors.grey),
              ),
            ],
          ),
        ),
        const Positioned(
          right: 2,
          top: 2,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Color(0xFF001A4E),
            child: Icon(Icons.close, size: 10, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _customDropdownWithIcon(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF001A4E)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  sub,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _infoBox(String title, IconData icon, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}