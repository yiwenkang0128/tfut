import 'package:flutter/material.dart';
import '../services/overview_service.dart';
import '../widgets/overview_bar.dart';
import '../widgets/overview_data.dart';
import '../widgets/categorized_statistics.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  OverviewPageState createState() => OverviewPageState();
}

class OverviewPageState extends State<OverviewPage> {
  final OverviewService _overviewService = OverviewService();

  String selectedView = "month"; // "month" or "year"
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  double expenditure = 0.0;
  double income = 0.0;
  double balance = 0.0;
  Map<String, double> categorizedExpenditure = {};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOverviewData();
  }

  Future<void> _loadOverviewData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final overviewData = await _overviewService.getOverviewData(
        selectedYear,
        selectedMonth,
        selectedView,
      );

      setState(() {
        expenditure = overviewData['expenditure'] ?? 0.0;
        income = overviewData['income'] ?? 0.0;
        balance = overviewData['balance'] ?? 0.0;
        categorizedExpenditure = overviewData['categorizedExpenditure'] ?? {};
      });
    } catch (e) {
      debugPrint('Error loading overview data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load overview data. Please try again.'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onViewChange(String view) {
    setState(() {
      selectedView = view;
    });
    _loadOverviewData(); // Reload data based on view
  }

  void _onYearMonthChange(int year, int? month) {
    setState(() {
      selectedYear = year;
      selectedMonth = month ?? selectedMonth; // Keep previous month if null
    });
    _loadOverviewData(); // Reload data based on year/month change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: OverviewBar(
          selectedView: selectedView,
          onSelectedViewChanged: _onViewChange,
          selectedYear: selectedYear,
          selectedMonth: selectedMonth,
          onYearMonthChanged: _onYearMonthChange,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  OverviewData(
                    expenditure: expenditure,
                    income: income,
                    balance: balance,
                  ),
                  const SizedBox(height: 10),
                  CategorizedStatistics(
                    data: categorizedExpenditure.entries
                        .map((entry) =>
                            {'category': entry.key, 'total': entry.value})
                        .toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
