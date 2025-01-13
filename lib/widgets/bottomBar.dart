import 'package:flutter/material.dart';
import 'package:glamify/chatbot/notification.dart';
import 'package:glamify/views/home_view.dart';
import 'package:glamify/views/profile.dart';
import 'package:glamify/views/shops/shop_view.dart';


class BottomBarStart extends StatefulWidget {
  const BottomBarStart({super.key});

  @override
  State<BottomBarStart> createState() => _BottomBarStartState();
}

class _BottomBarStartState extends State<BottomBarStart> {
  int curentIndex = 0;
  late PageController pageController;
  @override
  void initState() {

    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {

//     //     //


    super.dispose();
    pageController.dispose();
  }

  onPageChange(int page) {
    setState(() {
      curentIndex = page;
    });
  }

  navigationTap(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: curentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: navigationTap,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset("assets/images/homeN.png"),
                label: "",
                activeIcon: Image.asset(
                  "assets/images/home.png",
                  color: const Color(0xff156778),
                )),
            // BottomNavigationBarItem(
            //     icon: Image.asset("assets/images/BtmW2.png"),
            //     label: "",
            //     activeIcon: Image.asset(
            //       "assets/images/BtmW2.png",
            //       color: Color(0xff156778),
            //     )),
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  "assets/images/BtmShop.png",
                  color: const Color(0xff156778),
                ),
                icon: Image.asset("assets/images/BtmShop.png"),
                label: ""),
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  "assets/images/BtmInbox.png",
                  color: const Color(0xff156778),
                ),
                icon: Image.asset("assets/images/BtmInbox.png"),
                label: ""),
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  "assets/images/BtmProfil.png",
                  color: const Color(0xff156778),
                ),
                icon: Image.asset("assets/images/BtmProfil.png"),
                label: ""),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChange,
        children: const [
          HomeView(),
          // HomeViewGirl(),
          // BookServiceView(),
          ShopView(),
          // ShopDetailView(),
          NotificationView(),
          Profile()
        ],
      ),
    );
  }
}


