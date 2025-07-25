// lib/screens/analytics_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/analytics_provider.dart';
import '../widgets/analytics_widget.dart';

class AnalyticsPage extends ConsumerStatefulWidget {
  final String userId;

  const AnalyticsPage({required this.userId, super.key});

  @override
  ConsumerState<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  String get formattedDate => DateFormat('yyyy-MM-dd').format(_selectedDate);

  Future<void> _loadData() async {
    await ref.read(analyticsProvider.notifier).loadData(widget.userId, formattedDate);
  }

  void _refreshData() => _loadData();

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(analyticsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3EA),
      appBar: AppBar(
        title: const Text('Analytics', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, color: Colors.black87),
            onPressed: _pickDate,
            tooltip: 'Select Date',
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: _refreshData,
            tooltip: 'Refresh Data',
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.error != null
            ? Center(
          child: Text(
            state.error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        )
            : state.macroData == null
            ? const Center(child: Text("No data available"))
            : Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFFFFE1C4),
              child: Text(
                'Showing data for: $formattedDate',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: buildAnalyticsUI(
                state.macroData!,
                state.stepData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
