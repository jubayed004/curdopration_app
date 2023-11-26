class Products {
  final String id,
      productName,
      productCode,
      image,
      unitPrice,
      totalPrice,
      createdAt,
      quantity;

  Products(this.id, this.productName, this.productCode, this.image,
      this.unitPrice, this.totalPrice, this.createdAt, this.quantity);

  factory Products.toJson(Map<String, dynamic> e) {
    return Products(
      e['_id'],
      e['ProductName'],
      e['ProductCode'],
      e['Img'],
      e['UnitPrice'],
      e['TotalPrice'],
      e['CreatedDate'],
      e['Qty'],
    );
  }
}
