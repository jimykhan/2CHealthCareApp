import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/cross_icon_button.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/tick_icon_button.dart';
import 'package:twochealthcare/common_widgets/buttons/icon_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/drop_down/drop_down_button.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_erea.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/heading_text/text_field_title.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class AddRPMEncounter extends HookWidget {
   AddRPMEncounter({Key? key}) : super(key: key);
  String dropDownValue = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
        child: CustomAppBar(
          centerWigets: AppBarTextStyle(
            text: "Add Rpm Encounter",
          ),
          leadingIcon: CrossIconButton(
            onClick: (){
              Navigator.pop(context);
            },
          ),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(80),
          parentContext: context,
          trailingIcon: TickIconButton(),
          addLeftMargin: true,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35)
          )
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldTitle(title: 'Date',),
                      Container(margin: EdgeInsets.only(top: 1),
                        child: Row(
                          children: [
                          Expanded(
                            child: CustomTextField(
                                onchange: (val){},
                                onSubmit: (val){},
                              hints: 'Date',
                              textStyle: Styles.hintStyle(),
                            ),
                          ),
                            SizedBox(width: 10,),
                            SqureIconButton(onClick: () {  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(title: 'Duration',),
                    Container(margin: EdgeInsets.only(top: 1),
                      child: CustomTextField(
                        onchange: (val){},
                        onSubmit: (val){},
                        hints: '00:00:11',
                        textStyle: Styles.hintStyle(),
                      ),
                    ),
                  ],
                ),
              ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(title: 'Service Type',),
                    Container(margin: EdgeInsets.only(top: 1),
                      child: DropDownButton(dropDownValue: dropDownValue, onChange: (String? value) {
                        print("${value}");
                        dropDownValue = value??"";

                      }, menuList: ["","1","2","3"],),
                    ),
                  ],
                ),
              ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(title: 'Notes',),
                    Container(margin: EdgeInsets.only(top: 1),
                      child: CustomTextArea(
                        onchange: (val){},
                        onSubmit: (val){},
                        hints: '',
                        textStyle: Styles.hintStyle(),
                        maxLine: 20,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),

              Container(margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Text("Current Billing Provider:",style: Styles.PoppinsRegular(
                      fontSize: ApplicationSizing.constSize(12),
                      fontWeight: FontWeight.w700,
                    ),),
                    SizedBox(width: 5,),
                    Text("Dawood Shah"
                      ,style: Styles.PoppinsRegular(
                      fontSize: ApplicationSizing.constSize(12),
                      fontWeight: FontWeight.w700,
                        color: fontGrayColor
                    ),),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
