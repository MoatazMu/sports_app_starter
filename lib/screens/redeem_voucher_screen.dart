import 'package:flutter/material.dart';

class RedeemVoucherScreen extends StatelessWidget {
  final List<Map<String, dynamic>> vouchers = [
    {
      'title': '10 AED Off',
      'points': 50,
      'description': 'Use on any booking',
      'redeemable': true,
    },
    {
      'title': 'Free Match',
      'points': 200,
      'description': '1-hour match free (up to AED 200)',
      'redeemable': false,
    },
    {
      'title': '20 AED Discount',
      'points': 100,
      'description': 'Valid for padel courts only',
      'redeemable': true,
    },
  ];

  RedeemVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem Vouchers'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: vouchers.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          final isAvailable = voucher['redeemable'] == true;

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Icon(
                isAvailable ? Icons.card_giftcard : Icons.lock,
                color: isAvailable ? Colors.deepPurple : Colors.grey,
              ),
              title: Text(
                voucher['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isAvailable ? Colors.black : Colors.grey,
                ),
              ),
              subtitle: Text(
                '${voucher['points']} pts - ${voucher['description']}',
                style: TextStyle(color: isAvailable ? Colors.black54 : Colors.grey),
              ),
              trailing: isAvailable
                  ? ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${voucher['title']} redeemed!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Redeem'),
                    )
                  : const Text('Locked', style: TextStyle(color: Colors.grey)),
            ),
          );
        },
      ),
    );
  }
}