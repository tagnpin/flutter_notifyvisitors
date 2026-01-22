class SampleUser {
  static Map<String, dynamic> basic() {
    return {
      'name': 'Customer Name',
      'email': 'customer@example.com',
      'mobile': '0000000000',
      'department': 'development',
      'age': 30,
      'married': true,
      'plan_type': 1,
    };
  }

  static Map<String, dynamic> withDynamicEmail(String suffix) {
    return {
      ...basic(),
      'email': 'customer_$suffix@notifyvisitors.com',
    };
  }
}
