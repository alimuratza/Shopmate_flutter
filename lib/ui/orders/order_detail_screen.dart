import 'package:flutter/material.dart';
import '../../core/utils/toast_helper.dart';

// Order Detail Screen - shows single order details
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Order info card
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #12345',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Status: Delivered', style: TextStyle(color: Colors.green)),
                  Text('Date: Nov 10, 2024'),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Items heading
          Text(
            'Items Ordered',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12),

          // Item 1
          Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.shopping_bag, color: Colors.blue),
              ),
              title: Text('Nike Shoes'),
              subtitle: Text('Qty: 1'),
              trailing: Text('₹2999', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 8),

          // Item 2
          Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.headphones, color: Colors.orange),
              ),
              title: Text('Headphones'),
              subtitle: Text('Qty: 2'),
              trailing: Text('₹2998', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 8),

          // Item 3
          Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.watch, color: Colors.green),
              ),
              title: Text('Smart Watch'),
              subtitle: Text('Qty: 1'),
              trailing: Text('₹3999', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 16),

          Divider(),

          // Total
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('₹9996', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Track button
          ElevatedButton(
            onPressed: () {
              showToast(context, 'Tracking order');
            },
            child: Text('Track Order'),
          ),

          SizedBox(height: 12),

          // Help button
          OutlinedButton(
            onPressed: () {
              showToast(context, 'Contact support');
            },
            child: Text('Need Help?'),
          ),
        ],
      ),
    );
  }
}
