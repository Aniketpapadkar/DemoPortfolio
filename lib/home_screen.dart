import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PortfolioHomeScreen extends StatefulWidget {
  const PortfolioHomeScreen({super.key});

  @override
  State<PortfolioHomeScreen> createState() => _PortfolioHomeScreenState();
}

class _PortfolioHomeScreenState extends State<PortfolioHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  // bottom nav index (Portfolio at index 1 by default)
  int bottomIndex = 1;

  // active color
  final Color activeColor = const Color(0xFFDF5532); // #DF5532

  // ----------------- PROJECT LIST FOR FILTERING -----------------
  List<Map<String, String>> allProjects = [
    {"title": "Kemampuan Merangkum Tulisan", "image": "assets/images/image1.jpg"},
    {"title": "Kemampuan Merangkum Tulisan", "image": "assets/images/image2.jpg"},
    {"title": "Kemampuan Merangkum Tulisan", "image": "assets/images/image3.jpg"},
    {"title": "Kemampuan Merangkum Tulisan", "image": "assets/images/image4.jpg"},
    {"title": "Kemampuan Merangkum Tulisan", "image": "assets/images/image1.jpg"},
    {"title": "Kemampuan Merangkum Tulisan", "image": "assets/images/image2.jpg"},
    {"title": "Kemampuan Merangkum Tulisan", "image": "assets/images/image3.jpg"},
    {"title": "Kemampuan Merangkum Tulisan", "image": "assets/images/image4.jpg"},
  ];

  List<Map<String, String>> filteredProjects = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    filteredProjects = List.from(allProjects);
  }

  // ===================== PROJECT CARD =====================
  Widget projectCard(String image) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      height: 130.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.black.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.r),
              bottomLeft: Radius.circular(14.r),
            ),
            child: SizedBox(
              width: 115.w,
              height: double.infinity,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kemampuan Merangkum",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Tulisan",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "BAHASA SUNDA",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Oleh Al-Baiqi Samaan",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 45.h),
            child: Container(
              width: 40.w, 
              height: 35.h, 
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Text(
                "A",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------ PORTFOLIO CONTENT ------------------
  Widget buildPortfolioContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// -------- TAB BAR --------
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: TabBar(
            controller: controller,
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 35.w),
            indicatorColor: activeColor,
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            labelColor: activeColor,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(text: "Project"),
              Tab(text: "Saved"),
              Tab(text: "Shared"),
              Tab(text: "Achievement"),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        /// -------- SEARCH BAR --------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Container(
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        filteredProjects = allProjects
                            .where((p) => p["title"]!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search a project",
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 32.h,
                  width: 32.h,
                  margin: EdgeInsets.only(right: 8.w),
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: 16.sp),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15.h),

        /// -------- CONTENT AREA --------
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                children: [
                  for (var p in filteredProjects) projectCard(p["image"]!)
                ],
              ),
              Container(color: Colors.white),
              Container(color: Colors.white),
              Container(color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ------------------ APPBAR ------------------
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 6.w),
          child: Text(
            "Portfolio",
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: Image.asset(
              "assets/images/Vector1.png",
              height: 22.h,
              color: activeColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Image.asset(
              "assets/images/Vector2.png",
              height: 22.h,
              color: activeColor,
            ),
          ),
        ],
      ),

      // ------------------ BODY ------------------
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: SizedBox(
          key: ValueKey<int>(bottomIndex),
          width: double.infinity,
          height: double.infinity,
          child: (bottomIndex == 1)
              ? buildPortfolioContent()
              : Container(color: Colors.white),
        ),
      ),

      // ------------------ FILTER BUTTON ------------------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: bottomIndex == 1
          ? Padding(
              padding: EdgeInsets.only(bottom: 65.h),
              child: Container(
                height: 45.h,
                width: 120.w,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Center(
                  child: Text(
                    "Filter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          : null,

      // ------------------ BOTTOM NAV ------------------
      bottomNavigationBar: SizedBox(
        height: 60.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => setState(() => bottomIndex = 0),
              child: navItemImage("assets/images/Home.png", "Home", bottomIndex == 0),
            ),
            GestureDetector(
              onTap: () => setState(() => bottomIndex = 1),
              child: navItemImage("assets/images/Portfolia.png", "Portfolio", bottomIndex == 1),
            ),
            GestureDetector(
              onTap: () => setState(() => bottomIndex = 2),
              child: navItemImage("assets/images/Input.png", "Input", bottomIndex == 2),
            ),
            GestureDetector(
              onTap: () => setState(() => bottomIndex = 3),
              child: navItem(Icons.person, "Profile", bottomIndex == 3),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ NAV ITEM ------------------
  Widget navItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: active ? activeColor : Colors.grey,
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: active ? activeColor : Colors.grey,
          ),
        ),
      ],
    );
  }

  // ------------------ NAV ITEM WITH IMAGE ------------------
  Widget navItemImage(String assetPath, String label, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          assetPath,
          width: 24.w,
          height: 24.h,
          color: active ? activeColor : Colors.grey,
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: active ? activeColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}
