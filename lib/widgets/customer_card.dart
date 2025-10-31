import 'package:flutter/material.dart';
import '../models/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final primaryPhone = customer.phones.firstWhere(
      (p) => p.isPrimary,
      orElse: () => customer.phones.first,
    );
    final primaryEmail = customer.emails.firstWhere(
      (e) => e.isPrimary,
      orElse: () => customer.emails.first,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        title: Text("${customer.firstName} ${customer.lastName}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("DOB: ${customer.dateOfBirth}"),
            Text("Phone: ${primaryPhone.number}"),
            Text("Email: ${primaryEmail.address}"),
          ],
        ),
      ),
    );
  }
}
