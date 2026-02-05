import 'package:flutter/material.dart';
import '../../core/utils/toast_helper.dart';

// Payment Methods Screen - manage credit/debit cards
class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showToast(context, 'Add new card');
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Visa Card
          Card(
            color: Colors.blue[50],
            child: ListTile(
              leading: Icon(Icons.credit_card, color: Colors.blue, size: 40),
              title: Text('Visa Card'),
              subtitle: Text('**** **** **** 1234'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showToast(context, 'Card removed');
                },
              ),
              onTap: () {
                showToast(context, 'Selected Visa card');
              },
            ),
          ),

          SizedBox(height: 12),

          // MasterCard
          Card(
            color: Colors.orange[50],
            child: ListTile(
              leading: Icon(Icons.credit_card, color: Colors.orange, size: 40),
              title: Text('MasterCard'),
              subtitle: Text('**** **** **** 5678'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showToast(context, 'Card removed');
                },
              ),
              onTap: () {
                showToast(context, 'Selected MasterCard');
              },
            ),
          ),

          SizedBox(height: 12),

          // Debit Card
          Card(
            color: Colors.green[50],
            child: ListTile(
              leading: Icon(Icons.credit_card, color: Colors.green, size: 40),
              title: Text('Debit Card'),
              subtitle: Text('**** **** **** 9012'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showToast(context, 'Card removed');
                },
              ),
              onTap: () {
                showToast(context, 'Selected Debit card');
              },
            ),
          ),

          SizedBox(height: 24),

          // Add card button
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                showToast(context, 'Add new card');
              },
              icon: Icon(Icons.add),
              label: Text('Add New Card'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton.icon(onPressed: (){showToast(context, "Card removed");},icon: Icon(Icons.remove),label: Text("Remove"),),
            
          )
        ],
      ),
    );
  }
}
