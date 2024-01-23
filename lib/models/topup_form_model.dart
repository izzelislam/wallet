class TopUpFormModel {
    String? amount;
    String? pin;
    String? paymentMethodCode;

    TopUpFormModel({
        this.amount,
        this.pin,
        this.paymentMethodCode,
    });

    TopUpFormModel copyWith({
        String? amount,
        String? pin,
        String? paymentMethodCode,
    }) => 
        TopUpFormModel(
            amount: amount ?? this.amount,
            pin: pin ?? this.pin,
            paymentMethodCode: paymentMethodCode ?? this.paymentMethodCode,
        );

    factory TopUpFormModel.fromJson(Map<String, dynamic> json) => TopUpFormModel(
        amount: json["amount"],
        pin: json["pin"],
        paymentMethodCode: json["payment_method_code"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "pin": pin,
        "payment_method_code": paymentMethodCode,
    };
}