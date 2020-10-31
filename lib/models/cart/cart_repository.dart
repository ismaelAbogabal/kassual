import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final Checkout checkout;

  CartRepository(this.checkout);

  static Future<Checkout> init([String id]) async {
    id ??= await SharedPreferences.getInstance().then(
      (value) => value.getString("checkout_id"),
    );

    if (id == null || id.isEmpty) {
      String id = await ShopifyCheckout.instance.createCheckout();
      SharedPreferences.getInstance().then(
        (value) => value.setString("checkout_id", id),
      );
    }

    String accessToken = await ShopifyAuth.currentCustomerAccessToken;
    if (accessToken != null) await _setUpCheckoutWithUser(id, accessToken);

    var checkout = await ShopifyCheckout.instance
        .getCheckoutInfoQuery(id, deleteThisPartOfCache: true);
    return checkout;
  }

  // static Future<Checkout> init(ShopifyUser user, [String id]) async {
  //   id ??= user?.lastIncompleteCheckout?.id;
  //
  //   if (id == null) {
  //     id = await ShopifyCheckout.instance.createCheckout();
  //   }
  //
  //   await ShopifyCheckout.instance.checkoutCustomerAssociate(
  //     id,
  //     await ShopifyAuth.currentCustomerAccessToken,
  //   );
  //
  //   return ShopifyCheckout.instance
  //       .getCheckoutInfoQuery(id, deleteThisPartOfCache: true);
  // }

  static Future _setUpCheckoutWithUser(
    String checkoutId,
    String userAccessToken,
  ) async {
    await ShopifyCheckout.instance.checkoutCustomerAssociate(
      checkoutId,
      userAccessToken,
    );
  }

  Future<Checkout> addProduct(String variantId) async {
    List<String> variantList = [];
    for (var value in checkout.lineItems.lineItemList) {
      for (int i = 0; i < value.quantity; i++) {
        variantList.add(value.variant.id);
      }
    }
    variantList.add(variantId);

    await ShopifyCheckout.instance.checkoutLineItemsReplace(
      checkout.id,
      variantList,
      deleteThisPartOfCache: true,
    );

    return await init(checkout.id);
  }

  Future<Checkout> removeProduct(String variantId) async {
    return changeCount(variantId, 0);
  }

  Future<Checkout> addDiscount(String discount) async {
    return checkout;
  }

  Future<Checkout> changeCount(String variant, int count) async {
    List<String> variantList = [];
    for (var value in checkout.lineItems.lineItemList) {
      if (value.variant.id == variant) {
        for (int i = 0; i < count; i++) {
          variantList.add(variant);
        }
      } else {
        for (int i = 0; i < value.quantity; i++) {
          variantList.add(value.variant.id);
        }
      }
    }
    await ShopifyCheckout.instance.checkoutLineItemsReplace(
      checkout.id,
      variantList,
      deleteThisPartOfCache: true,
    );

    return init(checkout.id);
  }

  static Future<List<Order>> allOrders() async {
    return [Order.fromJson(x)];
  }
}

var x = {
  "edges": [
    {
      "id": 450789469,
      "email": "bob.norman@hostmail.com",
      "closed_at": null,
      "created_at": "2008-01-10T11:00:00-05:00",
      "updated_at": "2008-01-10T11:00:00-05:00",
      "number": 1,
      "note": null,
      "token": "b1946ac92492d2347c6235b4d2611184",
      "gateway": "authorize_net",
      "test": false,
      "total_price": "598.94",
      "subtotal_price": "597.00",
      "total_weight": 0,
      "total_tax": "11.94",
      "taxes_included": false,
      "currency": "USD",
      "financial_status": "partially_refunded",
      "confirmed": true,
      "total_discounts": "10.00",
      "total_line_items_price": "597.00",
      "cart_token": "68778783ad298f1c80c3bafcddeea02f",
      "buyer_accepts_marketing": false,
      "name": "#1001",
      "referring_site": "http://www.otherexample.com",
      "landing_site": "http://www.example.com?source=abc",
      "cancelled_at": null,
      "cancel_reason": null,
      "total_price_usd": "598.94",
      "checkout_token": "bd5a8aa1ecd019dd3520ff791ee3a24c",
      "reference": "fhwdgads",
      "user_id": null,
      "location_id": null,
      "source_identifier": "fhwdgads",
      "source_url": null,
      "processed_at": "2008-01-10T11:00:00-05:00",
      "device_id": null,
      "phone": "+557734881234",
      "customer_locale": null,
      "app_id": null,
      "browser_ip": "0.0.0.0",
      "landing_site_ref": "abc",
      "order_number": 1001,
      "discount_applications": [
        {
          "type": "discount_code",
          "value": "10.0",
          "value_type": "fixed_amount",
          "allocation_method": "across",
          "target_selection": "all",
          "target_type": "line_item",
          "code": "TENOFF"
        }.cast()
      ],
      "discount_codes": [
        {"code": "TENOFF", "amount": "10.00", "type": "fixed_amount"}.cast()
      ],
      "note_attributes": [
        {"name": "custom engraving", "value": "Happy Birthday"}.cast(),
        {"name": "colour", "value": "green"}.cast()
      ],
      "payment_gateway_names": ["bogus"],
      "processing_method": "direct",
      "checkout_id": 901414060,
      "source_name": "web",
      "fulfillment_status": null,
      "tax_lines": [
        {
          "price": "11.94",
          "rate": 0.06,
          "title": "State Tax",
          "price_set": {
            "shop_money": {"amount": "11.94", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "11.94", "currency_code": "USD"}.cast()
          }.cast()
        }.cast()
      ],
      "tags": "",
      "contact_email": "bob.norman@hostmail.com",
      "order_status_url":
          "https://apple.myshopify.com/690933842/orders/b1946ac92492d2347c6235b4d2611184/authenticate?key=2f6c1f5b0ff2a404827949677fc5daf0",
      "presentment_currency": "USD",
      "total_line_items_price_set": {
        "shop_money": {"amount": "597.00", "currency_code": "USD"}.cast(),
        "presentment_money": {"amount": "597.00", "currency_code": "USD"}.cast()
      }.cast(),
      "total_discounts_set": {
        "shop_money": {"amount": "10.00", "currency_code": "USD"}.cast(),
        "presentment_money": {"amount": "10.00", "currency_code": "USD"}.cast()
      }.cast(),
      "total_shipping_price_set": {
        "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
        "presentment_money": {"amount": "0.00", "currency_code": "USD"}.cast()
      }.cast(),
      "subtotal_price_set": {
        "shop_money": {"amount": "597.00", "currency_code": "USD"}.cast(),
        "presentment_money": {"amount": "597.00", "currency_code": "USD"}.cast()
      }.cast(),
      "total_price_set": {
        "shop_money": {"amount": "598.94", "currency_code": "USD"}.cast(),
        "presentment_money": {"amount": "598.94", "currency_code": "USD"}.cast()
      }.cast(),
      "total_tax_set": {
        "shop_money": {"amount": "11.94", "currency_code": "USD"}.cast(),
        "presentment_money": {"amount": "11.94", "currency_code": "USD"}.cast()
      }.cast(),
      "line_items": [
        {
          "id": 466157049,
          "variant_id": 39072856,
          "title": "IPod Nano - 8gb",
          "quantity": 1,
          "sku": "IPOD2008GREEN",
          "variant_title": "green",
          "vendor": null,
          "fulfillment_service": "manual",
          "product_id": 632910392,
          "requires_shipping": true,
          "taxable": true,
          "gift_card": false,
          "name": "IPod Nano - 8gb - green",
          "variant_inventory_management": "shopify",
          "properties": [
            {"name": "Custom Engraving Front", "value": "Happy Birthday"}.cast(),
            {"name": "Custom Engraving Back", "value": "Merry Christmas"}.cast()
          ],
          "product_exists": true,
          "fulfillable_quantity": 1,
          "grams": 200,
          "price": "199.00",
          "total_discount": "0.00",
          "fulfillment_status": null,
          "price_set": {
            "shop_money": {"amount": "199.00", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "199.00", "currency_code": "USD"}.cast()
          }.cast(),
          "total_discount_set": {
            "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "0.00", "currency_code": "USD"}.cast()
          }.cast(),
          "discount_allocations": [
            {
              "amount": "3.34",
              "discount_application_index": 0,
              "amount_set": {
                "shop_money": {"amount": "3.34", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "3.34", "currency_code": "USD"}.cast()
              }.cast()
            }.cast()
          ],
          "admin_graphql_api_id": "gid://shopify/LineItem/466157049",
          "tax_lines": [
            {
              "title": "State Tax",
              "price": "3.98",
              "rate": 0.06,
              "price_set": {
                "shop_money": {"amount": "3.98", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "3.98", "currency_code": "USD"}.cast()
              }.cast()
            }.cast()
          ]
        }.cast(),
        {
          "id": 518995019,
          "variant_id": 49148385,
          "title": "IPod Nano - 8gb",
          "quantity": 1,
          "sku": "IPOD2008RED",
          "variant_title": "red",
          "vendor": null,
          "fulfillment_service": "manual",
          "product_id": 632910392,
          "requires_shipping": true,
          "taxable": true,
          "gift_card": false,
          "name": "IPod Nano - 8gb - red",
          "variant_inventory_management": "shopify",
          "properties": [],
          "product_exists": true,
          "fulfillable_quantity": 1,
          "grams": 200,
          "price": "199.00",
          "total_discount": "0.00",
          "fulfillment_status": null,
          "price_set": {
            "shop_money": {"amount": "199.00", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "199.00", "currency_code": "USD"}.cast()
          }.cast(),
          "total_discount_set": {
            "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "0.00", "currency_code": "USD"}.cast()
          }.cast(),
          "discount_allocations": [
            {
              "amount": "3.33",
              "discount_application_index": 0,
              "amount_set": {
                "shop_money": {"amount": "3.33", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "3.33", "currency_code": "USD"}.cast()
              }.cast()
            }.cast()
          ],
          "admin_graphql_api_id": "gid://shopify/LineItem/518995019",
          "tax_lines": [
            {
              "title": "State Tax",
              "price": "3.98",
              "rate": 0.06,
              "price_set": {
                "shop_money": {"amount": "3.98", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "3.98", "currency_code": "USD"}.cast()
              }.cast()
            }.cast()
          ]
        }.cast(),
        {
          "id": 703073504,
          "variant_id": 457924702,
          "title": "IPod Nano - 8gb",
          "quantity": 1,
          "sku": "IPOD2008BLACK",
          "variant_title": "black",
          "vendor": null,
          "fulfillment_service": "manual",
          "product_id": 632910392,
          "requires_shipping": true,
          "taxable": true,
          "gift_card": false,
          "name": "IPod Nano - 8gb - black",
          "variant_inventory_management": "shopify",
          "properties": [],
          "product_exists": true,
          "fulfillable_quantity": 1,
          "grams": 200,
          "price": "199.00",
          "total_discount": "0.00",
          "fulfillment_status": null,
          "price_set": {
            "shop_money": {"amount": "199.00", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "199.00", "currency_code": "USD"}.cast()
          }.cast(),
          "total_discount_set": {
            "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "0.00", "currency_code": "USD"}.cast()
          }.cast(),
          "discount_allocations": [
            {
              "amount": "3.33",
              "discount_application_index": 0,
              "amount_set": {
                "shop_money": {"amount": "3.33", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "3.33", "currency_code": "USD"}.cast()
              }.cast()
            }.cast()
          ],
          "admin_graphql_api_id": "gid://shopify/LineItem/703073504",
          "tax_lines": [
            {
              "title": "State Tax",
              "price": "3.98",
              "rate": 0.06,
              "price_set": {
                "shop_money": {"amount": "3.98", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "3.98", "currency_code": "USD"}.cast()
              }.cast()
            }.cast()
          ]
        }.cast()
      ],
      "fulfillments": [
        {
          "id": 255858046,
          "order_id": 450789469,
          "status": "failure",
          "created_at": "2020-10-29T19:09:25-04:00",
          "service": "manual",
          "updated_at": "2020-10-29T19:09:25-04:00",
          "tracking_company": "USPS",
          "shipment_status": null,
          "location_id": 905684977,
          "line_items": [
            {
              "id": 466157049,
              "variant_id": 39072856,
              "title": "IPod Nano - 8gb",
              "quantity": 1,
              "sku": "IPOD2008GREEN",
              "variant_title": "green",
              "vendor": null,
              "fulfillment_service": "manual",
              "product_id": 632910392,
              "requires_shipping": true,
              "taxable": true,
              "gift_card": false,
              "name": "IPod Nano - 8gb - green",
              "variant_inventory_management": "shopify",
              "properties": [
                {"name": "Custom Engraving Front", "value": "Happy Birthday"}.cast(),
                {"name": "Custom Engraving Back", "value": "Merry Christmas"}.cast()
              ],
              "product_exists": true,
              "fulfillable_quantity": 1,
              "grams": 200,
              "price": "199.00",
              "total_discount": "0.00",
              "fulfillment_status": null,
              "price_set": {
                "shop_money": {"amount": "199.00", "currency_code": "USD"}.cast(),
                "presentment_money": {
                  "amount": "199.00",
                  "currency_code": "USD"
                }.cast()
              }.cast(),
              "total_discount_set": {
                "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "0.00", "currency_code": "USD"}.cast()
              }.cast(),
              "discount_allocations": [
                {
                  "amount": "3.34",
                  "discount_application_index": 0,
                  "amount_set": {
                    "shop_money": {"amount": "3.34", "currency_code": "USD"}.cast(),
                    "presentment_money": {
                      "amount": "3.34",
                      "currency_code": "USD"
                    }.cast()
                  }.cast()
                }.cast()
              ],
              "admin_graphql_api_id": "gid://shopify/LineItem/466157049",
              "tax_lines": [
                {
                  "title": "State Tax",
                  "price": "3.98",
                  "rate": 0.06,
                  "price_set": {
                    "shop_money": {"amount": "3.98", "currency_code": "USD"}.cast(),
                    "presentment_money": {
                      "amount": "3.98",
                      "currency_code": "USD"
                    }.cast()
                  }.cast()
                }.cast()
              ]
            }.cast()
          ],
          "tracking_number": "1Z2345",
          "tracking_numbers": ["1Z2345"],
          "tracking_url":
              "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345",
          "tracking_urls": [
            "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"
          ],
          "receipt": {"testcase": true, "authorization": "123456"}.cast(),
          "name": "#1001.0",
          "admin_graphql_api_id": "gid://shopify/Fulfillment/255858046"
        }.cast()
      ],
      "refunds": [
        {
          "id": 509562969,
          "order_id": 450789469,
          "created_at": "2020-10-29T19:09:25-04:00",
          "note": "it broke during shipping",
          "user_id": 799407056,
          "processed_at": "2020-10-29T19:09:25-04:00",
          "restock": true,
          "admin_graphql_api_id": "gid://shopify/Refund/509562969",
          "refund_line_items": [
            {
              "id": 104689539,
              "quantity": 1,
              "line_item_id": 703073504,
              "location_id": 487838322,
              "restock_type": "legacy_restock",
              "subtotal": 195.67,
              "total_tax": 3.98,
              "subtotal_set": {
                "shop_money": {"amount": "195.67", "currency_code": "USD"}.cast(),
                "presentment_money": {
                  "amount": "195.67",
                  "currency_code": "USD"
                }.cast()
              }.cast(),
              "total_tax_set": {
                "shop_money": {"amount": "3.98", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "3.98", "currency_code": "USD"}.cast()
              }.cast(),
              "line_item": {
                "id": 703073504,
                "variant_id": 457924702,
                "title": "IPod Nano - 8gb",
                "quantity": 1,
                "sku": "IPOD2008BLACK",
                "variant_title": "black",
                "vendor": null,
                "fulfillment_service": "manual",
                "product_id": 632910392,
                "requires_shipping": true,
                "taxable": true,
                "gift_card": false,
                "name": "IPod Nano - 8gb - black",
                "variant_inventory_management": "shopify",
                "properties": [],
                "product_exists": true,
                "fulfillable_quantity": 1,
                "grams": 200,
                "price": "199.00",
                "total_discount": "0.00",
                "fulfillment_status": null,
                "price_set": {
                  "shop_money": {"amount": "199.00", "currency_code": "USD"}.cast(),
                  "presentment_money": {
                    "amount": "199.00",
                    "currency_code": "USD"
                  }.cast()
                }.cast(),
                "total_discount_set": {
                  "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
                  "presentment_money": {
                    "amount": "0.00",
                    "currency_code": "USD"
                  }.cast()
                }.cast(),
                "discount_allocations": [
                  {
                    "amount": "3.33",
                    "discount_application_index": 0,
                    "amount_set": {
                      "shop_money": {"amount": "3.33", "currency_code": "USD"}.cast(),
                      "presentment_money": {
                        "amount": "3.33",
                        "currency_code": "USD"
                      }.cast()
                    }.cast()
                  }.cast()
                ],
                "admin_graphql_api_id": "gid://shopify/LineItem/703073504",
                "tax_lines": [
                  {
                    "title": "State Tax",
                    "price": "3.98",
                    "rate": 0.06,
                    "price_set": {
                      "shop_money": {"amount": "3.98", "currency_code": "USD"}.cast(),
                      "presentment_money": {
                        "amount": "3.98",
                        "currency_code": "USD"
                      }.cast()
                    }.cast()
                  }.cast()
                ]
              }.cast()
            }.cast(),
            {
              "id": 709875399,
              "quantity": 1,
              "line_item_id": 466157049,
              "location_id": 487838322,
              "restock_type": "legacy_restock",
              "subtotal": 195.66,
              "total_tax": 3.98,
              "subtotal_set": {
                "shop_money": {"amount": "195.66", "currency_code": "USD"}.cast(),
                "presentment_money": {
                  "amount": "195.66",
                  "currency_code": "USD"
                }.cast()
              }.cast(),
              "total_tax_set": {
                "shop_money": {"amount": "3.98", "currency_code": "USD"}.cast(),
                "presentment_money": {"amount": "3.98", "currency_code": "USD"}.cast()
              }.cast(),
              "line_item": {
                "id": 466157049,
                "variant_id": 39072856,
                "title": "IPod Nano - 8gb",
                "quantity": 1,
                "sku": "IPOD2008GREEN",
                "variant_title": "green",
                "vendor": null,
                "fulfillment_service": "manual",
                "product_id": 632910392,
                "requires_shipping": true,
                "taxable": true,
                "gift_card": false,
                "name": "IPod Nano - 8gb - green",
                "variant_inventory_management": "shopify",
                "properties": [
                  {"name": "Custom Engraving Front", "value": "Happy Birthday"}.cast(),
                  {"name": "Custom Engraving Back", "value": "Merry Christmas"}.cast()
                ],
                "product_exists": true,
                "fulfillable_quantity": 1,
                "grams": 200,
                "price": "199.00",
                "total_discount": "0.00",
                "fulfillment_status": null,
                "price_set": {
                  "shop_money": {"amount": "199.00", "currency_code": "USD"}.cast(),
                  "presentment_money": {
                    "amount": "199.00",
                    "currency_code": "USD"
                  }.cast()
                }.cast(),
                "total_discount_set": {
                  "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
                  "presentment_money": {
                    "amount": "0.00",
                    "currency_code": "USD"
                  }.cast()
                }.cast(),
                "discount_allocations": [
                  {
                    "amount": "3.34",
                    "discount_application_index": 0,
                    "amount_set": {
                      "shop_money": {"amount": "3.34", "currency_code": "USD"}.cast(),
                      "presentment_money": {
                        "amount": "3.34",
                        "currency_code": "USD"
                      }.cast()
                    }.cast()
                  }.cast()
                ],
                "admin_graphql_api_id": "gid://shopify/LineItem/466157049",
                "tax_lines": [
                  {
                    "title": "State Tax",
                    "price": "3.98",
                    "rate": 0.06,
                    "price_set": {
                      "shop_money": {"amount": "3.98", "currency_code": "USD"}.cast(),
                      "presentment_money": {
                        "amount": "3.98",
                        "currency_code": "USD"
                      }.cast()
                    }.cast()
                  }.cast()
                ]
              }.cast()
            }.cast()
          ],
          "transactions": [
            {
              "id": 179259969,
              "order_id": 450789469,
              "kind": "refund",
              "gateway": "bogus",
              "status": "success",
              "message": null,
              "created_at": "2005-08-05T12:59:12-04:00",
              "test": false,
              "authorization": "authorization-key",
              "location_id": null,
              "user_id": null,
              "parent_id": 801038806,
              "processed_at": "2005-08-05T12:59:12-04:00",
              "device_id": null,
              "receipt": {}.cast(),
              "error_code": null,
              "source_name": "web",
              "amount": "209.00",
              "currency": "USD",
              "admin_graphql_api_id": "gid://shopify/OrderTransaction/179259969"
            }.cast()
          ],
          "order_adjustments": []
        }.cast()
      ],
      "total_tip_received": "0.0",
      "admin_graphql_api_id": "gid://shopify/Order/450789469",
      "shipping_lines": [
        {
          "id": 369256396,
          "title": "Free Shipping",
          "price": "0.00",
          "code": "Free Shipping",
          "source": "shopify",
          "phone": null,
          "requested_fulfillment_service_id": null,
          "delivery_category": null,
          "carrier_identifier": null,
          "discounted_price": "0.00",
          "price_set": {
            "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "0.00", "currency_code": "USD"}.cast()
          }.cast(),
          "discounted_price_set": {
            "shop_money": {"amount": "0.00", "currency_code": "USD"}.cast(),
            "presentment_money": {"amount": "0.00", "currency_code": "USD"}.cast()
          }.cast(),
          "discount_allocations": [],
          "tax_lines": []
        }.cast()
      ],
      "billing_address": {
        "first_name": "Bob",
        "address1": "Chestnut Street 92",
        "phone": "555-625-1199",
        "city": "Louisville",
        "zip": "40202",
        "province": "Kentucky",
        "country": "United States",
        "last_name": "Norman",
        "address2": "",
        "company": null,
        "latitude": 45.41634,
        "longitude": -75.6868,
        "name": "Bob Norman",
        "country_code": "US",
        "province_code": "KY"
      }.cast(),
      "shipping_address": {
        "first_name": "Bob",
        "address1": "Chestnut Street 92",
        "phone": "555-625-1199",
        "city": "Louisville",
        "zip": "40202",
        "province": "Kentucky",
        "country": "United States",
        "last_name": "Norman",
        "address2": "",
        "company": null,
        "latitude": 45.41634,
        "longitude": -75.6868,
        "name": "Bob Norman",
        "country_code": "US",
        "province_code": "KY"
      }.cast(),
      "client_details": {
        "browser_ip": "0.0.0.0",
        "accept_language": null,
        "user_agent": null,
        "session_hash": null,
        "browser_width": null,
        "browser_height": null
      }.cast(),
      "payment_details": {
        "credit_card_bin": null,
        "avs_result_code": null,
        "cvv_result_code": null,
        "credit_card_number": "•••• •••• •••• 4242",
        "credit_card_company": "Visa"
      }.cast(),
      "customer": {
        "id": 207119551,
        "email": "bob.norman@hostmail.com",
        "accepts_marketing": false,
        "created_at": "2020-10-29T19:09:25-04:00",
        "updated_at": "2020-10-29T19:09:25-04:00",
        "first_name": "Bob",
        "last_name": "Norman",
        "orders_count": 1,
        "state": "disabled",
        "total_spent": "199.65",
        "last_order_id": 450789469,
        "note": null,
        "verified_email": true,
        "multipass_identifier": null,
        "tax_exempt": false,
        "phone": "+16136120707",
        "tags": "",
        "last_order_name": "#1001",
        "currency": "USD",
        "accepts_marketing_updated_at": "2005-06-12T11:57:11-04:00",
        "marketing_opt_in_level": null,
        "tax_exemptions": [],
        "admin_graphql_api_id": "gid://shopify/Customer/207119551",
        "default_address": {
          "id": 207119551,
          "customer_id": 207119551,
          "first_name": null,
          "last_name": null,
          "company": null,
          "address1": "Chestnut Street 92",
          "address2": "",
          "city": "Louisville",
          "province": "Kentucky",
          "country": "United States",
          "zip": "40202",
          "phone": "555-625-1199",
          "name": "",
          "province_code": "KY",
          "country_code": "US",
          "country_name": "United States",
          "default": true
        }.cast()
      }.cast()
    }.cast()
  ]
}.cast();
