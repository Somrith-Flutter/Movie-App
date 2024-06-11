class CartModel {
  final String title;
  final double price;
  final String imageUrl;
  int quantity;

  CartModel({
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 0,
  });
}
