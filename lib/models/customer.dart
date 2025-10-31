class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String maritalStatus;
  final String secureId;
  final List<Address> addresses;
  final List<Phone> phones;
  final List<Email> emails;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.secureId,
    required this.addresses,
    required this.phones,
    required this.emails,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      maritalStatus: json['maritalStatus'],
      secureId: json['secureId'],
      addresses: (json['addresses'] as List)
          .map((a) => Address.fromJson(a))
          .toList(),
      phones: (json['phones'] as List).map((p) => Phone.fromJson(p)).toList(),
      emails: (json['emails'] as List).map((e) => Email.fromJson(e)).toList(),
    );
  }
}

class Address {
  final String id, type, street, city, state, zipCode;
  Address({
    required this.id,
    required this.type,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });
  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json['id'],
    type: json['type'],
    street: json['street'],
    city: json['city'],
    state: json['state'],
    zipCode: json['zipCode'],
  );
}

class Phone {
  final String id, type, number;
  final bool isPrimary;
  Phone({
    required this.id,
    required this.type,
    required this.number,
    required this.isPrimary,
  });
  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    id: json['id'],
    type: json['type'],
    number: json['number'],
    isPrimary: json['isPrimary'],
  );
}

class Email {
  final String id, type, address;
  final bool isPrimary;
  Email({
    required this.id,
    required this.type,
    required this.address,
    required this.isPrimary,
  });
  factory Email.fromJson(Map<String, dynamic> json) => Email(
    id: json['id'],
    type: json['type'],
    address: json['address'],
    isPrimary: json['isPrimary'],
  );
}
