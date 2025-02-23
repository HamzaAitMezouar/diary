import 'package:diary/domain/entities/category_entity.dart';
import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 4, adapterName: 'CategoryModelAdapter')
class CategoryModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? imageUrl;

  CategoryModel({
    this.id,
    required this.name,
    this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
      };

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}
