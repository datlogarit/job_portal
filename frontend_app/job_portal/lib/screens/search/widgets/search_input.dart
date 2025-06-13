import 'package:flutter/material.dart';
import 'package:job_portal/providers/category_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:provider/provider.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(158, 158, 158,
                        .8), // Viền khi TextField không được chọn
                    width: .3,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(
                        158, 158, 158, 1), // Viền khi TextField được chọn
                    width: .6,
                  ),
                ),
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                prefixIcon: Icon(
                  Icons.search,
                  size: 28,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              onSubmitted: (value) async {
                if (value == "" || value.isEmpty) {
                  return;
                }
                await jobProvider.searchJob(value);
                context
                    .read<CategoryProvider>()
                    .setNameCategoryChoose('Tất cả');
                context.read<CategoryProvider>().setSelectedItem(0);
              },
            ),
          ),
          // SizedBox(
          //   width: 10,
          // ),
          // Container(
          //   height: 42,
          //   width: 42,
          //   padding: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(16),
          //       color: Color.fromRGBO(254, 212, 8, .9)),
          //   child: GestureDetector(
          //     onTap: () {
          //       showModalBottomSheet(
          //           shape: RoundedRectangleBorder(),
          //           context: context,
          //           builder: (context) => SizedBox(
          //                 height: 350,
          //                 child: Padding(
          //                   padding:
          //                       const EdgeInsets.symmetric(horizontal: 13.0),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Center(
          //                         child: Container(
          //                           width: 60,
          //                           height: 4,
          //                           margin: EdgeInsets.only(top: 20),
          //                           decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(8),
          //                               color: const Color.fromRGBO(
          //                                   158, 158, 158, .4)),
          //                         ),
          //                       ),
          //                       SizedBox(
          //                         height: 15,
          //                       ),
          //                       Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Text(
          //                             "Lọc nâng cao",
          //                             style: TextStyle(
          //                                 color: Colors.black,
          //                                 fontSize: 20,
          //                                 fontWeight: FontWeight.bold),
          //                           ),
          //                           GestureDetector(
          //                             child: Icon(Icons.close_sharp),
          //                             onTap: () {
          //                               Navigator.pop(context);
          //                             },
          //                           )
          //                         ],
          //                       ),
          //                       SizedBox(
          //                         height: 20,
          //                       ),
          //                       Text(
          //                         "Location",
          //                         style: TextStyle(
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.w300),
          //                       ),
          //                       SizedBox(
          //                         height: 8,
          //                       ),
          //                       DropdownButton<String>(
          //                         // value: selectedValue,
          //                         hint: Text("Chọn category"),
          //                         items: items.map((String item) {
          //                           return DropdownMenuItem<String>(
          //                             value: item,
          //                             child: Text(item),
          //                           );
          //                         }).toList(),
          //                         onChanged: (String? newValue) {
          //                           // setState(() {
          //                           //   selectedValue = newValue;
          //                           // });
          //                         },
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ));
          //     },
          //     child: Image.asset(
          //       "assets/images/filter.png",
          //       color: Colors.white,
          //       // width: 1,
          //     ),
          //   ),
          // ),
          // Row()
        ],
      ),
    );
  }
}
