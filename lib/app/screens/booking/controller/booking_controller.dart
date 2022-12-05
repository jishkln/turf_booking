import 'dart:developer';

import 'package:confetti/confetti.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:truff_majestic/app/screens/booking/model/allreadybboked.dart';
import 'package:truff_majestic/app/screens/booking/model/bkmodel.dart';
import 'package:truff_majestic/app/screens/booking/services/bkrespo.dart';

import 'package:truff_majestic/app/screens/booking/view/paymentstatus.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';
import 'package:truff_majestic/app/screens/home/view/bottumnav.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/navigation.dart';

class BookingProviderm extends ChangeNotifier {
  int selectedDay = DateTime.now().day;
  List<int> times = [];
  List<String> morningTime = [];
  List<String> afternoonTime = [];
  List<String> eveningTime = [];

  final List<int> newBookedList = [];
  final List alreadyBookedList = [];
  String selectedDate = DateFormat.yMd().format(DateTime.now());
  final Map<String, List<int>> alredyBookedTurfMap = {};
  int totalFair = 0;
  bool isLoading = false;
  bool isPaymentLoading = false;
  bool isSuccess = false;
  final ConfettiController confettiController = ConfettiController();

  void timeConvertion12(DataList time) {
    times.clear();
    times.addAll([
      time.turfTime!.timeMorningStart!,
      time.turfTime!.timeMorningEnd!,
      time.turfTime!.timeAfternoonStart!,
      time.turfTime!.timeAfternoonEnd!,
      time.turfTime!.timeEveningStart!,
      time.turfTime!.timeEveningEnd!,
    ]);
    for (int i = 0; i < times.length; i++) {
      if (times[i] > 12) {
        times[i] = times[i] - 12;
      }
    }
    timeListAdd();
  }

  void timeListAdd() {
    bookingTimeView(times[0], times[1], morningTime, '');
    bookingTimeView(times[2], times[3], afternoonTime, ' ');
    bookingTimeView(times[4], times[5], eveningTime, '  ');
  }

//===============for Booking time view=============

  void bookingTimeView(
      int startTime, int endTime, List subTimeList, String space) {
    subTimeList.clear();
    for (int i = startTime; i < endTime; i++) {
      subTimeList
          .add("$space${i.toString()}:00 - $space${(i + 1).toString()}:00");
    }
  }

  void bookNow(String id) async {
    selectedDate = DateFormat.yMd().format(DateTime.now());
    newBookedList.clear();
    totalFair = 0;
    isLoading = true;
    notifyListeners();
    await bookListChecking(selectedDate);
    isLoading = false;
  }
  //==============dateChange===========

  void onDateChange(date) {
    final parseDate = DateTime.parse(date.toString());
    selectedDate = DateFormat.yMd().format(parseDate);
    newBookedList.clear();
    bookListChecking(selectedDate);
    notifyListeners();
  }

  //==========select timemul==========
  int timeConversion(String value, String heading) {
    final int time;
    if (heading == "Morning") {
      time = int.parse(value.trim().split(":").first);
      return time;
    } else {
      time = int.parse(value.trim().split(":").first) + 12;
      return time;
    }
  }

  void mulSelection(
      {required String times, required int amount, required String heading}) {
    final color = multySelectClr(timeValue: times, heading: heading);
    final time = timeConversion(times, heading);
    if (color == Colors.green.withOpacity(0.4)) {
      newBookedList.add(time);
      totalFair += amount;
    } else if (color == Colors.amber[300]!) {
      newBookedList.remove(time);
      totalFair -= amount;
    }
    notifyListeners();
  }

  Color multySelectClr({required String timeValue, required String heading}) {
    final time = timeConversion(timeValue, heading);
    if (alreadyBookedList.contains(time)) {
      return Colors.redAccent[100]!;
    } else if (time <= DateTime.now().hour &&
        selectedDate == DateFormat.yMd().format(DateTime.now())) {
      return greyColor;
    } else if (newBookedList.contains(time)) {
      return Colors.amber[300]!;
    } else {
      return Colors.green.withOpacity(0.4);
    }
  }

//============Already booked===========
  bookListChecking(String selectedDate) {
    alreadyBookedList.clear();
    if (alredyBookedTurfMap.containsKey(selectedDate)) {
      alreadyBookedList.addAll(alredyBookedTurfMap[selectedDate]!);
    }
  }

  Future<void> getBookedTruf(String id) async {
    final AlreadyBookedResponse? bookedResponse =
        await BookTurfService().getBookingList(id: id);

    if (bookedResponse != null) {
      alredyBookedTurfMap.clear();
      for (var element in bookedResponse.data) {
        alredyBookedTurfMap[element.bookingDate] = element.timeSlot;
      }
    }
  }

  Future<void> newTurfBook({required String turfId}) async {
    isSuccess = false;
    BookedRequest model = BookedRequest(
        bookingDate: selectedDate, turfId: turfId, timeSlot: newBookedList);
    log("$selectedDate date $turfId id $newBookedList");
    BookedResponse? bookedResponse =
        await BookTurfService.bookTurf(model: model);
    if (bookedResponse != null && bookedResponse.status) {
      isSuccess = true;
      Fluttertoast.showToast(msg: bookedResponse.message.toString());
    }
    NavigationServices.back();
    NavigationServices.back();
    notifyListeners();
  }

  void afterPayment() async {
    confettiController.play();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    confettiController.stop();
    NavigationServices.pushRemoveUntil(screen: BottumNavi());
  }

  final Razorpay _razorpay = Razorpay();
  late String turfId;

  void onInit() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    isPaymentLoading = true;
    NavigationServices.pushRemoveUntil(screen: const PaymentStatus());

    await newTurfBook(turfId: turfId);
    isPaymentLoading = false;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: response.message.toString());
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: response.walletName.toString());
  }

  Future<void> pay(amount, id) async {
    turfId = id;
    Map<String, dynamic> options = {
      'key': 'rzp_test_0rVXPTdOuP9c4q',
      'amount': amount * 100, //in the smallest currency sub-unit.
      'name': 'Truf Majestic',
      // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      'description': 'For Demo',
      'timeout': 60, // in seconds
      'prefill': {'contact': '9567011225', 'email': 'klnjish@gmail.com'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    NavigationServices.back();
    NavigationServices.back();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
}
