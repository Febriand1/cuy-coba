/// Data untuk line chart - Impressions per hari (7 hari terakhir)
final List<Map<String, dynamic>> impressionsData = [
  {'day': 'Mon', 'value': 12500},
  {'day': 'Tue', 'value': 15800},
  {'day': 'Wed', 'value': 14200},
  {'day': 'Thu', 'value': 18900},
  {'day': 'Fri', 'value': 21500},
  {'day': 'Sat', 'value': 19800},
  {'day': 'Sun', 'value': 16700},
];

/// Data untuk line chart - Clicks per hari (7 hari terakhir)
final List<Map<String, dynamic>> clicksData = [
  {'day': 'Mon', 'value': 890},
  {'day': 'Tue', 'value': 1250},
  {'day': 'Wed', 'value': 980},
  {'day': 'Thu', 'value': 1580},
  {'day': 'Fri', 'value': 1890},
  {'day': 'Sat', 'value': 1650},
  {'day': 'Sun', 'value': 1320},
];

/// Data untuk bar chart - Revenue per bulan (6 bulan terakhir)
final List<Map<String, dynamic>> revenueData = [
  {'month': 'Jul', 'value': 8500},
  {'month': 'Aug', 'value': 9200},
  {'month': 'Sep', 'value': 11800},
  {'month': 'Oct', 'value': 10500},
  {'month': 'Nov', 'value': 13200},
  {'month': 'Dec', 'value': 12500},
];

/// Data untuk pie chart - Campaign status distribution
final List<Map<String, dynamic>> campaignStatusData = [
  {'status': 'Active', 'count': 45, 'color': 0xFF4CAF50},
  {'status': 'Paused', 'count': 12, 'color': 0xFFFF9800},
  {'status': 'Draft', 'count': 8, 'color': 0xFF9E9E9E},
  {'status': 'Scheduled', 'count': 15, 'color': 0xFF2196F3},
  {'status': 'Completed', 'count': 20, 'color': 0xFF9C27B0},
];

/// Data untuk pie chart - Traffic sources
final List<Map<String, dynamic>> trafficSourceData = [
  {'source': 'Direct', 'percentage': 35.0, 'color': 0xFF2196F3},
  {'source': 'Social', 'percentage': 28.0, 'color': 0xFFE91E63},
  {'source': 'Search', 'percentage': 22.0, 'color': 0xFF4CAF50},
  {'source': 'Referral', 'percentage': 15.0, 'color': 0xFFFF9800},
];

/// Data untuk performance metrics
final List<Map<String, dynamic>> performanceData = [
  {'metric': 'CTR', 'value': 3.8, 'change': 0.5, 'isUp': true},
  {'metric': 'CPC', 'value': 0.45, 'change': 0.08, 'isUp': false},
  {'metric': 'CPM', 'value': 2.80, 'change': 0.15, 'isUp': true},
  {'metric': 'ROAS', 'value': 4.2, 'change': 0.3, 'isUp': true},
];

/// Data untuk weekly comparison
final List<Map<String, dynamic>> weeklyComparisonData = [
  {'week': 'Week 1', 'impressions': 85000, 'clicks': 6200, 'conversions': 450},
  {'week': 'Week 2', 'impressions': 92000, 'clicks': 7100, 'conversions': 520},
  {'week': 'Week 3', 'impressions': 78000, 'clicks': 5900, 'conversions': 410},
  {'week': 'Week 4', 'impressions': 105000, 'clicks': 8500, 'conversions': 680},
];
