import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Existing colors
  static const Color navy = Color(0xFF0B1B4A);
  static const Color navyDark = Color(0xFF081340);
  static const Color orange = Color(0xFFF47B20);
  static const Color orangeLight = Color(0xFFFF8A3D);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF8A8FA3);
  static const Color hintText = Color(0xFFAAB0C0);
  static const Color normalText = Color(0xFFF5F5F6);

  static const Color fieldBorder = Color(0xFFE2E5EE);
  static const Color fieldFill = Color(0xFFFFFFFF);
  static const Color scaffoldBg = Color(0xFFFFFFFF);
  static const Color chipUnselected = Color(0xFFF0F1F6);

  static const Color success = Color(0xFF16A34A);

  static const Color badgeAssignedBg = Color(0xFFDCFCE7);
  static const Color badgeAssignedText = Color(0xFF16A34A);
  static const Color badgePendingBg = Color(0xFFFFEDD5);
  static const Color badgePendingText = Color(0xFFEA7C1F);
  static const Color star = Color(0xFFF5A623);
  static const Color iconElectricianBg = Color(0xFFEDE9FE);
  static const Color iconElectricianFg = Color(0xFF6D5BD0);
  static const Color iconPlumberBg = Color(0xFFDCEEFB);
  static const Color iconPlumberFg = Color(0xFF2E9BE0);
  static const Color iconCarpenterBg = Color(0xFFFCE9D8);
  static const Color iconCarpenterFg = Color(0xFFD97B3F);
  static const Color iconPainterBg = Color(0xFFFCE1E6);
  static const Color iconPainterFg = Color(0xFFE0577F);
  static const Color iconMoreBg = Color(0xFFF0F1F6);
  static const Color iconMoreFg = Color(0xFF8A8FA3);
  static const Color cardBorder = Color(0xFFEDEEF3);
  static const Color badgeNotifBg = Color(0xFFF47B20);

  static const Color bg = Color(0xFFF4F5F9);
  static const Color cardBg = Colors.white;
  static const Color textDark = Color(0xFF1B1B2A);
  static const Color textGrey = Color(0xFF8A8CA3);
  static const Color green = Color(0xFF2FAE60);
  static const Color pink = Color(0xFFFCE7EE);

  // --- Newly added for RequestTrackingScreen ---
  static const Color primaryPurple = Color(0xFF6338E2);
  static const Color lightPurple = Color(0xFFEAE4FF);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color blueAccent = Color(0xFF007AFF);
  static const Color lightBlue = Color(0xFFE0EFFF);
  static const Color scaffoldLightBg = Color(0xFFF8F9FA);



  // ─────────────────────────────────────────────────────────────
// ADD THESE INSIDE YOUR EXISTING AppColors CLASS
// (paste just above the closing brace `}` of AppColors)
// ─────────────────────────────────────────────────────────────

  // --- Newly added for ChooseServiceScreen ---
  static const Color iconAcBg = Color(0xFFE3E9F5);
  static const Color iconAcFg = Color(0xFF5A6B94);

  static const Color iconRoBg = Color(0xFFDCEEFB);
  static const Color iconRoFg = Color(0xFF2E9BE0);

  static const Color iconCleaningBg = Color(0xFFDCFCE7);
  static const Color iconCleaningFg = Color(0xFF16A34A);

  static const Color iconGroceryBg = Color(0xFFDCFCE7);
  static const Color iconGroceryFg = Color(0xFF16A34A);

  static const Color iconMedicineBg = Color(0xFFFDE1E1);
  static const Color iconMedicineFg = Color(0xFFE23F3F);

  static const Color iconPestBg = Color(0xFFE9F9E9);
  static const Color iconPestFg = Color(0xFF2FAE60);

  static const Color iconAutoBg = Color(0xFFDCFCE7);
  static const Color iconAutoFg = Color(0xFF16A34A);

  static const Color iconCourierBg = Color(0xFFDCEEFB);
  static const Color iconCourierFg = Color(0xFF2E9BE0);

  static const Color iconPhotographerBg = Color(0xFFEDE9FE);
  static const Color iconPhotographerFg = Color(0xFF6D5BD0);

  static const Color iconWeddingBg = Color(0xFFFDE1EA);
  static const Color iconWeddingFg = Color(0xFFE0577F);

  static const Color iconDecoratorBg = Color(0xFFF3E8FD);
  static const Color iconDecoratorFg = Color(0xFFA45EE5);

  static const Color iconCateringBg = Color(0xFFFCE9D8);
  static const Color iconCateringFg = Color(0xFFD97B3F);

  static const Color iconMakeupBg = Color(0xFFFDE1E1);
  static const Color iconMakeupFg = Color(0xFFE23F3F);

  static const Color iconDjBg = Color(0xFFF3E8FD);
  static const Color iconDjFg = Color(0xFFA45EE5);

  static const Color iconMehendiBg = Color(0xFFFCE1E6);
  static const Color iconMehendiFg = Color(0xFF8A5A3D);

  static const Color iconEventBg = Color(0xFFFDE1EA);
  static const Color iconEventFg = Color(0xFFE0577F);

  static const Color iconTutorBg = Color(0xFFDCEEFB);
  static const Color iconTutorFg = Color(0xFF2E9BE0);

  static const Color iconPanditBg = Color(0xFFFFF3D6);
  static const Color iconPanditFg = Color(0xFFE0A020);

  static const Color iconInteriorBg = Color(0xFFDCEEFB);
  static const Color iconInteriorFg = Color(0xFF2E9BE0);

  static const Color instantBannerBg = Color(0xFFEFF9F0);
  static const Color advanceBannerBg = Color(0xFFF3EFFE);
  static const Color smartSearchBg = Color(0xFFEFF3FF);

  // ─────────────────────────────────────────────────────────────
  // --- Newly added for PartnerHomeScreen + MainNavigation ---
  // ─────────────────────────────────────────────────────────────

  // Header / earnings-card gradient (bright blue → deep navy)
  static const Color primaryBlue = Color(0xFF3462F2);
  static const Color darkBlue = Color(0xFF13235E);
  static const List<Color> headerGradient = [primaryBlue, darkBlue];

  // Extra status/accent colors used by request & job cards
  static const Color red = Color(0xFFEB5757);
  static const Color purple = Color(0xFF9B6BF2);
  static const Color yellow = Color(0xFFFFC94A);

  // Generic light divider/border used inside the new cards
  // (kept distinct from cardBorder/borderLight above so existing
  // screens are unaffected if this shade needs to change later)
  static const Color border = Color(0xFFECEDF3);
}