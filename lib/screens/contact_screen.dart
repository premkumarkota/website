import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_navbar.dart';
import '../widgets/animated_footer.dart';
import '../widgets/glowing_button.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          AnimatedNavbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 120 : 24,
                vertical: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'GET IN TOUCH',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFD946EF),
                            letterSpacing: 4,
                          ),
                        ).animate().fadeIn(),
                        const SizedBox(height: 16),
                        Text(
                              "Let's Build Something\nExtraordinary Together",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isDesktop ? 64 : 36,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF111827),
                                height: 1.1,
                                letterSpacing: -2,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 200.ms)
                            .slideY(begin: 0.2, end: 0),
                        const SizedBox(height: 24),
                        SizedBox(
                          //maxWidth: 700,
                          child: Text(
                            "Have a question or ready to transform your business? Reach out to our team of experts and let's discuss how Jenveda can empower your growth.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: const Color(0xFF4B5563),
                              height: 1.6,
                            ),
                          ),
                        ).animate().fadeIn(delay: 400.ms),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),

                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4, child: _buildContactInfo()),
                        const SizedBox(width: 80),
                        Expanded(flex: 6, child: _buildContactForm()),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildContactInfo(),
                        const SizedBox(height: 60),
                        _buildContactForm(),
                      ],
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: AnimatedFooter()),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        _buildInfoCard(
          Icons.location_on_outlined,
          'Our Office',
          'Jenveda Technologies Private Limited\n201, Padmaja Jansi Enclave, Opp. k.s Bakers, bhagyanagar Colony, Kphb main road, Hyderabad, Telangana 500072',
        ),
        const SizedBox(height: 24),
        _buildInfoCard(Icons.phone_outlined, 'Call Us', '+91 72077 76559'),
        const SizedBox(height: 24),
        _buildInfoCard(
          Icons.email_outlined,
          'Email Us',
          'Jenvedatech@gmail.com',
        ),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String content) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFD946EF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFD946EF), size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4B5563),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.1, end: 0);
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField('Full Name', Icons.person_outline),
            const SizedBox(height: 24),
            _buildTextField('Email Address', Icons.email_outlined),
            const SizedBox(height: 24),
            _buildTextField('Subject', Icons.subject_outlined),
            const SizedBox(height: 24),
            _buildTextField(
              'Your Message',
              Icons.message_outlined,
              maxLines: 5,
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerRight,
              child: GlowingButton(
                text: 'Send Message',
                onTap: () {},
                icon: Icons.send_rounded,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Color(0xFF111827)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
        prefixIcon: Icon(icon, color: const Color(0xFFD946EF)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD946EF), width: 1.5),
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
    );
  }
}
