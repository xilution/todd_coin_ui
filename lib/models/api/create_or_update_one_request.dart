class CreateOrUpdateOneRequest {
  final Map<String, dynamic> data;

  CreateOrUpdateOneRequest(this.data);

  Map<String, dynamic> toJson() => {'data': data};
}
