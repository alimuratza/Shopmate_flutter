import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_vm.dart';

// Settings Screen - simple settings page
class SettingsScreen extends GetView<SettingsVM> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Account section
          Text(
            'Account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text('Edit Profile'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: controller.openEditProfile,
          ),

          ListTile(
            leading: Icon(Icons.lock, color: Colors.orange),
            title: Text('Change Password'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: controller.changePassword,
          ),

          Divider(height: 32),

          // App settings section
          Text(
            'App Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          ListTile(
            leading: Icon(Icons.notifications, color: Colors.green),
            title: Text('Notifications'),
            subtitle: Text('Manage notifications'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: controller.openNotifications,
          ),

          ListTile(
            leading: Icon(Icons.language, color: Colors.purple),
            title: Text('Language'),
            subtitle: Text('English'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: controller.showLanguage,
          ),

          Divider(height: 32),

          // About section
          Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          ListTile(
            leading: Icon(Icons.info, color: Colors.red),
            title: Text('App Version'),
            subtitle: Text('v1.0.0'),
            onTap: controller.showVersion,
          ),

          ListTile(
            leading: Icon(Icons.help, color: Colors.teal),
            title: Text('Help & Support'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: controller.openHelp,
          ),

          Divider(height: 32),

          // Firestore demo / assignment entry
          Text(
            'Developer / Demo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          ListTile(
            leading: Icon(Icons.storage, color: Colors.indigo),
            title: Text('Products Admin (Firestore)'),
            subtitle: Text('CRUD + query + stream demo'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: controller.openProductsAdmin,
          ),

          SizedBox(height: 24),

          // Logout button
          Center(
            child: ElevatedButton(
              onPressed: controller.logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}