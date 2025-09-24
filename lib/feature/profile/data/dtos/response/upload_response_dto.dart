import '../../../domain/entities/upload_entity.dart';

class UploadResponseDto {
  UploadResponseDto({this.originalName, this.filename, this.location});

  String? originalName;
  String? filename;
  String? location;

  UploadResponseDto.fromJson(Map<String, dynamic> json) {
    originalName = json['originalname'];
    filename = json['filename'];
    location = json['location'];
  }

  UploadEntity toEntity() => UploadEntity(
    location: location ?? '',
  );
}
