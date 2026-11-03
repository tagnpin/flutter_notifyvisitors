class SampleEvents {
  static Map<String, dynamic> purchaseEvent() {
    return {
      'eventName': 'purchase_completed',
      'attributes': {
        'product_id': 'SKU_12345',
        'price': 2999,
        'currency': 'INR',
      },
      'ltv': '10',
      'scope': '1',
    };
  }

  static Map<String, dynamic> addToCart() {
    return {
      'eventName': 'add_to_cart',
      'attributes': {
        'product_id': 'SKU_98765',
        'category': 'Shoes',
      },
      'ltv': '10',
      'scope': '1',
    };
  }
}
