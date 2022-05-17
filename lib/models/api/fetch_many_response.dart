class FetchManyResponse {
  final Map<String, dynamic> meta;
  final List<dynamic> data;

  FetchManyResponse(this.meta, this.data);

  FetchManyResponse.fromJson(Map<String, dynamic> json)
      : meta = json['meta'],
        data = json['data'];
}
