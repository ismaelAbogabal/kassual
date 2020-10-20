class Address {
  final String apartment;
  final String city;
  final String country;
  final String governorat;
  final String postalCode;
  final String phone;

  Address({
    this.apartment,
    this.city,
    this.country,
    this.governorat,
    this.postalCode,
    this.phone,
  });

  Address copyWith({
    String apartment,
    String city,
    String country,
    String governorat,
    String postalCode,
    String phone,
  }) {
    return Address(
      apartment: apartment ?? this.apartment,
      city: city ?? this.city,
      country: country ?? this.country,
      governorat: governorat ?? this.governorat,
      postalCode: postalCode ?? this.postalCode,
      phone: phone ?? this.phone,
    );
  }
}
