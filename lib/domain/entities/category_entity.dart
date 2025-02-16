import 'package:diary/data/models/category_model.dart';

class CategoryEntity {
  int? id;
  String name;
  String? imageUrl;

  CategoryEntity({
    this.id,
    required this.name,
    this.imageUrl,
  });

  CategoryModel toModel() {
    return CategoryModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}
