// address_model.dart  (Create this file)

class Address {
  final String line1;
  final String line2;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  String get fullAddress => '$line1, $line2, $city, $state $postalCode, $country';
  String get shortAddress => '$line1, $city, $postalCode';
}
