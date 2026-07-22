import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'Completed', 'Pending', 'Failed'];

  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'TXN-984210',
      'service': 'AC Repair & Service',
      'date': '20 Jul 2026, 02:30 PM',
      'amount': '₹1,249',
      'status': 'Completed',
      'method': 'UPI (Google Pay)',
      'badgeBg': AppColors.badgeAssignedBg,
      'badgeText': AppColors.badgeAssignedText,
    },
    {
      'id': 'TXN-984189',
      'service': 'Plumbing Fitting & Repair',
      'date': '14 Jul 2026, 11:15 AM',
      'amount': '₹450',
      'status': 'Completed',
      'method': 'Credit Card',
      'badgeBg': AppColors.badgeAssignedBg,
      'badgeText': AppColors.badgeAssignedText,
    },
    {
      'id': 'TXN-983902',
      'service': 'House Deep Cleaning',
      'date': '02 Jul 2026, 04:00 PM',
      'amount': '₹2,199',
      'status': 'Pending',
      'method': 'Cash on Delivery',
      'badgeBg': AppColors.badgePendingBg,
      'badgeText': AppColors.badgePendingText,
    },
    {
      'id': 'TXN-982104',
      'service': 'Electrician Wiring Inspection',
      'date': '25 Jun 2026, 09:45 AM',
      'amount': '₹300',
      'status': 'Failed',
      'method': 'Net Banking',
      'badgeBg': AppColors.iconMedicineBg,
      'badgeText': AppColors.iconMedicineFg,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: CommonAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Horizontal Chips
            _buildFilterChips(),

            // List of Transactions
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                physics: const BouncingScrollPhysics(),
                itemCount: _transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final txn = _transactions[index];
                  return _buildTransactionCard(txn);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(_filters[index]),
              selected: isSelected,
              selectedColor: AppColors.navy,
              backgroundColor: AppColors.chipUnselected,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedFilterIndex = index;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> txn) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                txn['id'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: txn['badgeBg'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  txn['status'],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: txn['badgeText'],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      txn['service'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      txn['date'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                txn['amount'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.cardBorder),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.payment, size: 16, color: AppColors.textGrey),
                  const SizedBox(width: 6),
                  Text(
                    txn['method'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  // Download Invoice PDF
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading invoice for ${txn['id']}...'),
                      backgroundColor: AppColors.navy,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Row(
                  children: const [
                    Icon(Icons.picture_as_pdf_outlined, size: 15, color: AppColors.orange),
                    SizedBox(width: 4),
                    Text(
                      'Invoice',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}