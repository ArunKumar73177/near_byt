// lib/pages_under_settings/help_and_support.dart

import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need Assistance?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Find answers to your questions or contact us directly.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Quick Links'),
            Card(
              child: Column(
                children: [
                  _buildSupportTile(
                    icon: Icons.question_answer_outlined,
                    title: 'FAQ - Frequently Asked Questions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FAQPage()),
                      );
                    },
                  ),
                  _buildSupportTile(
                    icon: Icons.policy_outlined,
                    title: 'Terms and Conditions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TermsAndConditionsPage()),
                      );
                    },
                  ),
                  _buildSupportTile(
                    icon: Icons.lock_outline,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Contact Us'),
            Card(
              child: Column(
                children: [
                  _buildSupportTile(
                    icon: Icons.email_outlined,
                    title: 'Email Support',
                    subtitle: 'support@nearbyt.com',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Simulating email client open')),
                      );
                    },
                  ),
                  _buildSupportTile(
                    icon: Icons.phone_outlined,
                    title: 'Call Center',
                    subtitle: '+91 98765 43210 (9am - 6pm IST)',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Simulating call dialer open')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildSupportTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

// FAQ Page
class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFAQItem(
            question: 'How do I create an account?',
            answer: 'To create an account, tap on the "Sign Up" button on the home screen and fill in your details including email, password, and basic information. You\'ll receive a verification email to complete the registration.',
          ),
          _buildFAQItem(
            question: 'How do I search for nearby shops?',
            answer: 'Use the search bar on the home screen or enable location services to automatically discover shops near you. You can filter by category, distance, and ratings.',
          ),
          _buildFAQItem(
            question: 'How do I place an order?',
            answer: 'Browse products from your chosen shop, add items to cart, review your order, and proceed to checkout. You can choose between home delivery or pickup options.',
          ),
          _buildFAQItem(
            question: 'What payment methods are accepted?',
            answer: 'We accept multiple payment methods including credit/debit cards, UPI, net banking, and cash on delivery (where available).',
          ),
          _buildFAQItem(
            question: 'How can I track my order?',
            answer: 'Go to "My Orders" section in your profile to track all your orders in real-time. You\'ll receive notifications at each stage of delivery.',
          ),
          _buildFAQItem(
            question: 'What is the return/refund policy?',
            answer: 'Returns are accepted within 7 days of delivery for eligible products. Refunds are processed within 5-7 business days after the returned item is received and verified.',
          ),
          _buildFAQItem(
            question: 'How do I contact customer support?',
            answer: 'You can reach us via email at support@nearbyt.com or call our customer service at +91 98765 43210 (9am - 6pm IST). We typically respond within 24 hours.',
          ),
          _buildFAQItem(
            question: 'Can I edit my order after placing it?',
            answer: 'Orders can be modified within 5 minutes of placement. After that, please contact the shop directly or our customer support for assistance.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

// Terms and Conditions Page
class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Updated: December 15, 2025',
              style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Acceptance of Terms',
              'By accessing and using the NearbyT application, you accept and agree to be bound by the terms and conditions of this agreement. If you do not agree to these terms, please do not use our service.',
            ),
            _buildSection(
              '2. User Account',
              'You are responsible for maintaining the confidentiality of your account credentials. You agree to accept responsibility for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account.',
            ),
            _buildSection(
              '3. Service Description',
              'NearbyT provides a platform connecting users with local shops and businesses. We facilitate transactions between buyers and sellers but are not directly involved in the actual transaction between users and merchants.',
            ),
            _buildSection(
              '4. User Conduct',
              'You agree not to use the service to:\n• Violate any laws or regulations\n• Post false, inaccurate, or misleading information\n• Impersonate any person or entity\n• Interfere with or disrupt the service\n• Attempt to gain unauthorized access to any part of the service',
            ),
            _buildSection(
              '5. Orders and Payments',
              'All orders placed through the app are subject to acceptance by the respective merchant. Prices are subject to change without notice. Payment must be made through approved payment methods. We reserve the right to refuse or cancel orders.',
            ),
            _buildSection(
              '6. Delivery',
              'Delivery times are estimates and not guaranteed. We are not responsible for delays caused by circumstances beyond our control. Risk of loss and title for items pass to you upon delivery.',
            ),
            _buildSection(
              '7. Returns and Refunds',
              'Return and refund policies are determined by individual merchants. Please review the specific merchant\'s policy before making a purchase. NearbyT facilitates the return process but does not control merchant policies.',
            ),
            _buildSection(
              '8. Intellectual Property',
              'All content on the NearbyT app, including text, graphics, logos, and software, is the property of NearbyT or its licensors and is protected by copyright and other intellectual property laws.',
            ),
            _buildSection(
              '9. Limitation of Liability',
              'NearbyT shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of or inability to use the service.',
            ),
            _buildSection(
              '10. Changes to Terms',
              'We reserve the right to modify these terms at any time. Continued use of the service after changes constitutes acceptance of the modified terms.',
            ),
            _buildSection(
              '11. Termination',
              'We may terminate or suspend your account at any time without prior notice for conduct that violates these terms or is harmful to other users, us, or third parties.',
            ),
            _buildSection(
              '12. Contact Information',
              'For questions about these Terms and Conditions, please contact us at:\nEmail: legal@nearbyt.com\nPhone: +91 98765 43210',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// Privacy Policy Page
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Updated: December 15, 2025',
              style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Information We Collect',
              'We collect information you provide directly to us, including:\n• Name, email address, phone number\n• Delivery address and location data\n• Payment information\n• Order history and preferences\n• Device information and usage data',
            ),
            _buildSection(
              '2. How We Use Your Information',
              'We use the information we collect to:\n• Process and fulfill your orders\n• Communicate with you about orders and services\n• Improve our services and user experience\n• Send promotional materials (with your consent)\n• Detect and prevent fraud\n• Comply with legal obligations',
            ),
            _buildSection(
              '3. Location Information',
              'With your permission, we collect location data to:\n• Show nearby shops and businesses\n• Provide accurate delivery services\n• Improve local recommendations\n\nYou can disable location services at any time through your device settings.',
            ),
            _buildSection(
              '4. Information Sharing',
              'We may share your information with:\n• Merchants to fulfill your orders\n• Payment processors to complete transactions\n• Delivery partners for order fulfillment\n• Service providers who assist in operations\n• Law enforcement when required by law\n\nWe do not sell your personal information to third parties.',
            ),
            _buildSection(
              '5. Data Security',
              'We implement appropriate security measures to protect your personal information. However, no method of transmission over the internet is 100% secure, and we cannot guarantee absolute security.',
            ),
            _buildSection(
              '6. Your Rights',
              'You have the right to:\n• Access your personal information\n• Correct inaccurate data\n• Request deletion of your data\n• Opt-out of marketing communications\n• Export your data\n\nTo exercise these rights, contact us at privacy@nearbyt.com',
            ),
            _buildSection(
              '7. Cookies and Tracking',
              'We use cookies and similar technologies to enhance user experience, analyze usage patterns, and personalize content. You can control cookie settings through your browser.',
            ),
            _buildSection(
              '8. Children\'s Privacy',
              'Our service is not intended for users under 13 years of age. We do not knowingly collect personal information from children under 13.',
            ),
            _buildSection(
              '9. Data Retention',
              'We retain your information for as long as necessary to provide services and comply with legal obligations. You may request deletion of your account at any time.',
            ),
            _buildSection(
              '10. Changes to Privacy Policy',
              'We may update this Privacy Policy periodically. We will notify you of significant changes via email or app notification.',
            ),
            _buildSection(
              '11. International Data Transfers',
              'Your information may be transferred to and processed in countries other than your country of residence. We ensure appropriate safeguards are in place.',
            ),
            _buildSection(
              '12. Contact Us',
              'For privacy-related questions or concerns:\nEmail: privacy@nearbyt.com\nPhone: +91 98765 43210\nAddress: NearbyT Inc., Meerut, Uttar Pradesh, India',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}