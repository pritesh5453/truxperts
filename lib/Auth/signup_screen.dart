import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:truxperts/API/Model_n_svc/signup/Signup_individual/signup_ind_svc.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/customtextfield.dart';
import 'package:truxperts/utils/navbar.dart';

enum _ServiceType { instant, advance, both }

class _ServiceCategory {
  final String name;
  final IconData icon;
  final Color color;
  final List<String> subcategories;

  const _ServiceCategory({
    required this.name,
    required this.icon,
    required this.color,
    this.subcategories = const [],
  });
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isIndividual = true;

  // ---------------- Individual form state ----------------
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;
  bool _isLoadingInd = false; // NEW

  // Individual controllers
  final TextEditingController _indNameController = TextEditingController();
  final TextEditingController _indMobileController = TextEditingController();
  final TextEditingController _indEmailController = TextEditingController();
  final TextEditingController _indPasswordController = TextEditingController();
  final TextEditingController _indConfirmController = TextEditingController();

  // ---------------- Business form state (completely unchanged) ----------------
  bool _obscureBizPassword = true;
  bool _obscureBizConfirm = true;
  _ServiceType _serviceType = _ServiceType.both;

  final List<_ServiceCategory> _instantCategories = const [
    _ServiceCategory(
      name: 'Electrician',
      icon: Icons.bolt,
      color: Color(0xFFF5A623),
      subcategories: [
        'Wiring Repair',
        'Fan Installation',
        'Switch Repair',
        'MCB Repair',
        'Light Installation',
        'Socket Repair',
        'Inverter Installation',
      ],
    ),
    _ServiceCategory(
      name: 'Plumber',
      icon: Icons.plumbing,
      color: Color(0xFF2F80ED),
      subcategories: [
        'Tap Repair',
        'Leakage Repair',
        'Pipe Installation',
        'Bathroom Fitting',
        'Drain Cleaning',
        'Water Tank Cleaning',
      ],
    ),
    _ServiceCategory(
        name: 'AC Repair', icon: Icons.ac_unit, color: Color(0xFF56CCF2)),
    _ServiceCategory(
        name: 'Cleaning',
        icon: Icons.cleaning_services,
        color: Color(0xFF27AE60)),
    _ServiceCategory(
        name: 'Pest Control',
        icon: Icons.pest_control,
        color: Color(0xFFEB5757)),
    _ServiceCategory(
        name: 'More', icon: Icons.more_horiz, color: Color(0xFF9B9B9B)),
  ];

  final List<_ServiceCategory> _advanceCategories = const [
    _ServiceCategory(
      name: 'Catering',
      icon: Icons.restaurant,
      color: Color(0xFFF5A623),
      subcategories: [
        'Wedding Catering',
        'Birthday Catering',
        'Corporate Catering',
        'Kitty Party Catering',
      ],
    ),
    _ServiceCategory(
      name: 'Photography',
      icon: Icons.camera_alt,
      color: Color(0xFF9B51E0),
      subcategories: [
        'Wedding Photography',
        'Pre-Wedding',
        'Product Photography',
        'Birthday Photography',
      ],
    ),
    _ServiceCategory(
        name: 'Event Decoration',
        icon: Icons.celebration,
        color: Color(0xFFEB5757)),
    _ServiceCategory(
        name: 'DJ & Music', icon: Icons.music_note, color: Color(0xFF2F80ED)),
    _ServiceCategory(
        name: 'Makeup Artists', icon: Icons.brush, color: Color(0xFF27AE60)),
    _ServiceCategory(
        name: 'More', icon: Icons.more_horiz, color: Color(0xFF9B9B9B)),
  ];

  final Set<String> _selectedInstant = {'Electrician', 'Plumber'};
  final Set<String> _selectedAdvance = {'Catering', 'Photography'};

  final Map<String, Set<String>> _selectedSubcategories = {
    'Electrician': {
      'Wiring Repair',
      'Fan Installation',
      'Switch Repair',
      'MCB Repair',
    },
    'Plumber': {'Tap Repair', 'Leakage Repair', 'Bathroom Fitting'},
    'Catering': {
      'Wedding Catering',
      'Birthday Catering',
      'Corporate Catering',
    },
    'Photography': {
      'Wedding Photography',
      'Pre-Wedding',
      'Product Photography',
    },
  };

  static const Color _purpleBg = Color(0xFFF1ECFB);
  static const Color _purple = Color(0xFF7C5CE0);
  static const Color _bizBannerBg = Color(0xFFFFF1E8);

  // Dio and SignupService
  late final Dio _dio;
  late final SignupService _signupService;

  @override
  void initState() {
    super.initState();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _signupService = SignupService(_dio);
  }

  @override
  void dispose() {
    _indNameController.dispose();
    _indMobileController.dispose();
    _indEmailController.dispose();
    _indPasswordController.dispose();
    _indConfirmController.dispose();
    super.dispose();
  }

  // Individual signup method
  Future<void> _registerIndividual() async {
    final name = _indNameController.text.trim();
    final mobile = _indMobileController.text.trim();
    final email = _indEmailController.text.trim();
    final password = _indPasswordController.text.trim();
    final confirm = _indConfirmController.text.trim();

    // Validations
    if (name.isEmpty || mobile.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showSnackBar('Please fill all fields');
      return;
    }
    if (mobile.length < 10) {
      _showSnackBar('Enter a valid mobile number (10 digits)');
      return;
    }
    if (password != confirm) {
      _showSnackBar('Passwords do not match');
      return;
    }
    if (!_agreeTerms) {
      _showSnackBar('Please agree to Terms & Conditions');
      return;
    }

    setState(() => _isLoadingInd = true);

    try {
      final response = await _signupService.signup(
        accountType: 'individual',
        fullName: name,
        mobileNumber: mobile,
        email: email,
        password: password,
        confirmPassword: confirm,
      );

      // Success
      if (mounted) {
        setState(() => _isLoadingInd = false);
        // Optionally save token using shared_preferences
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('token', response.token);
        // await prefs.setString('user', jsonEncode(response.user.toJson()));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NavBarScreen()),
        );
      }
    } on DioException catch (e) {
      setState(() => _isLoadingInd = false);
      String errorMsg = 'Signup failed';
      if (e.response?.data != null) {
        try {
          final data = e.response?.data as Map<String, dynamic>;
          errorMsg = data['message'] ?? data['error'] ?? 'Signup failed';
        } catch (_) {}
      } else {
        errorMsg = e.message ?? 'Network error';
      }
      _showSnackBar(errorMsg);
    } catch (e) {
      setState(() => _isLoadingInd = false);
      _showSnackBar('Unexpected error occurred');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleInstant(String name) {
    setState(() {
      if (_selectedInstant.contains(name)) {
        _selectedInstant.remove(name);
        _selectedSubcategories.remove(name);
      } else {
        _selectedInstant.add(name);
      }
    });
  }

  void _toggleAdvance(String name) {
    setState(() {
      if (_selectedAdvance.contains(name)) {
        _selectedAdvance.remove(name);
        _selectedSubcategories.remove(name);
      } else {
        _selectedAdvance.add(name);
      }
    });
  }

  void _toggleSubcategory(String category, String sub) {
    setState(() {
      final set = _selectedSubcategories.putIfAbsent(category, () => {});
      if (set.contains(sub)) {
        set.remove(sub);
      } else {
        set.add(sub);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon:
                    const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 6),
              const Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Fill in the details to get started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 22),

              // Individual / Business toggle
              Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _ToggleTab(
                        label: 'Individual',
                        icon: Icons.person_outline,
                        selected: _isIndividual,
                        onTap: () => setState(() => _isIndividual = true),
                      ),
                    ),
                    Expanded(
                      child: _ToggleTab(
                        label: 'Business',
                        icon: Icons.apartment_outlined,
                        selected: !_isIndividual,
                        onTap: () => setState(() => _isIndividual = false),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              if (_isIndividual) ..._buildIndividualForm() else ..._buildBusinessForm(),

              const SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13.5,
                    ),
                    children: [
                      const TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).maybePop(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INDIVIDUAL FORM (UPDATED) =================
  List<Widget> _buildIndividualForm() {
    return [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _purpleBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.person, color: _purple, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Join as an Individual',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Post your requirements and connect with trusted professionals near you.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.location_on, color: _purple, size: 30),
          ],
        ),
      ),
      const SizedBox(height: 18),
      CustomTextField(
        hint: 'Full Name',
        icon: Icons.person_outline,
        controller: _indNameController,
      ),
      const SizedBox(height: 14),
      CustomTextField(
        hint: 'Mobile Number',
        icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
        controller: _indMobileController,
        suffixIcon: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Verify',
            style: TextStyle(
              color: AppColors.orange,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      const SizedBox(height: 14),
      CustomTextField(
        hint: 'Email (Optional)',
        icon: Icons.mail_outline,
        keyboardType: TextInputType.emailAddress,
        controller: _indEmailController,
      ),
      const SizedBox(height: 14),
      CustomTextField(
        hint: 'Password',
        icon: Icons.lock_outline,
        obscureText: _obscurePassword,
        controller: _indPasswordController,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 20,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        ),
      ),
      const SizedBox(height: 14),
      CustomTextField(
        hint: 'Confirm Password',
        icon: Icons.lock_outline,
        obscureText: _obscureConfirm,
        controller: _indConfirmController,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirm
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            setState(() => _obscureConfirm = !_obscureConfirm);
          },
        ),
      ),
      
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _WhySignUpCard(
              icon: Icons.send_outlined,
              iconColor: _purple,
              iconBg: _purpleBg,
              title: 'Post Requests',
              subtitle: 'Post what you need in seconds',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _WhySignUpCard(
              icon: Icons.groups_outlined,
              iconColor: AppColors.orange,
              iconBg: const Color(0xFFFFF1E8),
              title: 'Get Best Offers',
              subtitle: 'Receive offers from verified experts',
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: _WhySignUpCard(
              icon: Icons.shield_outlined,
              iconColor: const Color(0xFF2F80ED),
              iconBg: const Color(0xFFE8F1FD),
              title: 'Safe & Secure',
              subtitle: 'Your information is always protected',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _WhySignUpCard(
              icon: Icons.headset_mic_outlined,
              iconColor: const Color(0xFF27AE60),
              iconBg: const Color(0xFFE8F8EE),
              title: '24/7 Support',
              subtitle: "We're here to help you anytime",
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Checkbox(
              value: _agreeTerms,
              activeColor: AppColors.orange,
              onChanged: (v) => setState(() => _agreeTerms = v ?? false),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                ),
                children: const [
                  TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: _isLoadingInd ? null : _registerIndividual,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isLoadingInd
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  'Register',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
        ),
      ),
    ];
  }

  // ================= BUSINESS FORM (COMPLETELY UNCHANGED) =================
  List<Widget> _buildBusinessForm() {
    return [
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _bizBannerBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.storefront, color: AppColors.orange, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Register your business',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add your business details and the services you provide to get discovered.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const CustomTextField(
        hint: 'Business / Professional Name',
        icon: Icons.storefront_outlined,
      ),
      const SizedBox(height: 14),
      const CustomTextField(
        hint: 'Owner / Contact Person Name',
        icon: Icons.badge_outlined,
      ),
      const SizedBox(height: 14),
      CustomTextField(
        hint: 'Mobile Number',
        icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
        suffixIcon: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Verify',
            style: TextStyle(
              color: AppColors.orange,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      const SizedBox(height: 14),
      const CustomTextField(
        hint: 'Email (Optional)',
        icon: Icons.mail_outline,
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 20),

      const Text(
        'Select Service Type *',
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: _ServiceTypeCard(
              icon: Icons.bolt,
              label: 'Instant Services',
              subtitle: 'On-demand services available now',
              selected: _serviceType == _ServiceType.instant,
              onTap: () =>
                  setState(() => _serviceType = _ServiceType.instant),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ServiceTypeCard(
              icon: Icons.calendar_today_outlined,
              label: 'Advance Booking',
              subtitle: 'Book for a future date & time',
              selected: _serviceType == _ServiceType.advance,
              onTap: () =>
                  setState(() => _serviceType = _ServiceType.advance),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ServiceTypeCard(
              icon: Icons.bolt,
              icon2: Icons.calendar_today_outlined,
              label: 'Both',
              subtitle: 'Provide both instant & advance services',
              selected: _serviceType == _ServiceType.both,
              onTap: () => setState(() => _serviceType = _ServiceType.both),
            ),
          ),
        ],
      ),

      if (_serviceType == _ServiceType.instant ||
          _serviceType == _ServiceType.both) ...[
        const SizedBox(height: 22),
        _buildSectionHeader(
          icon: Icons.bolt,
          iconColor: AppColors.orange,
          title: '1. Select Instant Service Categories',
          subtitle: '(You can choose multiple)',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: _instantCategories
              .map((c) => _CategoryChip(
                    category: c,
                    selected: _selectedInstant.contains(c.name),
                    onTap: () => _toggleInstant(c.name),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        for (final c in _instantCategories)
          if (_selectedInstant.contains(c.name) && c.subcategories.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _SubcategoryPanel(
                category: c,
                indexLabel: c.name == 'Electrician' ? '2' : null,
                title: c.name == 'Electrician'
                    ? 'Select Subcategories for Instant Services'
                    : null,
                selected: _selectedSubcategories[c.name] ?? {},
                onToggle: (sub) => _toggleSubcategory(c.name, sub),
                onRemove: () => _toggleInstant(c.name),
              ),
            ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16, color: AppColors.orange),
            label: const Text(
              'Add More Instant Category',
              style: TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],

      if (_serviceType == _ServiceType.advance ||
          _serviceType == _ServiceType.both) ...[
        const SizedBox(height: 20),
        _buildSectionHeader(
          icon: Icons.calendar_today_outlined,
          iconColor: const Color(0xFF9B51E0),
          title: 'Advance Booking',
          subtitle: null,
        ),
        const SizedBox(height: 4),
        const Text(
          '1. Select Advance Booking Categories (You can choose multiple)',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: _advanceCategories
              .map((c) => _CategoryChip(
                    category: c,
                    selected: _selectedAdvance.contains(c.name),
                    onTap: () => _toggleAdvance(c.name),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        for (final c in _advanceCategories)
          if (_selectedAdvance.contains(c.name) && c.subcategories.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _SubcategoryPanel(
                category: c,
                indexLabel: c.name == 'Catering' ? '2' : null,
                title: c.name == 'Catering'
                    ? 'Select Subcategories for Advance Booking'
                    : null,
                selected: _selectedSubcategories[c.name] ?? {},
                onToggle: (sub) => _toggleSubcategory(c.name, sub),
                onRemove: () => _toggleAdvance(c.name),
              ),
            ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16, color: AppColors.orange),
            label: const Text(
              'Add More Advance Category',
              style: TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],

      const SizedBox(height: 20),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextField(
              hint: 'Password',
              icon: Icons.lock_outline,
              obscureText: _obscureBizPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureBizPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() => _obscureBizPassword = !_obscureBizPassword);
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomTextField(
              hint: 'Confirm Password',
              icon: Icons.lock_outline,
              obscureText: _obscureBizConfirm,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureBizConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() => _obscureBizConfirm = !_obscureBizConfirm);
                },
              ),
            ),
          ),
        ],
      ),
      
      const SizedBox(height: 20),
      SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Register Business',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ];
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 6),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(width: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'View All',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }
}

// ---------- Helper Widgets (unchanged) ----------
class _ToggleTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.navy : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhySignUpCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  const _WhySignUpCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              color: AppColors.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceTypeCard extends StatelessWidget {
  final IconData icon;
  final IconData? icon2;
  final String label;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _ServiceTypeCard({
    required this.icon,
    this.icon2,
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFF1E8) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.orange : const Color(0xFFEDEDED),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Stack(
          children: [
            if (selected)
              const Positioned(
                top: -2,
                right: -2,
                child: Icon(Icons.check_circle, color: AppColors.orange, size: 18),
              ),
            Column(
              children: [
                icon2 == null
                    ? Icon(icon, color: AppColors.orange, size: 20)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, color: AppColors.orange, size: 18),
                          const SizedBox(width: 2),
                          Icon(icon2, color: AppColors.orange, size: 18),
                        ],
                      ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 9.5,
                    color: AppColors.textSecondary,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final _ServiceCategory category;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 68,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selected
                        ? category.color.withOpacity(0.15)
                        : const Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                    border: selected
                        ? Border.all(color: category.color, width: 1.5)
                        : null,
                  ),
                  child: Icon(category.icon, color: category.color, size: 22),
                ),
                if (selected)
                  const Positioned(
                    top: -2,
                    right: -2,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: AppColors.orange,
                      child: Icon(Icons.check, color: Colors.white, size: 11),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubcategoryPanel extends StatelessWidget {
  final _ServiceCategory category;
  final String? indexLabel;
  final String? title;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final VoidCallback onRemove;

  const _SubcategoryPanel({
    required this.category,
    required this.selected,
    required this.onToggle,
    required this.onRemove,
    this.indexLabel,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            '${indexLabel != null ? '$indexLabel. ' : ''}$title',
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: category.color.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(category.icon, color: category.color, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    category.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.5,
                      color: category.color,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onRemove,
                    child: const Icon(Icons.close, size: 16, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 16,
                runSpacing: 10,
                children: category.subcategories.map((sub) {
                  final isChecked = selected.contains(sub);
                  return GestureDetector(
                    onTap: () => onToggle(sub),
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          Icon(
                            isChecked
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            size: 18,
                            color: isChecked ? category.color : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              sub,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}