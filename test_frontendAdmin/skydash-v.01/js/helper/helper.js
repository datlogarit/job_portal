export class Helper {
  static formatText(str, maxLength) {
    if (!str) return "";

    // Viết hoa chữ cái đầu tiên
    const capitalized = str.charAt(0).toUpperCase() + str.slice(1);

    // Nếu độ dài nhỏ hơn hoặc bằng maxLength → giữ nguyên
    if (capitalized.length <= maxLength) {
      return capitalized;
    }

    // Nếu vượt quá, cắt và thêm '...'
    return capitalized.slice(0, maxLength - 3) + "...";
  }
  static formatDateTime(dateString) {
    if (!dateString) return "";

    const date = new Date(dateString);

    const day = String(date.getDate()).padStart(2, "0");
    const month = String(date.getMonth() + 1).padStart(2, "0"); // tháng bắt đầu từ 0
    const year = date.getFullYear();

    const hours = String(date.getHours()).padStart(2, "0");
    const minutes = String(date.getMinutes()).padStart(2, "0");

    // Trả về định dạng "dd/mm/yyyy HH:MM"
    return `${day}/${month}/${year} ${hours}:${minutes}`;
  }
}
