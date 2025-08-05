class DataInfo {
  int time;
  double discomfort;
  Map<dynamic, dynamic> nowbc;
  DataInfo({required this.time, required this.discomfort, required this.nowbc});

  Map<String, dynamic> toMap() {
    return {'time': time, 'discomfort': discomfort, 'nowbc': nowbc};
  }
}
