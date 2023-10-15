class NetworkResponse<Data> {
  bool? isSuccessful;
  Data? data;
  String? message;

  NetworkResponse(
    this.isSuccessful,
    this.data, {
    this.message,
  });
}
