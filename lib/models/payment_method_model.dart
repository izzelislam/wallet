class PaymentMethodModel {
    int? id;
    String? name;
    String? code;
    String? thumbnail;

    PaymentMethodModel({
        this.id,
        this.name,
        this.code,
        this.thumbnail,
    });

    PaymentMethodModel copyWith({
        int? id,
        String? name,
        String? code,
        String? thumbnail,
    }) => 
        PaymentMethodModel(
            id: id ?? this.id,
            name: name ?? this.name,
            code: code ?? this.code,
            thumbnail: thumbnail ?? this.thumbnail,
        );

    factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => PaymentMethodModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "thumbnail": thumbnail,
    };
}