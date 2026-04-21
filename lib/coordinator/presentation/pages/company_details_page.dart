import 'package:flutter/material.dart';
import '../pages/company_view_details_page.dart';
import '../pages/edit_company_details_page.dart';

class CompanyDetailsPage extends StatefulWidget {
  const CompanyDetailsPage({super.key});

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<CompanyDetailsPage> {
  static const Color bgColor  = Color(0xFFF1F5F9);
  static const Color navy     = Color(0xFF1E3A8A);
  static const Color blue     = Color(0xFF2563EB);
  static const Color skyBlue  = Color(0xFF38BDF8);
  static const Color darkText = Color(0xFF0F172A);
  static const Color subText  = Color(0xFF64748B);
  static const Color chipGrey = Color(0xFFF1F5F9);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [navy, blue, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── SEARCH STATE ──────────────────────────────────────────
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // ── NOTIFICATION STATE ─────────────────────────────────────
  final List<Map<String, dynamic>> _notifications = [
    {
      'company': 'Infosys Ltd',
      'message': 'Infosys Ltd has registered and is now open for placements.',
      'time': '2 min ago',
      'isRead': false,
    },
    {
      'company': 'Wipro Technologies',
      'message': 'Wipro Technologies just joined the placement portal.',
      'time': '1 hr ago',
      'isRead': false,
    },
    {
      'company': 'TCS',
      'message': 'TCS has registered with 6 new openings.',
      'time': '3 hr ago',
      'isRead': true,
    },
  ];

  int get _unreadCount =>
      _notifications.where((n) => n['isRead'] == false).length;

  // ── COMPANIES LIST ─────────────────────────────────────────
  final List<Map<String, dynamic>> companies = [
    {
      'name': 'Nexora Technologies',
      'initial': 'N',
      'color': Color(0xFF2563EB),
      'bgColor': Color(0xFFEFF6FF),
      'email': 'hr@nexoratech.com',
      'location': 'Pune, Maharashtra',
      'strength': '350 employees',
      'openings': 5,
      'type': 'Product',
    },
    {
      'name': 'Goldman Sachs',
      'initial': 'G',
      'color': Color(0xFF7C3AED),
      'bgColor': Color(0xFFF5F3FF),
      'email': 'campus@gs.com',
      'location': 'Mumbai, Maharashtra',
      'strength': '5000+ employees',
      'openings': 3,
      'type': 'Finance',
    },
    {
      'name': 'Adobe Systems',
      'initial': 'A',
      'color': Color(0xFFDC2626),
      'bgColor': Color(0xFFFEF2F2),
      'email': 'recruiter@adobe.com',
      'location': 'Bengaluru, Karnataka',
      'strength': '2000+ employees',
      'openings': 2,
      'type': 'Design',
    },
    {
      'name': 'Microsoft India',
      'initial': 'M',
      'color': Color(0xFF059669),
      'bgColor': Color(0xFFECFDF5),
      'email': 'campus@microsoft.com',
      'location': 'Hyderabad, Telangana',
      'strength': '10000+ employees',
      'openings': 4,
      'type': 'Tech',
    },
    {
      'name': 'DEE Technologies',
      'initial': 'D',
      'color': Color(0xFFD97706),
      'bgColor': Color(0xFFFFFBEB),
      'email': 'hr@deetech.com',
      'location': 'Pune, Maharashtra',
      'strength': '120 employees',
      'openings': 1,
      'type': 'Startup',
    },
  ];

  List<Map<String, dynamic>> get _filteredCompanies {
    if (_searchQuery.isEmpty) return companies;
    return companies
        .where((c) => (c['name'] as String)
        .toLowerCase()
        .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── NAVIGATE TO EDIT PAGE ─────────────────────────────────
  Future<void> _navigateToEdit(Map<String, dynamic> company) async {
    final updated = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => EditCompanyDetailsPage(company: company),
      ),
    );

    if (updated != null && mounted) {
      setState(() {
        final index = companies.indexWhere(
              (c) => c['email'] == company['email'],
        );
        if (index != -1) companies[index] = updated;
      });
    }
  }

  // ── NOTIFICATION BOTTOM SHEET ──────────────────────────────
  void _showNotifications() {
    setState(() {
      for (var n in _notifications) {
        n['isRead'] = true;
      }
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: brandGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_notifications.length} Total',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _notifications.length,
                separatorBuilder: (_, __) =>
                const Divider(height: 1, indent: 72),
                itemBuilder: (_, i) {
                  final n = _notifications[i];
                  return ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: brandGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.business_rounded,
                          color: Colors.white, size: 20),
                    ),
                    title: Text(
                      n['company'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: darkText),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(n['message'],
                            style: const TextStyle(
                                fontSize: 12, color: subText)),
                        const SizedBox(height: 2),
                        Text(n['time'],
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[400])),
                      ],
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [

            // ── TOP BAR ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  // Title (hidden when searching)
                  if (!_isSearching)
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PLACEMENT CELL',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Companies',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Search bar (expanded when active)
                  if (_isSearching)
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.07),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          onChanged: (val) =>
                              setState(() => _searchQuery = val),
                          decoration: InputDecoration(
                            hintText: 'Search companies...',
                            hintStyle: const TextStyle(
                                color: subText, fontSize: 14),
                            prefixIcon: const Icon(Icons.search_rounded,
                                color: subText, size: 20),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? GestureDetector(
                              onTap: () => setState(() {
                                _searchQuery = '';
                                _searchController.clear();
                              }),
                              child: const Icon(Icons.close_rounded,
                                  color: subText, size: 18),
                            )
                                : null,
                            border: InputBorder.none,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(width: 10),

                  // Search icon button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSearching = !_isSearching;
                        if (!_isSearching) {
                          _searchQuery = '';
                          _searchController.clear();
                        }
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _isSearching ? blue : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.07),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isSearching
                            ? Icons.close_rounded
                            : Icons.search_rounded,
                        color: _isSearching ? Colors.white : subText,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Notification icon button with badge
                  GestureDetector(
                    onTap: _showNotifications,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.07),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: subText,
                            size: 20,
                          ),
                        ),
                        // Unread badge
                        if (_unreadCount > 0)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                gradient: brandGradient,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '$_unreadCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── COMPANY LIST ─────────────────────────────────
            Expanded(
              child: _filteredCompanies.isEmpty
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search_off_rounded,
                        size: 54, color: Colors.grey[300]),
                    const SizedBox(height: 12),
                    Text(
                      'No company found for "$_searchQuery"',
                      style: const TextStyle(
                          color: subText, fontSize: 14),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: _filteredCompanies.length,
                itemBuilder: (context, index) =>
                    _companyCard(_filteredCompanies[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _companyCard(Map<String, dynamic> company) {
    final Color cardColor = company['color'] as Color;
    final Color cardBg    = company['bgColor'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: cardBg,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          company['initial'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            company['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "${company['type']} · ${company['strength']}",
                            style: const TextStyle(
                                fontSize: 13, color: subText),
                          ),
                        ],
                      ),
                    ),

                    // ── PENCIL ICON → navigates to EditCompanyDetailsPage ──
                    GestureDetector(
                      onTap: () => _navigateToEdit(company),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: brandGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.edit_rounded,
                            size: 17, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _tag(Icons.location_on_rounded, company['location']),
                    _tag(Icons.people_outline_rounded, company['strength']),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _statChip(
                        Icons.mail_outline_rounded,
                        company['email'],
                        chipGrey,
                        subText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _statChip(
                      Icons.work_outline_rounded,
                      "${company['openings']} Openings",
                      Color.fromRGBO(cardColor.red, cardColor.green,
                          cardColor.blue, 0.12),
                      cardColor,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CompanyViewDetailsPage(company: company),
                      ),
                    );
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: brandGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: chipGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: subText),
          const SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String text, Color bg, Color fgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: fgColor),
          const SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}