class TransferFormModel {
    String? amount;
    String? pin;
    String? sendTo;

    TransferFormModel({
        this.amount,
        this.pin,
        this.sendTo,
    });

    TransferFormModel copyWith({
        String? amount,
        String? pin,
        String? sendTo,
    }) => 
        TransferFormModel(
            amount: amount ?? this.amount,
            pin: pin ?? this.pin,
            sendTo: sendTo ?? this.sendTo,
        );

    factory TransferFormModel.fromJson(Map<String, dynamic> json) => TransferFormModel(
        amount: json["amount"],
        pin: json["pin"],
        sendTo: json["payment_method_code"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "pin": pin,
        "send_to": sendTo,
    };
}