class AlreadyBookedResponse {
  AlreadyBookedResponse({
    required this.status,
    required this.data,
  });

  bool status;
  List<Datas> data;

  factory AlreadyBookedResponse.fromJson(Map<String, dynamic> json) =>
      AlreadyBookedResponse(
        status: json["status"],
        data: List<Datas>.from(json["data"].map((x) => Datas.fromJson(x))),
      );
}

class Datas {
  Datas({
    required this.bookingDate,
    required this.timeSlot,
  });

  String bookingDate;

  List<int> timeSlot;

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        bookingDate: json["booking_date"],
        timeSlot: List<int>.from(json["time_slot"].map((x) => x)),
      );
}
