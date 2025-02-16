import '../../../../domain/entities/category_entity.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryLaoding extends CategoryState {
  const CategoryLaoding();
}

class CategoryError extends CategoryState {
  final String errorMessage;
  const CategoryError(this.errorMessage);
}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;
  const CategoryLoaded(this.categories);
}
