import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repos/auth_repo.dart';

// Home Page - After successful login
class HomePage extends StatelessWidget {
  final AuthRepo _authRepo = Get.find<AuthRepo>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        actions: [
          // Logout button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authRepo.signOut();
              Get.offAllNamed('/auth/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You are logged in',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 40),

            // Change Password button
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed('/auth/change-password');
              },
              icon: Icon(Icons.lock),
              label: Text('Change Password'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            SizedBox(height: 15),

            // Logout button
            OutlinedButton.icon(
              onPressed: () async {
                await _authRepo.signOut();
                Get.offAllNamed('/auth/login');
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
