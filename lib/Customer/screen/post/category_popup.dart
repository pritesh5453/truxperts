// Customer/screen/post/category_popup.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truxperts/Model_n_svc/categories/categories_model.dart';
import 'package:truxperts/Model_n_svc/categories/categories_svc.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class CategoryPopupWidget extends StatefulWidget {
  const CategoryPopupWidget({Key? key}) : super(key: key);

  @override
  State<CategoryPopupWidget> createState() => _CategoryPopupWidgetState();
}

class _CategoryPopupWidgetState extends State<CategoryPopupWidget> {
  List<Category> _categories = [];
  bool _isLoading = true;
  bool _hasError = false;
  int _selectedIndex = 0;
  String _searchQuery = '';

  List<Category> get _filteredList {
    if (_searchQuery.isEmpty) return _categories;
    return _categories
        .where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
      final service = CategoriesApiService(dio);
      final response = await service.getCategories();

      if (response.success && response.data.isNotEmpty) {
        setState(() {
          _categories = response.data;
          _isLoading = false;
          _hasError = false;
        });
      } else {
        setState(() {
          _categories = [];
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _categories = [];
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
                      'Select Category',
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
                  hintText: 'Search categories...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Grid or Loading/Error/Empty
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _hasError || _categories.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              _hasError ? 'Failed to load categories' : 'No categories available',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: _filteredList.length,
                        itemBuilder: (context, index) {
                          final item = _filteredList[index];
                          final isSelected = _categories.indexOf(item) == _selectedIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = _categories.indexOf(item);
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
                                      color: isSelected
                                          ? const Color(0xFF3F3DFA)
                                          : Colors.grey.shade200,
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
                                        color: _parseColor(item.bgColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.network(
                                        item.cleanIcon,
                                        width: 20,
                                        height: 20,
                                        color: _parseColor(item.iconColor),
                                        errorBuilder: (_, __, ___) =>
                                            Icon(Icons.category, color: _parseColor(item.iconColor), size: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.name,
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
                  if (_categories.isNotEmpty) {
                    final selected = _categories[_selectedIndex];
                    // 🔥 Return Map with id and name
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

  Color _parseColor(String hex) {
    String clean = hex.trim().replaceAll('\\', '');
    if (clean.startsWith('#')) clean = clean.substring(1);
    if (clean.length == 6) clean = 'ff$clean';
    return Color(int.parse('0x$clean'));
  }
}