import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_credit_card_ui/flutter_custom_credit_card_ui.dart';

final Color bgColor = Color(0xFFFAFCFD);
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
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<Offset> _menuOffsetAnimation;
  final Duration _duration = Duration(milliseconds: 250);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildMenuUserSection(),
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.account_balance_wallet, color: blackColor),
                label: Text("Dashboard", style: textStyle),
              ),
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.message, color: secondColor),
                label: Text("Messages", style: textStyle.copyWith(color: secondColor)),
              ),
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.assignment, color: secondColor),
                label:
                    Text("Utility Bills", style: textStyle.copyWith(color: secondColor)),
              ),
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.compare_arrows, color: secondColor),
                label:
                    Text("Fund Transfer", style: textStyle.copyWith(color: secondColor)),
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
    );
  }

  UserAccountsDrawerHeader buildMenuUserSection() {
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
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Column(
                children: <Widget>[
                  buildHeaderRow(),
                  buildPageView(),
                  buildTransactionsHeader(),
                  buildTransactionDateRow("Today"),
                  buildTransactionItem(
                      "https://i.pinimg.com/originals/23/7d/da/237dda2ebb1b4d04bb989070f83735d8.png",
                      "Coffee",
                      "Starbucks",
                      14,
                      true),
                  buildTransactionItem(
                      "https://www.kindpng.com/picc/m/219-2197033_googleads-logo-google-ads-logo-circle-hd-png.png",
                      "Ads",
                      "Google",
                      280,
                      false),
                  buildTransactionDateRow("Yesterday"),
                  buildTransactionItem(
                      "https://cdn1.iconfinder.com/data/icons/social-messaging-ui-color-shapes/128/store-circle-green-512.png",
                      "Market",
                      "Carrefour",
                      332,
                      true),
                  buildTransactionItem(
                      "https://cdn3.iconfinder.com/data/icons/popular-services-brands-vol-2/512/apple-512.png",
                      "Airpods 2th Gen",
                      "Apple",
                      980,
                      true),
                  buildTransactionItem(
                      "https://i.pinimg.com/originals/23/7d/da/237dda2ebb1b4d04bb989070f83735d8.png",
                      "Coffee",
                      "Starbucks",
                      14,
                      true),
                  buildTransactionItem(
                      "https://www.kindpng.com/picc/m/219-2197033_googleads-logo-google-ads-logo-circle-hd-png.png",
                      "Ads",
                      "Google",
                      280,
                      false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildTransactionDateRow(String date) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
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

  ListTile buildTransactionItem(
      String imgUrl, title, subtitle, int price, bool spending) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(imgUrl),
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
                    color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)));
  }

  Padding buildTransactionsHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Transactions",
            style: textStyle.copyWith(fontSize: 20),
          ),
          Icon(
            Icons.more_horiz,
            size: 32,
            color: secondColor,
          ),
        ],
      ),
    );
  }

  Container buildPageView() {
    return Container(
      height: 208,
      child: PageView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          buildCreditCard("5571123456789000", "Berkan ASLAN", 10, 2022),
          buildCreditCard("4698102030405060", "John DOE", 08, 2027),
          buildCreditCard("5351979852364165", "Berkan ASLAN", 03, 2021),
        ],
      ),
    );
  }

  Center buildCreditCard(String _cardNumber, String _cardHolder, int _month, int _year) {
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

  Row buildHeaderRow() {
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
            setState(() {
              if (isMenuOpen) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
              isMenuOpen = !isMenuOpen;
            });
          },
        ),
        Image.network(
          "https://trypyramid.com/img/pyramid-logo-black-horizontal.png",
          height: 32,
          fit: BoxFit.cover,
        ),
        //Text("My Cards", style: menuTextStyle.copyWith(fontSize: 20)),
        InkWell(
            child: Icon(
              Icons.add,
              color: blackColor,
              size: 32,
            ),
            onTap: () {}),
      ],
    );
  }
}
