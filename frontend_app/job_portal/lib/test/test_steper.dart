import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_portal/screens/start/login/login.dart';
import 'package:job_portal/test/test_form_survey.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          Center(
            child: SvgPicture.asset(
              'assets/images/New idea-bro.svg',
              height: 320,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Provide information',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Text(
              'Please give me a little information about the jobs you are interested in so we can suggest suitable jobs for you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDot(true),
              buildDot(false),
              // buildDot(false),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Màu bóng mờ
                    offset: const Offset(0, 1), // Đổ bóng xuống dưới
                    blurRadius: 2, // Độ mờ của bóng
                  ),
                  BoxShadow(
                    color: Colors.grey, // Màu bóng mờ
                    offset: const Offset(0, -1), // Đổ bóng lên trên
                    blurRadius: 10, // Độ mờ của bóng
                  ),
                ],
              ),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Điều hướng sang trang tiếp theo
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => PersonalDetailsForm()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.cyan : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
