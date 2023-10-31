// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peajeregistro.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeajeRegistroAdapter extends TypeAdapter<PeajeRegistro> {
  @override
  final int typeId = 2;

  @override
  PeajeRegistro read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeajeRegistro(
      fields[0] as Peaje,
      fields[1] as DateTime,
      fields[2] as double,
      fields[3] as double,
      fields[4] as double,
      fields[5] as double,
      (fields[6] as List).cast<Pasada>(),
    );
  }

  @override
  void write(BinaryWriter writer, PeajeRegistro obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.peaje)
      ..writeByte(1)
      ..write(obj.fechaCreacion)
      ..writeByte(2)
      ..write(obj.saldoInicial)
      ..writeByte(3)
      ..write(obj.recargas)
      ..writeByte(4)
      ..write(obj.pasadas)
      ..writeByte(5)
      ..write(obj.saldo)
      ..writeByte(6)
      ..write(obj.listaPasadas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeajeRegistroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
