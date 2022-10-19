import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/services/rpm_services/cgm_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';


class PieChartWiget extends StatefulWidget {
  List<PieGraphData> pieGraphData;
  PieChartWiget({required this.pieGraphData});
  @override
  _PieChartWigetState createState() => _PieChartWigetState();
}

class _PieChartWigetState extends State<PieChartWiget> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              child: PieChart(
                PieChartData(
                    pieTouchData:
                    PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: showingSections()),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Indicator(
                    context,
                    color: widget.pieGraphData[0].color ?? Color(0xff0293ee),
                    text: widget.pieGraphData[0].title ?? 'First',
                    per: widget.pieGraphData[0].value ?? 0.00,
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    context,
                    color: widget.pieGraphData[1].color ?? Color(0xfff8b250),
                    text: widget.pieGraphData[1].title ?? 'Second',
                    isSquare: true,
                    per: widget.pieGraphData[1].value ?? 0.00,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    context,
                    color: widget.pieGraphData[2].color ?? Color(0xff845bef),
                    text: widget.pieGraphData[2].title ?? 'Third',
                    isSquare: true,
                    per: widget.pieGraphData[2].value ?? 0.00,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    context,
                    color: widget.pieGraphData[3].color ?? Color(0xff13d38e),
                    text: widget.pieGraphData[3].title ?? 'Fourth',
                    isSquare: true,
                    per: widget.pieGraphData[3].value ?? 0.00,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Indicator(context,
      {required Color color, required String text, isSquare = true, double per = 0.00}) {
    print("Percentage = ${per}");
    return Row(
      children: [
        Container(
          width: ApplicationSizing.constSize( 10),
          height: ApplicationSizing.constSize( 10),
          // height: ApplicationSizing.constSize(,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: ApplicationSizing.constSize(.5),
        ),
        Container(
          child: Row(
            children: [
              Text(
                "${per.toStringAsFixed(1)} %",
                style: Styles.RobotoMedium(fontSize: ApplicationSizing.constSize( 12)),
              ),
              SizedBox(
                width: ApplicationSizing.constSize(.5),
              ),
              Text(
                "${text}",
                style: Styles.RobotoMedium(fontSize: ApplicationSizing.constSize( 12)),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    int graphPartionLength = widget.pieGraphData.length ;
    return List.generate(graphPartionLength, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 90 : 80;
      final double widgetSize = isTouched ? 55 : 40;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: widget.pieGraphData[0].color ?? Color(0xff0293ee),
            value: widget.pieGraphData[0].value,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: widget.pieGraphData[1].color ?? Color(0xfff8b250),
            value: widget.pieGraphData[1].value,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            // badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: widget.pieGraphData[2].color ?? Color(0xff845bef),
            value: widget.pieGraphData[2].value,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: widget.pieGraphData[3].color ?? Color(0xff13d38e),
            value: widget.pieGraphData[3].value,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return PieChartSectionData(
            color: fontGrayColor,
            value: 0.0,
            title: '',
            radius: 0,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
      }
    });
  }
}

// class LineChartWidget extends StatelessWidget {
//   final List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];
//   int touchedIndex;
//
//   @override
//   Widget build(BuildContext context) {
//         return PieChart(
//           PieChartData(
//               pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
//                 // setState(() {
//                 //   final desiredTouch =
//                 //       pieTouchResponse.touchInput is! PointerExitEvent &&
//                 //           pieTouchResponse.touchInput is! PointerUpEvent;
//                 //   if (desiredTouch && pieTouchResponse.touchedSection != null) {
//                 //     touchedIndex =
//                 //         pieTouchResponse.touchedSection.touchedSectionIndex;
//                 //   } else {
//                 //     touchedIndex = -1;
//                 //   }
//                 // });
//               }),
//               borderData: FlBorderData(
//                 show: false,
//               ),
//               sectionsSpace: 0,
//               centerSpaceRadius: 0,
//               sections: showingSections()),
//         );
//       }
//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = i == touchedIndex;
//       final double fontSize = isTouched ? 20 : 16;
//       final double radius = isTouched ? 110 : 100;
//       final double widgetSize = isTouched ? 55 : 40;
//
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: const Color(0xff0293ee),
//             value: 40,
//             title: '40%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/ophthalmology-svgrepo-com.svg',
//               size: widgetSize,
//               borderColor: const Color(0xff0293ee),
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 1:
//           return PieChartSectionData(
//             color: const Color(0xfff8b250),
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/librarian-svgrepo-com.svg',
//               size: widgetSize,
//               borderColor: const Color(0xfff8b250),
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 2:
//           return PieChartSectionData(
//             color: const Color(0xff845bef),
//             value: 16,
//             title: '16%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/fitness-svgrepo-com.svg',
//               size: widgetSize,
//               borderColor: const Color(0xff845bef),
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 3:
//           return PieChartSectionData(
//             color: const Color(0xff13d38e),
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/worker-svgrepo-com.svg',
//               size: widgetSize,
//               borderColor: const Color(0xff13d38e),
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         default:
//           return null;
//       }
//     });
//   }
// }

class _Badge extends StatelessWidget {
  final String? svgAsset;
  final double? size;
  final Color? borderColor;

  const _Badge(
      this.svgAsset, {
        Key? key,
         this.size,
         this.borderColor,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor?? fontGrayColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Center(
        // child: SvgPicture.asset(
        //   svgAsset,
        //   fit: BoxFit.contain,
        // ),
      ),
    );
  }
}