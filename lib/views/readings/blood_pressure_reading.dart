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
import 'package:twochealthcare/common_widgets/reading_in_table.dart';
import 'package:twochealthcare/common_widgets/tap_bar.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/blood_pressure_reading_vm.dart';
class BloodPressureReading extends HookWidget {
  const BloodPressureReading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BloodPressureReadingVM bloodPressureReadingVM = useProvider(bloodPressureReadingVMProvider);

    useEffect(
          () {
            bloodPressureReadingVM.bPReadingLoading = true;
            bloodPressureReadingVM.getBloodPressureReading();
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
              text: "Blood Pressure Reading",
            ),
          ),
        ),
        floatingActionButtonLocation:  FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
        body: _body(context,bloodPressureReadingVM: bloodPressureReadingVM));
  }

  _body(context,{BloodPressureReadingVM? bloodPressureReadingVM}){
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ApplicationSizing.verticalSpacer(),
                TapBar(
                  selectedIndx: bloodPressureReadingVM?.timePeriodSelect??0,
                  ontap: (val){
                  bloodPressureReadingVM?.changeTimePeriodSelectIndex(val);
                  },
                ),
                CustomCalendar(
                    selectedDayPredict: bloodPressureReadingVM!.selectDayPredict,
                    onDaySelect: bloodPressureReadingVM.onDaySelected,
                    formatChange: bloodPressureReadingVM.onFormatChanged,
                    onRangeSelect: bloodPressureReadingVM.selectRange,
                  calendarFormat: bloodPressureReadingVM.calendarFormat,
                  headerDisable: bloodPressureReadingVM.headerDisable,
                  dayHeight: bloodPressureReadingVM.dayHeight,
                ),
                LineChart(chartType: ChartType.bloodPressure),
                ReadingInTable(modality: "BP", reading: bloodPressureReadingVM.bPReadings,),
              ],
            ),
            bloodPressureReadingVM.bPReadingLoading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }




}


