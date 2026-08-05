import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truxperts/Model_n_svc/categories/categories_model.dart';
import 'package:truxperts/Model_n_svc/categories/subcategory/advance_subcategory_svc.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

// -------------------------------------------------
// ADVANCE SUBCATEGORY POPUP – API Integrated
// -------------------------------------------------
class AdvanceSubcategoryPopupWidget extends StatefulWidget {
  final int categoryId;
  const AdvanceSubcategoryPopupWidget({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<AdvanceSubcategoryPopupWidget> createState() =>
      _AdvanceSubcategoryPopupWidgetState();
}

class _AdvanceSubcategoryPopupWidgetState
    extends State<AdvanceSubcategoryPopupWidget> {
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

  // -----------------------------------------------------------------------
  // API CALL
  // -----------------------------------------------------------------------
  Future<void> _fetchSubcategories() async {
    try {
      final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
      final service = AdvanceSubcategoriesApiService(dio);
      final response =
          await service.getAdvanceSubcategories(widget.categoryId);

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

  // -----------------------------------------------------------------------
  // BUILD
  // -----------------------------------------------------------------------
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

          // Search Bar
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

          // List / Loading / Error / Empty
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _hasError || _subcategories.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              _hasError
                                  ? 'Failed to load subcategories'
                                  : 'No subcategories available',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = _filteredList[index];
                          final isSelected =
                              _subcategories.indexOf(item) == _selectedIndex;

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
                                  // Icon Container – static icon (or we could show dynamic icon if available)
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

                                  // Title & Description
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          item.description.isNotEmpty
                                              ? item.description
                                              : 'No description',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Selection circle
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
                  if (_subcategories.isNotEmpty) {
                    final selected = _subcategories[_selectedIndex];
                    // Return Map with id and name (like other popups)
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