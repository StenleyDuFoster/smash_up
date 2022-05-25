import '../../domain/entity/set_enum.dart';

class DlsDto {
  String dlsName;
  SetEnum dlsType;
  bool isSelected;

  DlsDto(
      {required this.dlsName, required this.dlsType, required this.isSelected});
}