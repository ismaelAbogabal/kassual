import 'package:flutter_simple_shopify/flutter_simple_shopify.dart'
    hide Address;
import 'package:flutter_simple_shopify/models/src/shopify_user.dart';

class UserRepository {
  static Map get headers => {"content-type": "Application/json"};

  static Future<ShopifyUser> createUser({
    String firstName,
    String lastName,
    String email,
    String password,
  }) async {
    var user = await ShopifyAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  static Future<ShopifyUser> loginUser({
    String email,
    String password,
  }) async {
    return ShopifyAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    return ShopifyAuth.instance.signOutCurrentUser();
  }

  static Future<ShopifyUser> init() async {
    return ShopifyAuth.instance.currentUser(deleteThisPartOfCache: true);
  }

  static Future<void> removeAddress(Address address) async {
    return ShopifyCustomer.instance.customerAddressDelete(
      addressId: address.id,
      customerAccessToken: await ShopifyAuth.currentCustomerAccessToken,
    );
  }

  static Future<void> addAddress(Address address) async {
    return ShopifyCustomer.instance.customerAddressCreate(
      address1: address.address1,
      address2: address.address2,
      zip: address.zip,
      province: address.province,
      phone: address.phone,
      country: address.country,
      company: address.company,
      city: address.city,
      lastName: address.lastName,
      firstName: address.firstName,
      customerAccessToken: await ShopifyAuth.currentCustomerAccessToken,
    );
  }

  static Future<void> modifyAddress(Address address) async {
    return ShopifyCustomer.instance.customerAddressUpdate(
      address.address1,
      address.address2,
      address.company,
      address.city,
      address.country,
      address.lastName,
      address.firstName,
      address.phone,
      address.province,
      address.zip,
      await ShopifyAuth.currentCustomerAccessToken,
      address.id,
    );
  }
}
