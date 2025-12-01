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
                    onTap: () {},
                  ),
                  _buildSupportTile(
                    icon: Icons.policy_outlined,
                    title: 'Terms and Conditions',
                    onTap: () {},
                  ),
                  _buildSupportTile(
                    icon: Icons.lock_outline,
                    title: 'Privacy Policy',
                    onTap: () {},
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