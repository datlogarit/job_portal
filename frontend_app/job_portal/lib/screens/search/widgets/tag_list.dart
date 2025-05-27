import 'package:flutter/material.dart';
import 'package:job_portal/helper.dart';
import 'package:job_portal/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CatagoryListSearch extends StatefulWidget {
  // final ScrollController _scrollController = ScrollController();

  @override
  State<StatefulWidget> createState() {
    return _CatagoryListSearchState();
  }
}

class _CatagoryListSearchState extends State<CatagoryListSearch> {
  @override
  void initState() {
    super.initState();
    getCategory();
  }

  // void _scrollToCenter(int index) {
  //   // Chiều rộng ước lượng mỗi tag
  //   double itemWidth = 80;
  //   double screenWidth = MediaQuery.of(context).size.width;

  //   double offset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

  //   widget._scrollController.animateTo(
  //     offset.clamp(0, widget._scrollController.position.maxScrollExtent),
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  void getCategory() async {
    final categoryProvider = context.read<CategoryProvider>();
    await categoryProvider.getListCategory();
  }

  List<String> listCategory = [
    'Tất cả',
    'công nghệ thông tin/viễn thông',
    'bán lẻ/tiêu dùng',
    'bảo hiểm',
    'bất động sản',
    'ceo & general management',
    'dệt may/da giày',
    'dịch vụ ăn uống',
    'dịch vụ khách hàng',
    'dược',
    'giáo dục',
    'hành chính văn phòng',
    'hậu cần/Xuất nhập khẩu/kho bãi',
    'kế toán/kiểm toán',
    'khác',
    'khoa học & kỹ thuật',
    'kiến trúc/xây dựng',
    'kinh doanh',
    'kỹ thuật',
    'ngân hàng & dịch vụ tài chính',
    'nhà hàng - khách sạn/du lịch',
    'nhân sự/Tuyển dụng',
    'nông/Lâm/Ngư nghiệp',
    'pháp lý',
    'sản xuất',
    'thiết kế'
  ];
  // int slectedItem = 0;
  // final
  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 42,
      child: ListView.separated(
        // controller: widget._scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              categoryProvider.setSelectedItem(index);
              categoryProvider.setIdCateoryChoose(
                  listCategory[categoryProvider.selectedItem]);
            });
            // _scrollToCenter(index);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: .6),
                borderRadius: BorderRadius.circular(20),
                color: categoryProvider.selectedItem == index
                    ? Theme.of(context).primaryColor
                    : Colors.white),
            child: Row(children: [
              Text(
                formatText(
                    // categoryProvider.listCategory[index].name!,
                    listCategory[index],
                    30),
                style: categoryProvider.selectedItem == index
                    ? TextStyle(color: Colors.white, fontSize: 13)
                    : TextStyle(color: Colors.black, fontSize: 13),
              ),
              categoryProvider.selectedItem == index
                  ? Row(children: [
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.close,
                        color: Colors.white,
                      )
                    ])
                  : Container()
            ]),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: 10,
        ),
        itemCount: listCategory.length,
      ),
    );
    // return Text('data');
  }
}
