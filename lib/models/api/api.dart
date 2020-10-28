class Api {
  static const baseUrl =
      "https://df602872e2c405e672b32937ec4ab0f9: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@overstockauthentics.myshopify.com";

  static const storeFrontApi = "98ee131fb33b892bdfe491010234e7a3";

  static String get currentUserApi =>
      baseUrl + "/admin/api/2020-10/users/current.json";

  static String get createCustomerAccountApi =>
      baseUrl + "/admin/api/2020-10/customers.json";

  static String get collectionApi =>
      // baseUrl + "/admin/api/2020-10/custom_collections.json";
      baseUrl + "/admin/api/2020-10/smart_collections.json";

  static String collectionProducts(int collectionId) =>
      // baseUrl + "/admin/api/2020-10/custom_collections.json";
      baseUrl + "/admin/api/2020-10/collections/$collectionId/products.json";

  static String product(int productId) =>
      // baseUrl + "/admin/api/2020-10/custom_collections.json";
      baseUrl + "/admin/api/2020-10/products/$productId.json";
  static String get productsApi =>
      // baseUrl + "/admin/api/2020-10/custom_collections.json";
      baseUrl + "/admin/api/2020-10/products.json";

  static String get graphApi =>
      // baseUrl + "/admin/api/2020-10/custom_collections.json";
      baseUrl + "/admin/api/2020-10/graphql.json";

  static String get customerApi =>
      baseUrl + "/admin/api/2020-10/customers.json";
}
