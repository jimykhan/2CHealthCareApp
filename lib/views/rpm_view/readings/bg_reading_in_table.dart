import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/rpm_view/readings/compnents/reading_tile.dart';

class bGReadingInTable extends HookWidget {
  List<BGDataModel> bGReadings = [];
  bGReadingInTable({Key? key, required this.bGReadings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    String measureDate = "00 000 00";
    bGReadings.sort((a, b) {
      return b.measurementDate!.compareTo(a.measurementDate!);
      // return b.measurementDate.compareTo(a.measurementDate);
    });
    return Container(
      color: Colors.white,
      child: ListView.separated(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            bool showDate = false;
            if(measureDate != bGReadings[index].measurementDate!.substring(0, 9)){
              measureDate = bGReadings[index].measurementDate!.substring(0, 9);
              showDate = true;
            }
            return ReadingTile(
              time: bGReadings[index].measurementDate!,
              reading1: bGReadings[index].bg?.toStringAsFixed(0),
              unit1: bGReadings[index].bgUnit??"",
              date: showDate ? measureDate : null,
            );
          },
          separatorBuilder: (context, index) {
            return ApplicationSizing.verticalSpacer();
          },
          itemCount: bGReadings.length),
    );
  }
}
