import 'package:intl/intl.dart';

String formatSalary(int? salary) {
  if (salary == null) return '';

  // Làm tròn xuống đến bội số của 1,000,000
  int roundedSalary = (salary ~/ 1000000) * 1000000;

  // Chuyển thành chuỗi có dấu chấm ngăn cách
  String salaryStr = roundedSalary.toString();
  List<String> parts = [];
  while (salaryStr.length > 3) {
    parts.insert(0, salaryStr.substring(salaryStr.length - 3));
    salaryStr = salaryStr.substring(0, salaryStr.length - 3);
  }
  parts.insert(0, salaryStr);

  return parts.join('.');
}

String formatRequirement(String requirement) {
  return requirement
      .replaceAll(RegExp(r"[\r\n]+"), "\n") // Chuẩn hóa xuống dòng
      .replaceAllMapped(RegExp(r"[●\•\+\*]"), (match) => "\n•")
      .replaceAll(RegExp(r"\n{2,}"), "\n") // Xóa dòng trống thừa
      .trim();
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String formatText(String title, int character) {
  // Viết hoa chữ cái đầu mỗi từ
  String capitalizedTitle = title
      .split(' ')
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '')
      .join(' ');
  // Giới hạn 15 ký tự, thêm "..." nếu quá dài
  return capitalizedTitle.length > character
      ? "${capitalizedTitle.substring(0, character)}..."
      : capitalizedTitle;
}

String formatLocation(String location) {
  return location.contains(',')
      ? location
          .split(',')[0]
          .trim() // Lấy phần trước dấu ',' và loại bỏ khoảng trắng
      : location.trim(); // Nếu không có dấu ',', giữ nguyên
}

String convertDate(String rawDate) {
  DateTime date = DateTime.parse(rawDate);
  return DateFormat('dd/MM/yyyy HH:mm').format(date);
}
