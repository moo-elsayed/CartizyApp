// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserResponseEntityAdapter extends TypeAdapter<UserResponseEntity> {
  @override
  final int typeId = 2;

  @override
  UserResponseEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserResponseEntity(
      id: fields[0] as int,
      email: fields[1] as String,
      password: fields[2] as String,
      name: fields[3] as String,
      role: fields[4] as String,
      avatar: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserResponseEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserResponseEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
