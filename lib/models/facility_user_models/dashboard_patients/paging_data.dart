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