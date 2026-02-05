import 'package:flutter/material.dart';
import '../../core/utils/toast_helper.dart';

// Address Screen - manage delivery addresses
class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Addresses'),

      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Address 1
          Card(
            child: ListTile(
              leading: Icon(Icons.home, color: Colors.blue, size: 40),
              title: Text('Home'),
              subtitle: Text('123 Main Street\nNew York, NY 10001'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showToast(context, 'Address deleted');
                },
              ),
              onTap: () {
                showToast(context, 'Selected Home address');
              },
            ),
          ),

          SizedBox(height: 12),

          // Address 2
          Card(
            child: ListTile(
              leading: Icon(Icons.work, color: Colors.orange, size: 40),
              title: Text('Office'),
              subtitle: Text('456 Business Ave\nLos Angeles, CA 90001'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showToast(context, 'Address deleted');
                },
              ),
              onTap: () {
                showToast(context, 'Selected Office address');
              },
            ),
          ),

          SizedBox(height: 12),

          // Address 3
          Card(
            child: ListTile(
              leading: Icon(Icons.location_city, color: Colors.green, size: 40),
              title: Text('Other'),
              subtitle: Text('789 Park Road\nChicago, IL 60601'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showToast(context, 'Address deleted');
                },
              ),
              onTap: () {
                showToast(context, 'Selected Other address');
              },
            ),
          ),
          SizedBox(height: 40,),
          Card(
            child: ListTile(
              leading:Icon(Icons.school,size: 40,color: Colors.red,),
              title: Text("School"),
              subtitle: Text("Shalamar street"),
              trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed:(){showToast(context, "Deleted address");},),
              onTap: (){showToast(context, "Selected School address\nLos Angv001");},
            ),
          )
        ],

      ),
    );
  }
}
