import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/home.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/screens/collect_info_recommend/form_res_noty.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class SuggestionSetting extends StatefulWidget {
  const SuggestionSetting({super.key});

  @override
  State<SuggestionSetting> createState() => _SuggestionSettingState();
}

class _SuggestionSettingState extends State<SuggestionSetting> {
  final List<DropdownItem<String>> gender = [
    DropdownItem(label: 'Male', value: 'Male'),
    DropdownItem(label: 'Female', value: 'Female'),
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

  final _formKey = GlobalKey<FormState>();
  MultiSelectController<String> controllerGender = MultiSelectController();
  final MultiSelectController<String> controllerWorkingTime =
      MultiSelectController();
  final MultiSelectController<int> controllerCategory = MultiSelectController();
  final MultiSelectController<String> controllerLocation =
      MultiSelectController();
  final MultiSelectController<String> controllerExperience =
      MultiSelectController();
  final TextEditingController _desiredJobController = TextEditingController();

  @override
  void initState() {
    final applicantProvider = context.read<ApplicantProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _desiredJobController.text = applicantProvider.applicant.desiredPosition!;
      controllerGender.setItems(gender);
      controllerGender.selectWhere(
          (item) => item.value == '${applicantProvider.applicant.gender}');
      controllerWorkingTime.setItems(workingTime);
      controllerWorkingTime.selectWhere(
          (item) => item.value == '${applicantProvider.applicant.workingTime}');
      controllerCategory.setItems(categoryJobs);
      controllerCategory.selectWhere(
          (item) => item.value == applicantProvider.applicant.field!.id);
      controllerLocation.setItems(location);
      controllerLocation.selectWhere((item) =>
          item.value == '${applicantProvider.applicant.desiredLocation}');
      controllerExperience.setItems(experience);
      controllerExperience.selectWhere((item) =>
          item.value == '${applicantProvider.applicant.workExperience}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 1.3,
        color: Color.fromARGB(255, 73, 73, 73),
      ),
    );

    final applicantProvider = context.read<ApplicantProvider>();

    String? selectedGender;
    String? selectedWorkingTime;
    int? selectedProfessional;
    String? selectedWorkLocation;
    String? selectedExperience;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Setting job suggestions',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Gender"),
                      const SizedBox(height: 6),
                      MultiDropdown<String>(
                        controller: controllerGender,
                        items: gender,
                        searchEnabled: false,
                        singleSelect: true,
                        chipDecoration: const ChipDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
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
                          selectedGender = selected.first;
                          debugPrint('Selected: $selectedGender');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
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
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
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
                          selectedWorkingTime = selected.first;
                          debugPrint(' $selectedWorkingTime');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
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
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
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
                          selectedProfessional = selected.first;
                          debugPrint('Selected: $selectedProfessional');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 16),

                      // Email
                      const Text("Desired job"),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _desiredJobController,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please fill this field';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 13, horizontal: 8),
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
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
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
                          selectedWorkLocation = selected.first;
                          debugPrint('Selected: $selected');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
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
                                top: BorderSide(
                                    width: 1, color: Colors.redAccent))),
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
                          selectedExperience = selected.first;
                          debugPrint('Selected: $selected');
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one item';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 18), // để tránh đè nút
                    ],
                  ),
                ),
              ),
            ),

            // const Spacer(),

            // Buttons
            // SafeArea(
            // child:
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //nếu mà validate thì gửi dữ liệu lên cho backend đã, sau đó chuyển màn hìnhhình
                  bool result = await applicantProvider.updateUser(
                      applicantProvider.applicant.id!,
                      "",
                      "",
                      "",
                      "",
                      selectedGender,
                      selectedWorkingTime,
                      selectedProfessional,
                      _desiredJobController.text,
                      selectedWorkLocation,
                      selectedExperience);
                  result
                      ? QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Change infomation successfully!',
                          // autoCloseDuration: const Duration(seconds: 3),
                          showConfirmBtn: true,
                          onConfirmBtnTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          })
                      : Fluttertoast.showToast(msg: "An error occurred");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Center(
                child: Text(
                  "Change",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class SuggestionSetting extends StatelessWidget {
//   SuggestionSetting({super.key});
  

//   @override
  
// }
