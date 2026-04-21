import 'package:flutter/material.dart';

class RegisterCompanyPage extends StatefulWidget {
  const RegisterCompanyPage({super.key});

  @override
  State<RegisterCompanyPage> createState() => _RegisterCompanyPageState();
}

class _RegisterCompanyPageState extends State<RegisterCompanyPage> {
  // ── Palette (matches coordinator profile & dashboard) ──────────────────────
  static const Color bgColor      = Color(0xFFF1F5F9);
  static const Color navyDark     = Color(0xFF1E3A8A);
  static const Color blue         = Color(0xFF2563EB);
  static const Color skyBlue      = Color(0xFF38BDF8);
  static const Color labelColor   = Color(0xFF38BDF8);

  // Controllers – Basic Info
  final _companyNameCtrl    = TextEditingController(text: "Nexora Technologies Pvt. Ltd.");
  final _strengthCtrl       = TextEditingController(text: "350 employees");
  final _companyEmailCtrl   = TextEditingController(text: "hr@nexoratech.com");

  // Controllers – Primary Work Location
  final _cityCtrl           = TextEditingController(text: "Pune, Maharashtra");
  final _hrContactCtrl      = TextEditingController(text: "Priya Sharma");
  final _contactNumCtrl     = TextEditingController(text: "+91 98765 43210");
  final _locationEmailCtrl  = TextEditingController(text: "pune.hr@nexoratech.com");

  @override
  void dispose() {
    _companyNameCtrl.dispose();
    _strengthCtrl.dispose();
    _companyEmailCtrl.dispose();
    _cityCtrl.dispose();
    _hrContactCtrl.dispose();
    _contactNumCtrl.dispose();
    _locationEmailCtrl.dispose();
    super.dispose();
  }

  // ── Field Widget ────────────────────────────────────────────────────────────
  Widget _field({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: labelColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: bgColor,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: blue, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Section Title ────────────────────────────────────────────────────────────
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }

  // ── Section Card ─────────────────────────────────────────────────────────────
  Widget _sectionCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // ── HEADER (same style as EditCoordinatorProfilePage) ──────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [navyDark, blue, skyBlue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 12),

                    // Company icon placeholder
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.business_rounded,
                          color: blue,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register Company",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Fill in the company details",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── BASIC INFORMATION ──────────────────────────────────────────
              _sectionTitle("BASIC INFORMATION"),
              _sectionCard(children: [
                _field(
                  label: "Company Name ",
                  controller: _companyNameCtrl,
                ),
                _field(
                  label: "Company Strength ",
                  controller: _strengthCtrl,
                  keyboardType: TextInputType.text,
                ),
                _field(
                  label: "Official Company Email ",
                  controller: _companyEmailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
              ]),

              const SizedBox(height: 16),

              // ── PRIMARY WORK LOCATION ──────────────────────────────────────
              _sectionTitle("PRIMARY WORK LOCATION"),
              _sectionCard(children: [
                _field(
                  label: "City / Address ",
                  controller: _cityCtrl,
                ),
                _field(
                  label: "HR Contact Person ",
                  controller: _hrContactCtrl,
                ),
                _field(
                  label: "Contact Number ",
                  controller: _contactNumCtrl,
                  keyboardType: TextInputType.phone,
                ),
                _field(
                  label: "Location Email",
                  controller: _locationEmailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
              ]),

              const SizedBox(height: 24),

              // ── REGISTER BUTTON ────────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  // TODO: handle registration
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [navyDark, blue, skyBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: blue.withOpacity(0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}