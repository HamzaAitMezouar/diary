// To parse this JSON data, do
//
//     final medicamentModel = medicamentModelFromJson(jsonString);

import 'dart:convert';

import 'package:diary/data/models/category_model.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/medicament_entity.dart';
part 'medicament_model.g.dart';

MedicamentModel medicamentModelFromJson(String str) => MedicamentModel.fromJson(json.decode(str));

String medicamentModelToJson(MedicamentModel data) => json.encode(data.toJson());

@HiveType(typeId: 3, adapterName: 'MedicamentModelAdapter')
class MedicamentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? presentation;
  @HiveField(3)
  String? manufacturer;
  @HiveField(4)
  List<String> composition;
  @HiveField(5)
  String? status;
  @HiveField(6)
  double ppv;
  @HiveField(7)
  double? hospitalPrice;
  @HiveField(8)
  bool table;
  @HiveField(9)
  String? productNature;
  @HiveField(10)
  String? imageUrl;
  @HiveField(11)
  CategoryModel category;
  @HiveField(12)
  int selectedQuantiy;
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
    this.selectedQuantiy = 1,
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
        category: CategoryModel(name: "TEST"),
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
        selectedQuantiy: selectedQuantiy);
  }

  MedicamentModel copyWith({int? quantity}) {
    return MedicamentModel(
      name: name,
      composition: composition,
      ppv: ppv,
      table: table,
      category: category,
      presentation: presentation,
      manufacturer: manufacturer,
      status: status,
      hospitalPrice: hospitalPrice,
      productNature: productNature,
      imageUrl: imageUrl,
      selectedQuantiy: quantity ?? selectedQuantiy,
    );
  }
}
