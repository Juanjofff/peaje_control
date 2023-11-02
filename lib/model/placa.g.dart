// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placa.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlacaAdapter extends TypeAdapter<Placa> {
  @override
  final int typeId = 3;

  @override
  Placa read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Placa(
      fields[0] as String,
      (fields[1] as List).cast<PeajeRegistro>(),
    );
  }

  @override
  void write(BinaryWriter writer, Placa obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.placa)
      ..writeByte(1)
      ..write(obj.peajes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlacaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
