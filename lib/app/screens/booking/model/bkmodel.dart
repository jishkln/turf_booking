class BookedRequest {
    BookedRequest({
        required this.bookingDate,
      required  this.turfId,
     required   this.timeSlot,
    });

    String bookingDate;
    String turfId;
    List<int> timeSlot;


    Map<String, dynamic> toJson() => {
        "booking_date": bookingDate,
        "turf_id": turfId,
        "time_slot": List<dynamic>.from(timeSlot.map((x) => x)),
    };
}


class BookedResponse {
    BookedResponse({
        required this.status,
      required  this.message,
    });

    bool status;
    String message;

    factory BookedResponse.fromJson(Map<String, dynamic> json) => BookedResponse(
        status: json["status"],
        message: json["message"],
    );


}
