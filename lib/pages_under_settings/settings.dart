// lib/pages_under_settings/settings.dart

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  double _distanceRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('General'),
            Card(
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.notifications_active_outlined,
                    title: 'Push Notifications',
                    trailing: Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Notifications ${value ? 'Enabled' : 'Disabled'}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  _buildSettingTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    trailing: Switch(
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Dark Mode ${value ? 'Enabled' : 'Disabled'} (requires app restart)',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Search & Location'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.location_on_outlined, color: Colors.blue),
                    title: Text('Search Radius: ${_distanceRadius.toInt()} km'),
                    subtitle: Slider(
                      value: _distanceRadius,
                      min: 1,
                      max: 50,
                      divisions: 49,
                      label: '${_distanceRadius.toInt()} km',
                      onChanged: (value) {
                        setState(() {
                          _distanceRadius = value;
                        });
                      },
                    ),
                  ),
                  _buildSettingTile(
                    icon: Icons.map_outlined,
                    title: 'Manage Saved Locations',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Simulating navigation to Manage Locations')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Account'),
            Card(
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Simulating navigation to Change Password')),
                      );
                    },
                  ),
                  _buildSettingTile(
                    icon: Icons.delete_forever_outlined,
                    title: 'Deactivate Account',
                    color: Colors.red,
                    onTap: () {
                      _showDeactivateDialog(context);
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

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blue),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showDeactivateDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Deactivate Account'),
            content: const Text(
              'Are you sure you want to permanently deactivate your account? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account Deactivation Process Initiated')),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Deactivate'),
              ),
            ],
            ),
        );
    }
}
