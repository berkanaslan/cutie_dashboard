import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_credit_card_ui/flutter_custom_credit_card_ui.dart';

final Color bgColor = Color(0xFFFFFFFF);
final Color shadowColor = Color(0xFFF5F7FA);
final Color blackColor = Color(0xFF0A0A0F);
final Color grayColor = Color(0xFFA3B1C5);
final Color secondColor = Color(0xFF6B6E80);
final TextStyle textStyle =
    TextStyle(fontFamily: "Poppins", color: Color(0xFF0A0A0F), fontSize: 16);
final String profilePhoto =
    "https://berkanaslan.com/wp-content/uploads/2020/04/baslan.jpg";

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  double screenHeight, screenWidth;
  bool isMenuOpen = false;
  final _pageController = PageController();
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<Offset> _menuOffsetAnimation;
  final Duration _duration = Duration(milliseconds: 250);
  List<Map<String, dynamic>> cardList = [
    {
      'cardNumber': '5571123456789000',
      'cardHolder': 'Berkan ASLAN',
      'month': 10,
      'year': 2022
    },
    {
      'cardNumber': '4698102030405060',
      'cardHolder': 'Berkan ASLAN',
      'month': 06,
      'year': 2025
    },
    {
      'cardNumber': '5351979852364165',
      'cardHolder': 'Berkan ASLAN',
      'month': 12,
      'year': 2020
    }
  ];
  double curentIndicatorValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.8).animate(_controller);
    _menuOffsetAnimation = Tween(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildMenu(context),
            _buildDashboard(context),
          ],
        ),
      ),
    );
  }

  _buildMenu(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment(0, 0.2),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildMenuUserSection(),
                FlatButton.icon(
                  onPressed: () {
                    animateMenu();
                  },
                  icon: Icon(Icons.account_balance_wallet, color: blackColor),
                  label: Text("Dashboard", style: textStyle),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.mail, color: secondColor),
                  label: Text("Messages", style: textStyle.copyWith(color: secondColor)),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.assignment, color: secondColor),
                  label: Text("Utility Bills",
                      style: textStyle.copyWith(color: secondColor)),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.compare_arrows, color: secondColor),
                  label: Text("Fund Transfer",
                      style: textStyle.copyWith(color: secondColor)),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.account_balance, color: secondColor),
                  label: Text("Branches", style: textStyle.copyWith(color: secondColor)),
                ),
                SizedBox(height: 80),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward, color: secondColor),
                  label: Text("Log out", style: textStyle.copyWith(color: secondColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   _buildMenuUserSection() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: null),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage("$profilePhoto"),
      ),
      accountName: Text(
        "Berkan ASLAN",
        style: textStyle,
      ),
      accountEmail: Text(
        "Istanbul, TR",
        style: textStyle.copyWith(color: secondColor, fontSize: 14),
      ),
    );
  }

  _buildDashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      left: isMenuOpen ? 0.4 * screenWidth : 0,
      right: isMenuOpen ? -0.4 * screenWidth : 0,
      top: 0,
      bottom: 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: isMenuOpen ? BorderRadius.circular(20) : null,
          elevation: 8.0,
          color: bgColor,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Column(
                children: <Widget>[
                  _buildHeaderRow(),
                  _buildPageView(),
                  SizedBox(height: 8),
                  DotsIndicator(
                    onTap: (page) {
                      setState(() {
                        _pageController.animateToPage(
                          page.toInt(),
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    dotsCount: cardList.length,
                    position: curentIndicatorValue,
                    decorator: DotsDecorator(
                      color: grayColor, // Inactive color
                      activeColor: blackColor,
                    ),
                  ),
                  _buildTransactionsHeader(),
                  _buildTransactionDateRow("Today"),
                  _buildTransactionItem(
                      "assets/imgs/starbucks.png", "Coffee", "Starbucks", 14, true),
                  _buildTransactionItem(
                      "assets/imgs/ads.png", "Ads", "Google", 280, false),
                  _buildTransactionDateRow("Yesterday"),
                  _buildTransactionItem(
                      "assets/imgs/market.png", "Market", "Carrefour", 332, true),
                  _buildTransactionItem(
                      "assets/imgs/apple.png", "Airpods 2th Gen", "Apple", 980, true),
                  _buildTransactionItem(
                      "assets/imgs/starbucks.png", "Coffee", "Starbucks", 8.50, true),
                  _buildTransactionItem(
                      "assets/imgs/ads.png", "Ads", "Google", 800, false),
                  _buildTransactionDateRow("Wednesday"),
                  _buildTransactionItem(
                      "assets/imgs/apple.png", "Macbook Air 19", "Apple", 7980, true),
                  _buildTransactionItem("assets/imgs/ads.png", "Ads", "Google", 32, false),
                  _buildTransactionItem(
                      "assets/imgs/starbucks.png", "Coffee", "Starbucks", 18.20, true),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Center(
                      child: FlatButton(
                        splashColor: shadowColor,
                        highlightColor: shadowColor,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          debugPrint("Load more button tapped");
                        },
                        child: Text(
                          "Load more",
                          style: textStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void animateMenu() {
    setState(() {
      if (isMenuOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isMenuOpen = !isMenuOpen;
    });
  }

  _buildHeaderRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: Icon(
            Icons.menu,
            color: blackColor,
            size: 32,
          ),
          onTap: () {
            animateMenu();
          },
        ),
        Image.asset(
          "assets/imgs/logo.png",
          height: 32,
          fit: BoxFit.cover,
        ),
        //Text("My Cards", style: textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
        InkWell(
            child: Icon(
              Icons.add,
              color: blackColor,
              size: 32,
            ),
            onTap: () {
              debugPrint("Header add button tapped");
            }),
      ],
    );
  }

   _buildPageView() {
    return Container(
      height: 200,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: cardList.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return _buildCreditCard(
              cardList[index]['cardNumber'],
              cardList[index]['cardHolder'],
              cardList[index]['month'],
              cardList[index]['year']);
        },
        onPageChanged: (page) {
          setState(() {
            curentIndicatorValue = page.toDouble();
          });
        },
      ),
    );
  }

   _buildCreditCard(String _cardNumber, String _cardHolder, int _month, int _year) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: CustomCreditCard(
            isGradient: true,
            cardNumber: _cardNumber,
            cardHolder: _cardHolder,
            month: _month,
            year: _year,
          ),
        ),
      ),
    );
  }

   _buildTransactionsHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Transactions",
            style: textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              debugPrint("Transaction filter icon tapped");
            },
            child: Icon(
              Icons.compare_arrows,
              size: 24,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }

   _buildTransactionDateRow(String date) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          child: Text(
            date,
            style: textStyle.copyWith(
              fontSize: 16,
              color: secondColor,
            ),
          ),
        ),
      ],
    );
  }

   _buildTransactionItem(String imgUrl, title, subtitle, double price, bool spending) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
              highlightColor: Colors.transparent, splashColor: Colors.transparent),
          child: ListTile(
              onTap: () {
                debugPrint("Transaction items tapped");
              },
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(imgUrl),
              ),
              title: Text(title,
                  style: textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                subtitle,
                style: textStyle.copyWith(color: secondColor, fontSize: 14),
              ),
              trailing: spending
                  ? Text("-$price ₺",
                      style: textStyle.copyWith(
                          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold))
                  : Text("+$price ₺",
                      style: textStyle.copyWith(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }
}
