import 'package:twochealthcare/models/patient_communication_models/chat_message_model.dart';

class CommunicationHistoryModel {
  PagingData? pagingData;
  List<ChatMessageModel>? results;

  CommunicationHistoryModel({this.pagingData, this.results});

  CommunicationHistoryModel.fromJson(Map<String, dynamic> json) {
    pagingData = json['pagingData'] != null
        ? new PagingData.fromJson(json['pagingData'])
        : null;
    if (json['results'] != null) {
      results = <ChatMessageModel>[];
      json['results'].forEach((v) {
        results!.add(new ChatMessageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagingData != null) {
      data['pagingData'] = this.pagingData!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PagingData {
  int? pageNumber;
  int? pageSize;
  int? pageCount;
  int? elementsCount;

  PagingData(
      {this.pageNumber, this.pageSize, this.pageCount, this.elementsCount});

  PagingData.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    elementsCount = json['elementsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['pageCount'] = this.pageCount;
    data['elementsCount'] = this.elementsCount;
    return data;
  }
}