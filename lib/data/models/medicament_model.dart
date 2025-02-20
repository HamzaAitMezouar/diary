// To parse this JSON data, do
//
//     final medicamentModel = medicamentModelFromJson(jsonString);

import 'dart:convert';

import 'package:diary/data/models/category_model.dart';

import '../../domain/entities/medicament_entity.dart';

MedicamentModel medicamentModelFromJson(String str) => MedicamentModel.fromJson(json.decode(str));

String medicamentModelToJson(MedicamentModel data) => json.encode(data.toJson());

class MedicamentModel {
  int? id;
  String name;
  String? presentation;
  String? manufacturer;
  List<String> composition;
  String? status;
  double ppv;
  double? hospitalPrice;
  bool table;
  String? productNature;
  String? imageUrl;
  CategoryModel category;

  MedicamentModel({
    this.id,
    required this.name,
    this.presentation,
    this.manufacturer,
    required this.composition,
    this.status,
    required this.ppv,
    this.hospitalPrice,
    required this.table,
    this.productNature,
    this.imageUrl,
    required this.category,
  });

  factory MedicamentModel.fromJson(Map<String, dynamic> json) => MedicamentModel(
      id: json["id"],
      name: json["name"],
      presentation: json["presentation"],
      manufacturer: json["manufacturer"],
      composition: List<String>.from(json["composition"].map((x) => x)),
      status: json["status"],
      ppv: json["ppv"]?.toDouble(),
      hospitalPrice: json["hospitalPrice"]?.toDouble(),
      table: json["table"],
      productNature: json["productNature"],
      imageUrl: json["imageUrl"],
      category: CategoryModel(name: "TEST")
      // CategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "presentation": presentation,
        "manufacturer": manufacturer,
        "composition": List<dynamic>.from(composition.map((x) => x)),
        "status": status,
        "ppv": ppv,
        "hospitalPrice": hospitalPrice,
        "table": table,
        "productNature": productNature,
        "imageUrl": imageUrl,
        "category": category.toJson(),
      };
  MedicamentEntity toEntity() {
    return MedicamentEntity(
        id: id,
        name: name,
        presentation: presentation,
        manufacturer: manufacturer,
        composition: composition,
        status: status,
        ppv: ppv,
        hospitalPrice: hospitalPrice,
        table: table,
        productNature: productNature,
        imageUrl: imageUrl,
        category: category.toEntity(),
        selectedQuantiy: 1);
  }
}
