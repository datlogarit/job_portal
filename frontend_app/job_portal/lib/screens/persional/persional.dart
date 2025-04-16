import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:job_portal/screens/persional/widget/change_pass.dart';
import 'package:provider/provider.dart';

class PersionalPage extends StatefulWidget {
  const PersionalPage({super.key});

  @override
  State<PersionalPage> createState() => _PersionalPageState();
}

class _PersionalPageState extends State<PersionalPage> {
  TextEditingController? emailController;
  TextEditingController? phoneNumController;
  TextEditingController? nameController;
  TextEditingController? birthDayController;
  TextEditingController defaultController =
      TextEditingController(text: "0000-000-000");

  bool isEditEmail = false;
  bool isEditPhoneNum = false;
  bool isEditName = false;
  bool isEditBirthDay = false;

  @override
  void dispose() {
    nameController!.dispose();
    phoneNumController!.dispose();
    emailController!.dispose();
    birthDayController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final userProvider = context.read<UserProvider>();
    super.initState();
    emailController = TextEditingController(text: userProvider.user.email);
    phoneNumController = TextEditingController(
      text: userProvider.user.phoneNumber == "" ||
              userProvider.user.phoneNumber!.isEmpty
          ? "0000-000-000"
          : userProvider.user.phoneNumber,
    );
    nameController = TextEditingController(text: userProvider.user.name);
    birthDayController = TextEditingController(text: userProvider.user.dob);
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isEdit,
    required VoidCallback onEdit,
    required VoidCallback onDone,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 5),
        Stack(
          children: [
            TextField(
              controller: controller,
              enabled: isEdit,
              onChanged: (value) {
                // setState(() {
                //   controller!.text = value;
                //   print(controller!.text);
                // });
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromRGBO(67, 177, 183, .5)),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromRGBO(158, 158, 158, .3)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromRGBO(67, 177, 183, .5)),
                ),
              ),
            ),
            Positioned(
              right: -2,
              top: -4,
              child: SizedBox(
                width: 45,
                child: ElevatedButton(
                  onPressed: isEdit ? onDone : onEdit,
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                    backgroundColor: const Color.fromRGBO(67, 177, 183, .8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    elevation: 0,
                  ),
                  child: Icon(
                    isEdit ? Icons.done : Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 145,
                          child: Image.asset(
                            "assets/images/background-profile.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: -66,
                          left: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 66,
                            backgroundColor: Colors.white,
                            child: const CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  AssetImage("assets/images/avt_meo.jpg"),
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: -72,
                          right: 135,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 18,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundImage:
                                  AssetImage("assets/images/camera_icon.png"),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Thông tin cá nhân",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 10),
                          buildTextField(
                            label: "Email",
                            controller: emailController!,
                            isEdit: isEditEmail,
                            onEdit: () => setState(() => isEditEmail = true),
                            onDone: () => setState(() {
                              isEditEmail = false;
                            }),
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            label: "Số điện thoại",
                            controller: phoneNumController!,
                            isEdit: isEditPhoneNum,
                            onEdit: () => setState(() => isEditPhoneNum = true),
                            onDone: () async {
                              print(phoneNumController!.text);
                              try {
                                await userProvider.updateUser(
                                  userProvider.user.id!,
                                  null,
                                  null,
                                  phoneNumController!.text,
                                  null,
                                );
                                Fluttertoast.showToast(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    msg: "Sửa thành công",
                                    fontSize: 16,
                                    gravity: ToastGravity.CENTER);
                              } catch (e) {
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.redAccent,
                                    msg: e
                                        .toString()
                                        .replaceAll("Exception:", ""),
                                    fontSize: 16,
                                    gravity: ToastGravity.CENTER);
                              }
                              setState(() => isEditPhoneNum = false);
                            },
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            label: "Họ và tên",
                            controller: nameController!,
                            isEdit: isEditName,
                            onEdit: () => setState(() => isEditName = true),
                            onDone: () async {
                              print(phoneNumController!.text);
                              try {
                                await userProvider.updateUser(
                                  userProvider.user.id!,
                                  nameController!.text,
                                  null,
                                  null,
                                  null,
                                );
                                Fluttertoast.showToast(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    msg: "Sửa thành công",
                                    fontSize: 16,
                                    gravity: ToastGravity.CENTER);
                              } catch (e) {
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.redAccent,
                                    msg: e
                                        .toString()
                                        .replaceAll("Exception:", ""),
                                    fontSize: 16,
                                    gravity: ToastGravity.CENTER);
                              }

                              setState(() => isEditBirthDay = false);
                            },
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                              label: "Ngày sinh",
                              controller: birthDayController!,
                              isEdit: isEditBirthDay,
                              onEdit: () =>
                                  setState(() => isEditBirthDay = true),
                              onDone: () async {
                                print(phoneNumController!.text);
                                try {
                                  await userProvider.updateUser(
                                    userProvider.user.id!,
                                    nameController!.text,
                                    null,
                                    null,
                                    null,
                                  );
                                  Fluttertoast.showToast(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      msg: "Sửa thành công",
                                      fontSize: 16,
                                      gravity: ToastGravity.CENTER);
                                } catch (e) {
                                  Fluttertoast.showToast(
                                      backgroundColor: Colors.redAccent,
                                      msg: e
                                          .toString()
                                          .replaceAll("Exception:", ""),
                                      fontSize: 16,
                                      gravity: ToastGravity.CENTER);
                                }

                                setState(() => isEditBirthDay = false);
                              }),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: .4,
                                    color: Color.fromRGBO(158, 158, 158, .5)),
                                bottom: BorderSide(
                                    width: .4,
                                    color: Color.fromRGBO(158, 158, 158, .5)),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ChangePass()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.lock),
                                      SizedBox(width: 10),
                                      Text(
                                        "Đổi mật khẩu",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 28,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: SizedBox(
                              height: 50,
                              width: 360,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  backgroundColor:
                                      const Color.fromRGBO(217, 217, 217, 1),
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  // TODO: logout logic
                                },
                                child: const Text(
                                  "Đăng xuất",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
