// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pasada.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasadaAdapter extends TypeAdapter<Pasada> {
  @override
  final int typeId = 1;

  @override
  Pasada read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pasada(
      fields[0] as double,
      fields[1] as DateTime,
      fields[2] as bool,
      fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Pasada obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.saldoRestante)
      ..writeByte(1)
      ..write(obj.fechaPasada)
      ..writeByte(2)
      ..write(obj.recarga)
      ..writeByte(3)
      ..write(obj.valorPasada);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasadaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
