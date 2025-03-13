package com.project.jobportal.utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.List;

public class FakeCategoryDataGenerator {
    private static final List<String> CATEGORIES = Arrays.asList(
            "Công nghệ thông tin", "Kinh doanh & Bán hàng", "Marketing & Quảng cáo", "Tài chính & Kế toán",
            "Ngân hàng & Chứng khoán", "Bất động sản", "Sản xuất & Công nghiệp", "Xây dựng & Kiến trúc",
            "Giao thông & Vận tải", "Y tế & Chăm sóc sức khỏe", "Dược phẩm & Công nghệ sinh học",
            "Giáo dục & Đào tạo", "Luật & Pháp lý", "Nhân sự & Tuyển dụng", "Hành chính & Văn phòng",
            "Thiết kế đồ họa & Nghệ thuật", "Truyền thông & Giải trí", "Nhà hàng & Khách sạn", "Du lịch & Lữ hành",
            "Dịch vụ khách hàng", "Công nghệ thực phẩm & Nông nghiệp", "Kỹ thuật & Cơ khí",
            "Viễn thông & Mạng máy tính", "Thời trang & Làm đẹp", "Xuất nhập khẩu & Logistics",
            "Môi trường & Năng lượng tái tạo", "Thể thao & Thể hình", "Công tác xã hội & Phi lợi nhuận",
            "Bảo hiểm", "Điện tử & Tự động hóa"
    );

    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/job_portal";
        String user = "root";
        String password = "";

        String sql = "INSERT INTO categories (name) VALUES (?)";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            for (String category : CATEGORIES) {
                pstmt.setString(1, category);
                pstmt.executeUpdate();
            }

            System.out.println("Chèn dữ liệu thành công!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

