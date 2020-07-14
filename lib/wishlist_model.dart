class WishList {
  final int price;
  final String product;
  final int index;

  WishList({this.price, this.product, this.index});

  Map<String, dynamic> toMap() =>
      {"index": index, "product": product, "price": price};

  factory WishList.fromMap(Map<String, dynamic> map) {
    return WishList(
        index: map['index'], price: map['price'], product: map['product']);
  }
}
