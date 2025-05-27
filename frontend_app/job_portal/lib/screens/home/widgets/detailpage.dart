import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/helper.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/application_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:job_portal/repositories/interaction_repository.dart';
import 'package:job_portal/screens/application_page/application_page.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/report/report.dart';
import 'package:job_portal/widgets/save_icon.dart';
import 'package:provider/provider.dart';
import 'package:step_tracker/step_tracker.dart';

class JobDetailPage extends StatefulWidget {
  final interactionRepo = InteractionRepository();

  final Job job;
  JobDetailPage({super.key, required this.job});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  Widget statusApply = Container();
  Widget applyButton() {
    return SizedBox(
      width: 340,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor:
                    Theme.of(context).primaryColor, //Color(0xFFEA4C59)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApplicationPage(
                      job: widget.job,
                    ),
                  ),
                );
                if (result == 'Pending') {
                  setState(() {
                    statusApply = applied();
                  });
                }
              },
              child: const Text(
                "Apply Now",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SaveIcon(job: widget.job),
          )
        ],
      ),
    );
  }

  Widget applied() {
    return Transform.translate(
      offset: Offset(0, 22),
      child: StepTracker(
        dotSize: 0,
        circleIconSize: 20,
        showIcon: false,
        selectedColor: Colors.green,
        unSelectedColor: Colors.red,
        stepTrackerType: StepTrackerType.indexedHorizontal,
        pipeSize: 60,
        steps: [
          Steps(
            title: "Applied",
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            state: TrackerState.complete,
          ),
          // Steps(title: "Progress", state: TrackerState.complete),
          Steps(
            title: "Result",
            state: TrackerState.none,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget accepted() {
    return Transform.translate(
      offset: Offset(0, 22),
      child: StepTracker(
        dotSize: 0,
        circleIconSize: 20,
        showIcon: false,
        selectedColor: Colors.green,
        unSelectedColor: Colors.red,
        stepTrackerType: StepTrackerType.indexedHorizontal,
        pipeSize: 60,
        steps: [
          Steps(
            title: "Applied",
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            state: TrackerState.complete,
          ),
          // Steps(title: "Progress", state: TrackerState.complete),
          Steps(
            title: "Accepted",
            state: TrackerState.complete,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget rejected() {
    return Transform.translate(
      offset: Offset(0, 22),
      child: StepTracker(
        dotSize: 0,
        circleIconSize: 20,
        showIcon: false,
        selectedColor: Colors.green,
        unSelectedColor: Colors.red,
        stepTrackerType: StepTrackerType.indexedHorizontal,
        pipeSize: 60,
        steps: [
          Steps(
            title: "Applied",
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            state: TrackerState.complete,
          ),
          // Steps(title: "Progress", state: TrackerState.complete),
          Steps(
            title: "Rejected",
            state: TrackerState.disabled,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<JobProvider>(context, listen: false);
      provider.getSameJobs(widget.job.id!);
      getApplication();
    });
  }

  void getApplication() async {
    try {
      final userProvider = context.read<UserProvider>();
      final applicationProvider = context.read<ApplicationProvider>();
      await applicationProvider.fetchApplication(
          userProvider.user.id!, widget.job.id!);
      // print("ui: ${applicationProvider.application.statusApply}");
      setState(() {
        if (applicationProvider.application.statusApply == null) {
          statusApply = applyButton();
        } else if (applicationProvider.application.statusApply == 'Pending') {
          statusApply = applied();
        } else if (applicationProvider.application.statusApply == 'Approved') {
          statusApply = accepted();
        } else if (applicationProvider.application.statusApply == 'Rejected') {
          statusApply = rejected();
        }
      });
    } catch (e) {
      setState(() {
        statusApply = applyButton();
      });
    }
  }

  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();
    final userProvier = context.watch<UserProvider>();
    // final sameJobs = jobProvider.sameJobs;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.report,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Report(
                                    job: widget.job,
                                  )));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      // backgroundColor: Colors.grey[200],
                      // radius: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      height: 60,
                      width: 60,
                      // color: ,

                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.job.postedBy!.companyId!.urlAvt!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/vietnamwork_avt.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        widget.job.title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      "Location: ${widget.job.workLocation!}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Chip(
                          label: Text("Time: ${widget.job.workingTime!}"),
                          backgroundColor: Color(0xFFE8ECF4),
                        ),
                      ),
                      SizedBox(width: 12),
                      Center(
                        child: Chip(
                          label: Text("Gender: ${widget.job.gender}"),
                          backgroundColor: Color(0xFFE8ECF4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Upto: ${formatSalary(widget.job.maxSalary)} VND",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "Date: ${widget.job.expDate}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.job.description!,
                          style: TextStyle(height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Responsibilities",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formatRequirement(widget.job.requirement!),
                          style: TextStyle(height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Benefit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          capitalizeFirstLetter(widget.job.benefit!),
                          style: TextStyle(height: 1.5),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          height: .8,
                          width: double.maxFinite,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          "Similar job",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 180,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => JobDetailPage(
                                      job: jobProvider.sameJobs[index],
                                    ),
                                  ),
                                );
                                await widget.interactionRepo.updateRead(
                                    userProvier.user.id!,
                                    jobProvider.sameJobs[index].id!);
                                // result
                                //     ? Fluttertoast.showToast(msg: "thanh cong")
                                //     : Fluttertoast.showToast(msg: "that bai");
                              },
                              child: JobCard(
                                job: jobProvider.sameJobs[index],
                                timeJob: false,
                                salary: true,
                                companyNumChar: 32,
                                titleNumChar: 50,
                              ),
                            ),
                            separatorBuilder: (_, index) => SizedBox(width: 20),
                            itemCount: jobProvider.sameJobs.length,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: const Color.fromRGBO(158, 158, 158, .5),
                    //     spreadRadius: 1,
                    //     blurRadius: 7,
                    //     offset: const Offset(0, -2), // Đổ bóng xuống dưới
                    //   ),
                    // ],
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 1),
                      child: statusApply,
                    ),
                    // const SizedBox(width: 10),
                    // Container(
                    //   padding: const EdgeInsets.all(12),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     border: Border.all(color: Colors.grey.shade300),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: SaveIcon(job: widget.job),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
