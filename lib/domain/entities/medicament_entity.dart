import 'package:diary/domain/entities/category_entity.dart';

import '../../data/models/medicament_model.dart';

class MedicamentEntity {
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
  CategoryEntity category;
  int selectedQuantiy;
  MedicamentEntity({
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
  MedicamentEntity copyWith({int? selectedQuantiy}) {
    return MedicamentEntity(
        id: id,
        presentation: presentation,
        manufacturer: manufacturer,
        name: name,
        status: status,
        hospitalPrice: hospitalPrice,
        productNature: productNature,
        imageUrl: imageUrl,
        composition: composition,
        ppv: ppv,
        table: table,
        category: category,
        selectedQuantiy: selectedQuantiy ?? this.selectedQuantiy);
  }

  MedicamentModel toModel() {
    return MedicamentModel(
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
      category: category.toModel(),
    );
  }
}
