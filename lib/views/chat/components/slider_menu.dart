import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class ChatSlider extends StatefulWidget {
  List<Menu> menuList;
  Function(Menu) onchange;
  ChatSlider({required this.menuList,required this.onchange});
  @override
  _ChatSliderState createState() => _ChatSliderState();
}

class _ChatSliderState extends State<ChatSlider>  {

  int _currentIndex = 0;

  int _prevControllerIndex = 0;


  // scroll controller for the TabBar
  ScrollController _scrollController = new ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];
  bool _buttonTap = false;

  @override
  void initState() {
    super.initState();
    for (int index = 0; index < widget.menuList.length; index++) {
      _keys.add(new GlobalKey());
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        // color: Colors.grey,
          height: 40.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.menuList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    key: _keys[index],
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _buttonTap = true;
                            _setCurrentIndex(index);
                          });
                          widget.onchange(widget.menuList[index]);
                        },
                        child: Container(
                          // alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _getForegroundColor(index),
                                width: 2
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.menuList[index].name??"",style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(15),color: _getFontColor(index)),),
                              SizedBox(width: 10,),
                              Text("${widget.menuList[index].count??" "}",style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(15),color: _getFontColor(index)),),

                            ],
                          ),
                        )));
              })),
    ]);
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }


  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[widget.menuList.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getForegroundColor(int index) {
    if (index == _currentIndex) {
      return appColor;
    } else if (index == _prevControllerIndex) {
      return Colors.transparent;
    } else {
      return Colors.transparent;
    }
  }

  _getFontColor(int index) {
    if (index == _currentIndex) {
      return appColor;
    }
      else {
      return Colors.black;
    }
  }
}

class Menu{
  int? id;
  String? name;
  int? count;
  Menu({this.id,this.name,this.count});
}