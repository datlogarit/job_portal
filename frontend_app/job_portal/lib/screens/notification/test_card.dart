import 'package:flutter/material.dart';

class TestCard extends StatefulWidget {
  const TestCard({super.key});

  @override
  State<TestCard> createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  // Dữ liệu mẫu với thêm trường imageUrl
  final List<Map<String, String>> notifications = [
    {
      "title": "Thông báo 1",
      "content": "Đây là nội dung của thông báo số 1.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 2",
      "content": "Nội dung chi tiết của thông báo số 2.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 3",
      "content": "Thông báo này có nội dung dài hơn để kiểm tra.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 4",
      "content": "Một thông báo ngắn gọn khác.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 4",
      "content": "Một thông báo ngắn gọn khác.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 4",
      "content": "Một thông báo ngắn gọn khác.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 4",
      "content": "Một thông báo ngắn gọn khác.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 4",
      "content": "Một thông báo ngắn gọn khác.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 4",
      "content": "Một thông báo ngắn gọn khác.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
    {
      "title": "Thông báo 4",
      "content": "Một thông báo ngắn gọn khác.",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnnFf6DXcgRxe71BOQm1orHpnKjJloo9c2jg&s" // Ảnh mẫu
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close_rounded,
                size: 26,
                color: Colors.black,
              ),
            ),
            const Text(
              "Thông báo",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.download_done_rounded,
                size: 26,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            // color: Color.fromRGBO(254, 212, 8, .3),
            color: Color(0xFFD5EDDB),
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Căn trên cùng
                children: [
                  // Ảnh phía trước
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0), // Bo góc ảnh
                    child: Image.network(
                      notifications[index]["imageUrl"]!,
                      width: 80, // Chiều rộng ảnh
                      height: 80, // Chiều cao ảnh
                      fit: BoxFit.cover, // Căn chỉnh ảnh
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error,
                            size: 80); // Hiển thị khi lỗi
                      },
                    ),
                  ),
                  const SizedBox(width: 16), // Khoảng cách giữa ảnh và nội dung
                  // Nội dung tiêu đề và nội dung
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notifications[index]["title"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notifications[index]["content"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
