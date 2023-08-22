import 'package:twochealthcare/models/rpm_models/dex_com_models/GetStatisticsDataModel.dart';
import 'package:twochealthcare/services/rpm_services/cgm_services.dart';

class StatisticsAndEvgs{
   GetStatisticsDataModel? statisticsDataModel;
   GetDexcomAvgsResponse? dexcomAvgsResponse;
   StatisticsAndEvgs({this.statisticsDataModel,this.dexcomAvgsResponse});


}