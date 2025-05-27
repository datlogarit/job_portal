import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class Country {
  final String name;
  final int id;

  Country({required this.name, required this.id});

  @override
  String toString() => name;
}

class PersonalDetailsForm extends StatelessWidget {
  PersonalDetailsForm({super.key});
  final MultiSelectController<Country> controller = MultiSelectController();
  final MultiSelectController<String> controllerGender =
      MultiSelectController();
  final MultiSelectController<String> controllerWorkingTime =
      MultiSelectController();
  final MultiSelectController<int> controllerCategory = MultiSelectController();
  final MultiSelectController<String> controllerLocation =
      MultiSelectController();
  final MultiSelectController<String> controllerExperience =
      MultiSelectController();

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      // gapPadding: 0,
      borderRadius: BorderRadius.circular(12),
      borderSide:
          const BorderSide(width: 1.3, color: Color.fromARGB(255, 73, 73, 73)),
    );

    final List<DropdownItem<Country>> countries = [
      DropdownItem(label: 'Vietnam', value: Country(name: 'Vietnam', id: 1)),
      DropdownItem(label: 'USA', value: Country(name: 'USA', id: 2)),
      DropdownItem(label: 'UK', value: Country(name: 'UK', id: 3)),
      DropdownItem(label: 'Japan', value: Country(name: 'Japan', id: 4)),
      DropdownItem(label: 'France', value: Country(name: 'France', id: 5)),
    ];
    final List<DropdownItem<int>> categoryJobs = [
      DropdownItem(label: 'Kế toán, kiểm toán', value: 1),
      DropdownItem(label: 'Ngân hàng, dịch vụ tài chính', value: 2),
      DropdownItem(label: 'Bán lẻ, tiêu dùng', value: 24),
      DropdownItem(label: 'Bảo hiểm', value: 26),
      DropdownItem(label: 'Bất động sản', value: 12),
      DropdownItem(label: 'Ceo & general management', value: 14),
      DropdownItem(label: 'Chính phủ/Phi lợi nhuận', value: 31),
      DropdownItem(label: 'Công nghệ thông tin/viễn thông', value: 13),
      DropdownItem(label: 'Cung cấp nhân lực', value: 29),
      DropdownItem(label: 'Dệt may/Da giày', value: 17),
      DropdownItem(label: 'Dịch vụ ăn uống', value: 19),
      DropdownItem(label: 'Dịch vụ khách hàng', value: 15),
      DropdownItem(label: 'Dược', value: 28),
      DropdownItem(label: 'Giáo dục', value: 9),
      DropdownItem(label: 'Hành chính văn phòng', value: 3),
      DropdownItem(label: 'Hậu cần/Xuất nhập khẩu/Kho bãi', value: 10),
      DropdownItem(label: 'Khoa học & kỹ thuật', value: 6),
      DropdownItem(label: 'Kiến trúc/xây dựng', value: 8),
      DropdownItem(label: 'Kinh doanh', value: 11),
      DropdownItem(label: 'Kỹ thuật', value: 20),
      DropdownItem(label: 'Nghệ thuật, Truyền thông/in ấn/xuất bản', value: 30),
      DropdownItem(label: 'Nhà hàng - khách sạn/du lịch', value: 16),
      DropdownItem(label: 'Nhân sự/tuyển dụng', value: 7),
      DropdownItem(label: 'Nông/lâm/ngư nghiệp', value: 22),
      DropdownItem(label: 'Pháp lý', value: 18),
      DropdownItem(label: 'Sản xuất', value: 4),
      DropdownItem(label: 'Thiết kế', value: 23),
      DropdownItem(label: 'Tiếp thị, Quảng cáo/truyền thông', value: 5),
      DropdownItem(label: 'Vận tải', value: 27),
      DropdownItem(label: 'Y tế/chăm sóc sức khoẻ', value: 25),
      DropdownItem(label: 'Khác', value: 21),
    ];
    final List<DropdownItem<String>> gender = [
      DropdownItem(label: 'Male', value: 'Male'),
      DropdownItem(label: 'Female', value: 'Female'),
    ];
    final List<DropdownItem<String>> workingTime = [
      DropdownItem(label: 'Part-time', value: 'Part-time'),
      DropdownItem(label: 'Full-time', value: 'Full-time'),
      DropdownItem(label: 'Remote', value: 'Remote'),
      DropdownItem(label: 'Hybrid', value: 'Hybrid'),
      DropdownItem(label: 'Other', value: 'Other'),
    ];
    final List<DropdownItem<String>> location = [
      DropdownItem(label: 'Hà Nội', value: 'Hà Nội'),
      DropdownItem(label: 'Tp. Hồ Chí Minh', value: 'Hồ Chí Minh'),
      DropdownItem(label: 'Đà Nẵng', value: 'Đà Nẵng'),
      DropdownItem(label: 'Thái Nguyên', value: 'Thái Nguyên'),
      DropdownItem(label: 'Bắc Ninh', value: 'Bắc Ninh'),
      DropdownItem(label: 'Hải Phòng', value: 'Hải Phòng'),
      DropdownItem(label: 'Quảng Ninh', value: 'Quảng Ninh'),
      DropdownItem(label: 'Nam Định', value: 'Nam Định'),
      DropdownItem(label: 'Nghệ An', value: 'Nghệ An'),
      DropdownItem(label: 'Thanh Hóa', value: 'Thanh Hóa'),
      DropdownItem(label: 'Bình Dương', value: 'Bình Dương'),
    ];
    final List<DropdownItem<String>> experience = [
      DropdownItem(label: 'Chưa có kinh nghiệm', value: 'Chưa có kinh nghiệm'),
      DropdownItem(label: 'Dưới 1 năm', value: 'Dưới 1 năm'),
      DropdownItem(label: '1 năm', value: '1 năm'),
      DropdownItem(label: '2 năm', value: '2 năm'),
      DropdownItem(label: '3 năm', value: '3 năm'),
      DropdownItem(label: '4 năm', value: '4 năm'),
      DropdownItem(label: '5 năm', value: '5 năm'),
      DropdownItem(label: 'Trên 5 năm', value: 'Trên 5 năm'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Job suggestions')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Name
            const Text("Gender"),
            const SizedBox(height: 6),
            MultiDropdown<String>(
              controller: controllerGender,
              items: gender,
              searchEnabled: false,
              singleSelect: true,
              chipDecoration: const ChipDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.redAccent))),
              fieldDecoration: FieldDecoration(
                hintText: 'Select your gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dropdownDecoration: const DropdownDecoration(
                header: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select your gender',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onSelectionChange: (selected) {
                debugPrint('Selected: $selected');
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select at least one item';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Last Name
            const Text("Working time"),
            const SizedBox(height: 6),
            MultiDropdown<String>(
              controller: controllerWorkingTime,
              items: workingTime,
              searchEnabled: false,
              singleSelect: true,
              chipDecoration: const ChipDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.redAccent))),
              fieldDecoration: FieldDecoration(
                hintText: 'Select the working-time',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dropdownDecoration: const DropdownDecoration(
                header: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select the working-time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onSelectionChange: (selected) {
                debugPrint('Selected: $selected');
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select at least one item';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            const Text("Field/Professional"),
            const SizedBox(height: 6),
            MultiDropdown<int>(
              controller: controllerCategory,
              items: categoryJobs,
              searchEnabled: true,
              singleSelect: true,
              chipDecoration: const ChipDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.redAccent))),
              fieldDecoration: FieldDecoration(
                hintText: 'Select the category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dropdownDecoration: const DropdownDecoration(
                header: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select the category',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onSelectionChange: (selected) {
                debugPrint('Selected: $selected');
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select at least one item';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email
            const Text("Desired job"),
            const SizedBox(height: 6),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
              ),
            ),

            const SizedBox(height: 16),

            // Mobile Number
            const Text("Work location"),
            const SizedBox(height: 6),
            MultiDropdown<String>(
              controller: controllerLocation,
              items: location,
              searchEnabled: true,
              singleSelect: true,
              chipDecoration: const ChipDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.redAccent))),
              fieldDecoration: FieldDecoration(
                hintText: 'Select the work location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dropdownDecoration: const DropdownDecoration(
                header: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select the work location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onSelectionChange: (selected) {
                debugPrint('Selected: $selected');
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select at least one item';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Nationality
            const Text("Experience"),
            const SizedBox(height: 6),
            MultiDropdown<String>(
              controller: controllerExperience,
              items: experience,
              searchEnabled: false,
              singleSelect: true,
              chipDecoration: const ChipDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.redAccent))),
              fieldDecoration: FieldDecoration(
                hintText: 'Select your experience',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dropdownDecoration: const DropdownDecoration(
                header: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select your experience',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onSelectionChange: (selected) {
                debugPrint('Selected: $selected');
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select at least one item';
                }
                return null;
              },
            ),

            const Spacer(),

            // Buttons
            Row(
              children: [
                // const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
