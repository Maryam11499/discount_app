import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 1. Discount Model Class
class Discount {
  final String id;
  final String title;
  final String description;
  final int discountPercent;
  final String storeName;
  final String voucherCode;
  final String imageUrl;
  final DateTime expiresAt;

  Discount({
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercent,
    required this.storeName,
    required this.voucherCode,
    required this.imageUrl,
    required this.expiresAt,
  });

  factory Discount.fromMap(String id, Map<String, dynamic> map) {
    return Discount(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      discountPercent: map['discountPercent'] ?? 0,
      storeName: map['storeName'] ?? '',
      voucherCode: map['voucherCode'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      expiresAt: map['expiresAt'] != null
          ? DateTime.parse(map['expiresAt'])
          : DateTime.now(),
    );
  }
}

// 2. Home / Dashboard Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // Diiwaangelinta super.key

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dhimis App - Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Soo dhawow,',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      user?.email ?? 'User',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Available Discounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('discounts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Ma jiraan dhimisyo hadda soo bixi kara."),
                  );
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    var discount = Discount.fromMap(docs[index].id, data);

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            discount.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.blueAccent,
                                  child: const Icon(Icons.local_offer, color: Colors.white),
                                ),
                          ),
                        ),
                        title: Text(
                          discount.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("${discount.storeName} - ${discount.discountPercent}% OFF"),
                        trailing: Chip(
                          label: Text(
                            discount.voucherCode,
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.blue.shade50,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}