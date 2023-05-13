// utils.dart
import 'package:utmschedular/models/domain/class.dart';
import 'package:utmschedular/models/DTO/classDTO.dart';

class ClassConverter {
  static List<Class> convertFromDTOs(List<ClassDTO> classDTOs) {
    classDTOs.sort((a, b) => a.hari != b.hari ? a.hari.compareTo(b.hari) : a.masa.compareTo(b.masa));
    List<Class> classes = [];
    for (int i = 0; i < classDTOs.length; i++) {
      int startMasa = classDTOs[i].masa;
      int endMasa = startMasa;
      int currentDay = classDTOs[i].hari;
      while (i+1 < classDTOs.length && classDTOs[i+1].hari == currentDay) {
        i++;
        endMasa = classDTOs[i].masa;
      }
      classes.add(Class(
        day: currentDay.toString(),
        timeStart: startMasa.toString(),
        timeEnd: endMasa.toString(),
        location: classDTOs[i].ruang.namaRuang,  
      ));
    }
    return classes;
  }
}
