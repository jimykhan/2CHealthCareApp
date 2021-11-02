import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/calendar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/line_chart.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/bg_reading_vm.dart';
import 'package:twochealthcare/views/readings/bg_reading_in_table.dart';
import 'package:twochealthcare/views/readings/pb_reading_in_table.dart';
import 'package:twochealthcare/common_widgets/tap_bar.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/blood_pressure_reading_vm.dart';
class BGReading extends HookWidget {
  const BGReading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BGReadingVM bgReadingVM = useProvider(bGReadingVMProvider);

    useEffect(
          () {
        bgReadingVM.bGReadingLoading = true;
        bgReadingVM.getBGReading();
        Future.microtask(() async {

        });

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(right:ApplicationSizing.convertWidth(10)),
                child: RotatedBox(
                    quarterTurns: 2,child: SvgPicture.asset("assets/icons/home/right-arrow-icon.svg")),
              ),
            ),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Blood Glucose Reading",
            ),
          ),
        ),
        floatingActionButtonLocation:  FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
        body: _body(context,bgReadingVM: bgReadingVM));
  }

  _body(context,{BGReadingVM? bgReadingVM}){
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ApplicationSizing.verticalSpacer(),
                TapBar(
                  selectedIndx: bgReadingVM?.timePeriodSelect??0,
                  ontap: (val){
                    bgReadingVM?.changeTimePeriodSelectIndex(val);
                  },
                ),
                CustomCalendar(
                  selectedDayPredict: bgReadingVM!.selectDayPredict,
                  onDaySelect: bgReadingVM.onDaySelected,
                  formatChange: bgReadingVM.onFormatChanged,
                  onRangeSelect: bgReadingVM.selectRange,
                  calendarFormat: bgReadingVM.calendarFormat,
                  headerDisable: bgReadingVM.headerDisable,
                  dayHeight: bgReadingVM.dayHeight,
                ),
                LineChart(chartType: ChartType.bloodPressure),
                bGReadingInTable(bGReadings:bgReadingVM.bPReadings,),
              ],
            ),
            bgReadingVM.bGReadingLoading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }




}


