// lib/screens/analytics_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../home/step_counter/presentation/step_counter_section.dart';
import '../providers/analytics_provider.dart';
import '../widgets/analytics_widget.dart';

class AnalyticsView extends ConsumerStatefulWidget {
  final String userId;
  const AnalyticsView({required this.userId, super.key});

  @override
  ConsumerState<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends ConsumerState<AnalyticsView> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().subtract(const Duration(days: 1));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(analyticsProvider.notifier).loadData(widget.userId, _formattedDate);
    });
  }

  String get _formattedDate => DateFormat('yyyy-MM-dd').format(_selectedDate);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
      ref.read(analyticsProvider.notifier).loadData(widget.userId, _formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(analyticsProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          state.error!,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (state.macroData == null) {
      return const Center(child: Text("No data available"));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        // date bar
            Container(
              color: const Color(0xFFFFE1C4),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Data for ${_formattedDate}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today_outlined),
                    onPressed: _pickDate,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => ref.read(analyticsProvider.notifier).loadData(widget.userId, _formattedDate),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
        
            // actual charts and lists
            Expanded(
              child: buildAnalyticsUI(state.macroData!, state.stepData),
            ),
          ],
        ),
      ),
    );
  }
}
