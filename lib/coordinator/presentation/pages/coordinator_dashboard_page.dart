import 'package:flutter/material.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../../coordinator/presentation/pages/register_company_page.dart';
import '../../../coordinator/presentation/pages/add_edit_opening.dart';
import '../../../coordinator/presentation/pages/update_opening_page.dart';
import '../../../coordinator/presentation/pages/add_work_location_page.dart';
import '../../../coordinator/presentation/pages/company_details_page.dart';
import '../../../coordinator/presentation/pages/coordinator_profile_page.dart';
import '../../../coordinator/presentation/pages/read_opening_page.dart';
import '../../presentation/widgets/info_tile.dart';

class CoordinatorDashboardPage extends StatefulWidget {
  const CoordinatorDashboardPage({super.key});

  @override
  State<CoordinatorDashboardPage> createState() =>
      _CoordinatorDashboardPageState();
}

class _CoordinatorDashboardPageState extends State<CoordinatorDashboardPage> {
  int _currentIndex = 0;

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );
  }

  void _openAddEditOpening() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEditOpeningScreen()),
    );
  }

  void _openAddWorkLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddWorkLocationPage()),
    );
  }

  // ── NEW: navigate to Read Openings ─────────────────────────────────────────
  void _openReadOpening() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReadOpeningsPage()),
    );
  }

  void _openUpdateOpening() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UpdateOpeningScreen(),
        // Pass a real opening object when you have one:
        // builder: (context) => UpdateOpeningScreen(opening: myOpening),
      ),
    );
  }

  BottomNavigationBarItem _navItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      label: label,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: isSelected
            ? const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        )
            : null,
        child: Icon(icon, color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(color: Color(0xFFF1F5F9)),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child:
                    Icon(Icons.person, size: 26, color: Color(0xFF2563EB)),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Coordinator",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text("coordinator@email.com",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: _logout,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 10),
                    Text("Logout", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Show AppBar only on Home tab ────────────────────────────────────────
      appBar: _currentIndex == 0
          ? AppBar(
        backgroundColor: const Color(0xFFF1F5F9),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: const [
          SizedBox(width: 10),
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16),
        ],
      )
          : null,

      // ── IndexedStack keeps all pages alive ──────────────────────────────────
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Index 0 — Home
          _buildHomePage(),

          // Index 1 — Companies
          const CompanyDetailsPage(),

          // Index 2 — Jobs (placeholder)
          const Center(child: Text("Jobs Page")),

          // Index 3 — Applicants (placeholder)
          const Center(child: Text("Applicants Page")),

          // Index 4 — Profile
          const CoordinatorProfilePage(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          _navItem(Icons.home, "Home", 0),
          _navItem(Icons.business, "Companies", 1),
          _navItem(Icons.work, "Jobs", 2),
          _navItem(Icons.group, "Applicants", 3),
          _navItem(Icons.person, "Profile", 4),
        ],
      ),
    );
  }

  // ── Home Page Content ───────────────────────────────────────────────────────
  Widget _buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("GOOD MORNING",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            const Text("Hi, Coordinator",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // ── BANNER ─────────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1E3A8A),
                    Color(0xFF2563EB),
                    Color(0xFF38BDF8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PLACEMENT SEASON 2025",
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Text(
                    "78% batch placed,\nkeep the momentum.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── STAT CARDS ─────────────────────────────────────────────────────
            const Row(
              children: [
                _StatCard(
                    "28", "Companies", Icons.business, Color(0xFF2563EB)),
                _StatCard("54", "Openings", Icons.work, Color(0xFF06B6D4)),
                _StatCard(
                    "196", "Applicants", Icons.people, Color(0xFF22C55E)),
              ],
            ),

            const SizedBox(height: 25),

            // ── TILES ──────────────────────────────────────────────────────────
            InkWell(
              onTap: _openAddWorkLocation,
              child: const InfoTile(
                icon: Icons.location_on,
                title: "Add Work Location",
                subtitle: "Add work company locations",
                color: Color(0xFF38BDF8),
              ),
            ),

            // ── UPDATED: "Read Opening" tile now navigates ─────────────────────
            InkWell(
              onTap: _openReadOpening,
              child: const InfoTile(
                icon: Icons.visibility,
                title: "Read Opening",
                subtitle: "View all job openings",
                color: Color(0xFF38BDF8),
              ),
            ),

            // ── UPDATED: "Update Opening" tile now navigates ───────────────────
            InkWell(
              onTap: _openUpdateOpening,
              child: const InfoTile(
                icon: Icons.update,
                title: "Update Opening",
                subtitle: "Edit existing openings",
                color: Color(0xFF1E3A8A),
              ),
            ),

            const SizedBox(height: 20),

            // ── ACTION BUTTONS ─────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterCompanyPage()),
                      );
                    },
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                        ),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Add Company",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.north_east, color: Colors.white),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text("Register new recruiter",
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _openAddEditOpening,
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF22D3EE), Color(0xFF06B6D4)],
                        ),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Post Job",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.north_east, color: Colors.black),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text("Create new opening",
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ── Stat Card ───────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  final IconData icon;
  final Color color;

  const _StatCard(this.number, this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(number,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}