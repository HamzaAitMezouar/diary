// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicament_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicamentModelAdapter extends TypeAdapter<MedicamentModel> {
  @override
  final int typeId = 3;

  @override
  MedicamentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicamentModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      presentation: fields[2] as String?,
      manufacturer: fields[3] as String?,
      composition: (fields[4] as List).cast<String>(),
      status: fields[5] as String?,
      ppv: fields[6] as double,
      hospitalPrice: fields[7] as double?,
      table: fields[8] as bool,
      productNature: fields[9] as String?,
      imageUrl: fields[10] as String?,
      category: fields[11] as CategoryModel,
      selectedQuantiy: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MedicamentModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.presentation)
      ..writeByte(3)
      ..write(obj.manufacturer)
      ..writeByte(4)
      ..write(obj.composition)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.ppv)
      ..writeByte(7)
      ..write(obj.hospitalPrice)
      ..writeByte(8)
      ..write(obj.table)
      ..writeByte(9)
      ..write(obj.productNature)
      ..writeByte(10)
      ..write(obj.imageUrl)
      ..writeByte(11)
      ..write(obj.category)
      ..writeByte(12)
      ..write(obj.selectedQuantiy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicamentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
