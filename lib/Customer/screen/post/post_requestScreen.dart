import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truxperts/API/Model_n_svc/categories/categories_model.dart';
import 'package:truxperts/API/Model_n_svc/categories/subcategory/subcategory_svc.dart';
import 'package:truxperts/API/Model_n_svc/post_screen/post_model.dart';
import 'package:truxperts/API/Model_n_svc/post_screen/post_svc.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/Customer/customs/customappbar.dart';
import 'package:truxperts/Customer/screen/home/address_location.dart';
import 'package:truxperts/Customer/screen/post/AdvanceCategoryPopupWidget.dart';
import 'package:truxperts/Customer/screen/post/category_popup.dart';
import 'package:truxperts/Customer/screen/post/select_advance_subcategory.dart';
import 'package:truxperts/utils/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostRequestScreen extends StatefulWidget {
  const PostRequestScreen({Key? key}) : super(key: key);

  @override
  State<PostRequestScreen> createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  // ---------- State Variables ----------
  String? selectedCategoryName;
  int? selectedCategoryId;

  String selectedSubcategoryText = "Select a subcategory";
  int? selectedSubcategoryId;

  bool isInstantBooking = true;

  String selectedLocation = "Pune, Maharashtra";

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String budget = '';

  // ---------- PHOTOS ----------
  List<XFile> selectedImages = [];
  static const int maxPhotos = 5;

  // ---------- Text Controllers ----------
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _additionalNotesController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  // ---------- Helpers ----------
  void _pickImages() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      if (selectedImages.length + images.length > maxPhotos) {
        final int available = maxPhotos - selectedImages.length;
        if (available > 0) {
          setState(() {
            selectedImages.addAll(images.take(available));
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You can only select up to $maxPhotos photos. Added $available more.'),
              backgroundColor: Colors.orange,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You already have 5 photos. Remove some to add more.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        setState(() {
          selectedImages.addAll(images);
        });
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  // ---------- SUBMIT REQUEST ----------
  Future<void> _submitRequest() async {
    // ✅ Validation
    if (selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
      );
      return;
    }
    if (selectedSubcategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a subcategory")),
      );
      return;
    }
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date & time")),
      );
      return;
    }
    if (_descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please describe your requirement")),
      );
      return;
    }

    // Format date and time
    final String formattedDate =
        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
    final String formattedTime =
        "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}:00";

    // Static location values (for now)
    const String locationAddress = "123 Main Street, Pune, Maharashtra 411001";
    const String latitude = "18.5204";
    const String longitude = "73.8567";

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

      if (isInstantBooking) {
        // ✅ INSTANT BOOKING
        final request = InstantBookingRequest(
        bookingType: 'instant',
        categoryId: selectedCategoryId!,
        categoryName: selectedCategoryName ?? '',
        subcategoryId: selectedSubcategoryId!,
        subcategoryName: selectedSubcategoryText,
        description: _descriptionController.text.trim(),
        budget: budget.isEmpty ? '0' : budget,
        locationAddress: locationAddress,
        latitude: latitude,
        longitude: longitude,
        preferredDate: formattedDate,
        preferredTime: formattedTime,
        additionalNotes: _additionalNotesController.text.trim(),
        paymentAmount: budget.isEmpty ? '0' : budget,
        advanceAmount: '0',
        advancePaid: false,
        userId: 1,
      );

         final service = InstantBookingApiService(dio);
      // ✅ Pass images
      final response = await service.createInstantBooking(request, selectedImages);

        // Close loading
        if (mounted) Navigator.pop(context);

        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: Colors.green,
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) Navigator.pop(context);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // 🔜 ADVANCE BOOKING (will be updated later)
        // For now, show a placeholder message
        if (mounted) Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Advance booking feature coming soon!'),
            backgroundColor: Colors.orange,
          ),
        );
        // Uncomment when advance API is ready:
        /*
        final request = ServiceRequestRequest(
          bookingType: 'advance',
          categoryId: selectedCategoryId!,
          categoryName: selectedCategoryName ?? '',
          subcategoryId: selectedSubcategoryId!,
          subcategoryName: selectedSubcategoryText,
          description: _descriptionController.text.trim(),
          locationAddress: locationAddress,
          latitude: latitude,
          longitude: longitude,
          preferredDate: formattedDate,
          preferredTime: formattedTime,
          additionalNotes: _additionalNotesController.text.trim(),
          paymentAmount: budget.isEmpty ? '0' : budget,
          user: 'Sumit pathak',
          userId: 1,
        );
        final service = ServiceRequestApiService(dio);
        final response = await service.createServiceRequest(request);
        // handle response...
        */
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ---------- Build ----------
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
                // Banner
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/post_banner.png',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),

                // ---------- 1. Booking Type ----------
                _sectionTitle("1. Select Booking Type"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: Row(
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
                ),

                // ---------- 2. Select Service Category ----------
                _sectionTitle("2. Select a Service Category"),
                GestureDetector(
                  onTap: () async {
                    final result = await showModalBottomSheet<Map<String, dynamic>>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        if (isInstantBooking) {
                          return const CategoryPopupWidget();
                        } else {
                          return const AdvanceCategoryPopupWidget();
                        }
                      },
                    );
                    if (result != null && mounted) {
                      setState(() {
                        selectedCategoryName = result['name'];
                        selectedCategoryId = result['id'];
                        selectedSubcategoryText = "Select a subcategory";
                        selectedSubcategoryId = null;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCategoryName ?? "Select a category",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: selectedCategoryName == null ? Colors.grey : const Color(0xFF001A4E),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // ---------- 3. Select Subcategory ----------
                _sectionTitle("3. Select a Subcategory"),
                GestureDetector(
                  onTap: () async {
                    if (selectedCategoryId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a category first")),
                      );
                      return;
                    }
                    final result = await showModalBottomSheet<Map<String, dynamic>>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        if (isInstantBooking) {
                          return SubcategoryPopupWidget(
                            categoryId: selectedCategoryId!,
                          );
                        } else {
                          return AdvanceSubcategoryPopupWidget(
                            categoryId: selectedCategoryId!,
                          );
                        }
                      },
                    );
                    if (result != null && mounted) {
                      setState(() {
                        selectedSubcategoryText = result['name'] ?? "Select a subcategory";
                        selectedSubcategoryId = result['id'];
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                            color: selectedSubcategoryText == "Select a subcategory"
                                ? Colors.grey
                                : Colors.black,
                            fontSize: 13,
                            fontWeight: selectedSubcategoryText == "Select a subcategory"
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),

                // ---------- 4. Describe Your Requirement ----------
                _sectionTitle("4. Describe Your Requirement"),
                _customTextField(
                  "E.g. Need wiring repair in 2BHK flat. Switchboard issue and 3 tube lights not working.",
                  4,
                  "0/300",
                  enabled: true,
                  controller: _descriptionController,
                ),

                // ---------- 5. Add Photos ----------
                _sectionTitle("5. Add Photos (Optional)"),
                Row(
                  children: [
                    _uploadBox(onTap: _pickImages),
                    const SizedBox(width: 8),
                    ...List.generate(selectedImages.length, (index) {
                      return Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                              image: DecorationImage(
                                image: FileImage(File(selectedImages[index].path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Color(0xFF001A4E),
                                child: Icon(Icons.close, size: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 8),

                // ---------- 6. Location ----------
                _sectionTitle("6. Location"),
                GestureDetector(
                  onTap: () {
                    LocationSelectorSheet.show(context);
                  },
                  child: _customDropdownWithIcon(
                    Icons.location_on,
                    selectedLocation,
                    "Tap to change location",
                  ),
                ),

                // ---------- 7. Preferred Time ----------
                const SizedBox(height: 15),
                _sectionTitle("7. Preferred Time"),
                GestureDetector(
                  onTap: () async {
                    final result = await showModalBottomSheet<Map<String, dynamic>>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const DateTimePickerWidget(),
                    );
                    if (result != null && mounted) {
                      setState(() {
                        selectedDate = result['date'];
                        selectedTime = result['time'];
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Color(0xFF001A4E)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            selectedDate != null && selectedTime != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}  ${selectedTime!.format(context)}"
                                : "Select Date & Time",
                            style: TextStyle(
                              fontSize: 13,
                              color: (selectedDate != null && selectedTime != null)
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: (selectedDate != null && selectedTime != null)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),

                // ---------- 8. Budget (only for Advance Booking) ----------
                if (!isInstantBooking) ...[
                  const SizedBox(height: 12),
                  _sectionTitle("8. Budget (₹)"),
                  _customTextField(
                    "Enter your estimated budget",
                    1,
                    "",
                    enabled: true,
                    controller: _budgetController,
                    onChanged: (value) => setState(() => budget = value),
                  ),
                ],

                // ---------- 9. Additional Notes ----------
                _sectionTitle(
                  isInstantBooking ? "8. Additional Notes (Optional)" : "9. Additional Notes (Optional)"
                ),
                _customTextField(
                  "Any additional information...",
                  2,
                  "0/200",
                  enabled: true,
                  controller: _additionalNotesController,
                ),

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
                      Icon(Icons.verified_user_outlined, color: Color(0xFF001A4E), size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Your request will be sent to nearby verified professionals. You'll receive offers and can choose the best one.",
                          style: TextStyle(fontSize: 11, color: Color(0xFF001A4E)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---------- Bottom Fixed Button ----------
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: _submitRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001A4E),
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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

  // ---------- Helper Widgets ----------
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
          selectedCategoryName = null;
          selectedCategoryId = null;
          selectedSubcategoryText = "Select a subcategory";
          selectedSubcategoryId = null;
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
          color: selected ? Colors.deepPurple.withOpacity(0.05) : Colors.white,
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
                Icon(icon, size: 15, color: selected ? Colors.deepPurple : Colors.black54),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
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
              style: const TextStyle(fontSize: 10.5, color: Colors.grey, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customTextField(
    String hint,
    int lines,
    String count, {
    bool enabled = true,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          maxLines: lines,
          enabled: enabled,
          controller: controller,
          onChanged: onChanged,
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
        if (count.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(count, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ],
    );
  }

  Widget _uploadBox({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
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
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
}

// -------------------------------------------------
// SUB-CATEGORY POPUP (unchanged - included for completeness)
// -------------------------------------------------
class SubcategoryPopupWidget extends StatefulWidget {
  final int categoryId;
  const SubcategoryPopupWidget({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<SubcategoryPopupWidget> createState() => _SubcategoryPopupWidgetState();
}

class _SubcategoryPopupWidgetState extends State<SubcategoryPopupWidget> {
  List<Subcategory> _subcategories = [];
  bool _isLoading = true;
  bool _hasError = false;
  int _selectedIndex = 0;
  String _searchQuery = '';

  List<Subcategory> get _filteredList {
    if (_searchQuery.isEmpty) return _subcategories;
    return _subcategories
        .where((s) => s.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchSubcategories();
  }

  Future<void> _fetchSubcategories() async {
    try {
      final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
      final service = SubcategoriesApiService(dio);
      final response = await service.getSubcategories(widget.categoryId);

      if (response.success && response.data.isNotEmpty) {
        setState(() {
          _subcategories = response.data;
          _isLoading = false;
          _hasError = false;
        });
      } else {
        setState(() {
          _subcategories = [];
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _subcategories = [];
        _isLoading = false;
        _hasError = true;
      });
    }
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
                const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(height: 12),
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
                  hintText: 'Search subcategories...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _hasError || _subcategories.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              _hasError ? 'Failed to load subcategories' : 'No subcategories available',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredList.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = _filteredList[index];
                          final isSelected = _subcategories.indexOf(item) == _selectedIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = _subcategories.indexOf(item);
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.category,
                                      color: Colors.deepPurple,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF001A4E),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.description.isNotEmpty ? item.description : 'No description',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                  if (_subcategories.isNotEmpty) {
                    final selected = _subcategories[_selectedIndex];
                    Navigator.pop(context, {
                      'id': selected.id,
                      'name': selected.name,
                    });
                  }
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

// -------------------------------------------------
// LOCATION POPUP (unchanged)
// -------------------------------------------------
class LocationPopupWidget extends StatefulWidget {
  const LocationPopupWidget({Key? key}) : super(key: key);

  @override
  State<LocationPopupWidget> createState() => _LocationPopupWidgetState();
}

class _LocationPopupWidgetState extends State<LocationPopupWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<String> allLocations = [
    'Pune, Maharashtra',
    'Mumbai, Maharashtra',
    'Delhi, NCR',
    'Bangalore, Karnataka',
    'Chennai, Tamil Nadu',
    'Hyderabad, Telangana',
    'Kolkata, West Bengal',
    'Ahmedabad, Gujarat',
    'Surat, Gujarat',
    'Jaipur, Rajasthan',
  ];

  List<String> get filteredLocations {
    if (_query.isEmpty) return allLocations;
    return allLocations.where((loc) => loc.toLowerCase().contains(_query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
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
                      'Select Location',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001A4E)),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _query = val),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search location...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                filled: true,
                fillColor: Colors.grey[500]!.withOpacity(0.05),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredLocations.length,
              separatorBuilder: (_, __) => const Divider(height: 1, thickness: 1),
              itemBuilder: (context, index) {
                final location = filteredLocations[index];
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Color(0xFF001A4E)),
                  title: Text(location, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  onTap: () => Navigator.pop(context, location),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------
// DATE & TIME PICKER (unchanged)
// -------------------------------------------------
class DateTimePickerWidget extends StatefulWidget {
  const DateTimePickerWidget({Key? key}) : super(key: key);

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
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
                      'Select Date & Time',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001A4E)),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateChanged: (date) => setState(() => _selectedDate = date),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Time',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF001A4E)),
                ),
                Row(
                  children: [
                    Text(
                      _selectedTime.format(context),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );
                        if (picked != null) setState(() => _selectedTime = picked);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F3DFA),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Change', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), offset: const Offset(0, -4), blurRadius: 10)],
            ),
            child: SafeArea(
              top: false,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, {'date': _selectedDate, 'time': _selectedTime}),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3DFA),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: const Text(
                  'Confirm Date & Time',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}