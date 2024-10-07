class ApiEndPoints {
  static String getAuthPhoneCheck = "/auth/user/by-phone";
  static String postLogin = "/auth/user/login";

  static String getBranches = "/branches";

//-------- Brand -----------//
  static String getBrands = "/brands";
  static String brandCreate = '/brands/create';
  static String brandUpdate = '/brands/update/';
  static const String brandDelete = "/brands/delete/";

//--------- Category ---------//
  static String getCategories = "/categories";
  static const String categoryCreate = '/categories/create';
  static const String categoryUpdate = '/categories/update/';
  static const String categoryDelete = "/categories/delete/";
  static const String getCateogriesOnBranch = "/categories/";
  static const String getProductDiscountCategories =
      "/categories/product-discount";
  static String createProduct = "/products/create";
  static const String updateProduct = "/products/update";
  static const String deleteProduct = '/products/delete';
  static String getMe = "/auth/user/me";
  static String getProductsByPagination = "/products/with-pagination";
  static String dummy = "___";
  static const String updateProfile = '/auth/user/update-profile';
  static const String permissionCreate = "/permission/create";
  static const String permission = '/permission';
  static const String users = '/user';
  static const String checkPhoneNumberExist = "/auth/user/by-phone";
  static const String registerNewAccount = "/auth/user/register";

  static const String getVouchersByPagination =
      "/voucher/by-date-range-and-branch-with-pagination";

  //static const String voucherExcel = '/excel-export/voucher-list';
  // static const ///branches/products/
  //...............Supplier................//
  static const String supplierNewCreate = "/supplier";
  static const String supplierFetch = "/supplier";
  //...............Supply Order................//
  static const String supplierNewOrder = "/supply-order";
  static const String fetchSupplyOrder = "/supply-order";
  // static const String voucherExcel = '/excel-export/voucher-list';
  static const String productsOnBranch = "/branches/products/";
  static const String getVoucherDetail = "/voucher/by-voc-no/";
  static const String voucherExcel = "/excel-export/voucher-list-with-options";
  static const String paymentExcel =
      "/excel-export/export-payment-history-by-id-list";
  static const String transferStock = '/stock-transfer';
  static const String transferStockHistory =
      '/stock-transfer/records-with-pagination';
  // ---------------  Discount --------------------//
  static const String getDiscountsProducts = '/discounts';
  static const String getDiscountProductsWithPagination =
      "/discounts/with-pagination";
  static const String productDiscountCreate = "/discounts/create";
  static const String productDiscountEdit = "/discounts/update/";
  static const String productDiscountDelete = "/discounts/delete/";
  static const String getVoucherDiscounts = '/voucher-discount';
  static const String voucherDiscountCreate = "/voucher-discount/create";
  static const String voucherDiscountUpdate = "/voucher-discount/update/";
  static const String voucherDiscountDelete = "/voucher-discount/delete/";

  // ---------------  Expense --------------------//
  static const String expense = '/expense-category-group';
  static const String expenseCategory = '/expense-category-group/categories';
  static const String expenseCreate = '/branches';
  static const String branchExpenseList = '/branches/expenses/list';

  // ---------------- Online Shop -------------------//
  static const String onlineRecordList =
      '/stock-transfer/online-record-list-with-pagination';
  static const String transferOnlineStock = '/stock-transfer/online';
  // static const String fetchOnlineProducts = '/products/fetch-online-product/';

  // ---------------  Report --------------------//
  static const String report = '/report';

  // --------------- Change Price ----------------//
  static const String priceChange = '/products/update-price';
  static const String fetchPriceChangeRecords = '/price-records/';
  // ---------------  ledger --------------------//
  static const String ledger = '/ledger';

  // -------------- Monthly Report ----------//
  static const String fetchMonthlyReportVouchers =
      "/voucher/by-date-range-and-branch";
  static const String monthlyReport = "/voucher/total-by-date-range";
  static const String monthlyExcelExport = '/excel-export/voucher-list';
  static const String excelReport = '/excel-export/voucher-list-date-range';
}
