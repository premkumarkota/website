import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_navbar.dart';
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
    final isDesktop = size.width > 1000;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      body: Stack(
        children: [
          _buildBackgroundDecor(),
          CustomScrollView(
            slivers: [
              const AnimatedNavbar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 120 : 24,
                    vertical: 80,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GET IN TOUCH',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7C3AED),
                          letterSpacing: 4,
                        ),
                      ).animate().fadeIn(),
                      const SizedBox(height: 16),
                      Text(
                            "Let's Build Something\nExtraordinary Together",
                            style: TextStyle(
                              fontSize: isDesktop ? 56 : 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .slideY(begin: 0.2, end: 0),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        _buildInfoCard(
          Icons.location_on,
          'Our Office',
          'Jenveda Technologies Private Limited\n201, Padmaja Jansi Enclave, bhagyanagar Colony,\nKphb main road, Hyderabad, Telangana 500072',
        ),
        const SizedBox(height: 24),
        _buildInfoCard(Icons.phone, 'Call Us', '+91 72077 76559'),
        const SizedBox(height: 24),
        _buildInfoCard(Icons.email, 'Email Us', 'Jenvedatech@gmail.com'),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String content) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF7C3AED), size: 24),
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
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.6),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.2, end: 0);
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.06),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField('Full Name', Icons.person),
            const SizedBox(height: 24),
            _buildTextField('Email Address', Icons.email),
            const SizedBox(height: 24),
            _buildTextField('Subject', Icons.subject),
            const SizedBox(height: 24),
            _buildTextField('Your Message', Icons.message, maxLines: 5),
            const SizedBox(height: 48),
            GlowingButton(text: 'Send Message', onTap: () {}, icon: Icons.send),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        prefixIcon: Icon(icon, color: const Color(0xFF7C3AED).withOpacity(0.7)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF7C3AED)),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.02),
      ),
    );
  }

  Widget _buildBackgroundDecor() {
    return Stack(
      children: [
        Positioned(
          top: -200,
          right: -200,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF7C3AED).withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFEC4899).withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
