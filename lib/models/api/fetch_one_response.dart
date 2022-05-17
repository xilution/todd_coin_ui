class FetchOneResponse {
  final Map<String, dynamic> data;

  FetchOneResponse(this.data);

  FetchOneResponse.fromJson(Map<String, dynamic> json) : data = json['data'];
}
