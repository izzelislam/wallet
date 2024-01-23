import 'package:bank_sha/models/data_plan_model.dart';

class OperatorCardModel {
    int? id;
    String? name;
    String? status;
    String? thumbnail;
    List<DataPlanModel>? dataPlans;

    OperatorCardModel({
        this.id,
        this.name,
        this.status,
        this.thumbnail,
        this.dataPlans,
    });

    OperatorCardModel copyWith({
        int? id,
        String? name,
        String? status,
        String? thumbnail,
        List<DataPlanModel>? dataPlans,
    }) => 
        OperatorCardModel(
            id: id ?? this.id,
            name: name ?? this.name,
            status: status ?? this.status,
            thumbnail: thumbnail ?? this.thumbnail,
            dataPlans: dataPlans ?? this.dataPlans,
        );

    factory OperatorCardModel.fromJson(Map<String, dynamic> json) => OperatorCardModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        thumbnail: json["thumbnail"],
        dataPlans: json["data_plans"] == null ? null : List<DataPlanModel>.from(json["data_plans"].map((x) => DataPlanModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "thumbnail": thumbnail,
    };
}