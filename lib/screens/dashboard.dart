import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Dashboard',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    // Handle sign-in action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () {
                    // Handle sign-up action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
