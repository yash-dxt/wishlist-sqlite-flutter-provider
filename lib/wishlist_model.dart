class WishList {
  final int price;
  final String product;
  final int id;

  WishList({this.price, this.product, this.id});

  Map<String, dynamic> toMap() =>
      {'id': id, 'product': product, 'price': price};

  factory WishList.fromMap(Map<String, dynamic> map) {
    return WishList(
        id: map['id'], price: map['price'], product: map['product']);
  }
}
