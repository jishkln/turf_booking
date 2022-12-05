
import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/booking/controller/booking_controller.dart';
import 'package:truff_majestic/app/screens/booking/view/multiselecter.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';
import 'package:truff_majestic/app/utils/initsatate.dart';

class BookingPageM extends StatelessWidget {
  const BookingPageM({super.key, required this.bookingData});

  final DataList bookingData;

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<BookingProviderm>(context);
    final wid = MediaQuery.of(context).size.width;
    final high = MediaQuery.of(context).size.height;

    return StatefulWrapper(
      onInit: () {
        providers.times;
      },
      child: Scaffold(
        backgroundColor: backGrountColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: white1Color),
          centerTitle: true,
          elevation: 20,
          backgroundColor: black1Color,
          title: Text(
            "Book Now",
            style: TurffTheme.darkTextTheme.headline1,
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  kHight20,
                  Container(
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child:
                        // DatePicker(
                        //   DateTime.now(),
                        //   initialSelectedDate: DateTime.now(),
                        //   selectionColor: Colors.black,
                        //   selectedTextColor: Colors.white,
                        //   onDateChange: (date) {
                        //     // New date selected
                        //     providers.allReadyBooked(bookingData.id);
                        //     providers.checkingDate();
                        //     providers.totalPrice = 0;
                        //     providers.selectDate(date);
                        //   },
                        // ),

                        Consumer<BookingProviderm>(
                            builder: (context, value, _) {
                      return HorizontalCalendar(
                        date: DateTime.now(),
                        textColor: white1Color,
                        backgroundColor: backGrountColor,
                        selectedColor: black1Color,
                        showMonth: true,
                        onDateSelected: (date) {
                          providers.onDateChange(date);
                        },
                      );
                    }),
                  ),
                  kHight20,
                  Card(
                    shape: const BeveledRectangleBorder(),
                    color: black1Color,
                    elevation: 20,
                    margin: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        timePlay(
                          "Moring 🌞",
                          "₹ : ${bookingData.turfPrice!.morningPrice!}",
                        ),
                        timePlay(
                          "Afternoon 🌝",
                          "₹ : ${bookingData.turfPrice!.afternoonPrice!}",
                        ),
                        timePlay(
                          "Evning 🌜",
                          "₹ : ${bookingData.turfPrice!.eveningPrice!}",
                        ),
                      ],
                    ),
                  ),
                  kHight20,
                  subTextContainer(
                    bacgroundColor: white1Color,
                    title: Center(
                      child: Text(
                        "Time Slots",
                        style: TurffTheme.lightTextTheme.headline1,
                      ),
                    ),
                  ),
                  kHight20,
                  kHight20,
                  BookingChip(
                    amount: bookingData.turfPrice!.morningPrice!,
                    data: bookingData,
                    heading: 'Morning',
                    headingIcon: Icons.sunny_snowing,
                    timesList: providers.morningTime,
                  ),
                  BookingChip(
                    amount: bookingData.turfPrice!.afternoonPrice!,
                    data: bookingData,
                    heading: 'Afternoon',
                    headingIcon: Icons.sunny,
                    timesList: providers.afternoonTime,
                  ),
                  BookingChip(
                    amount: bookingData.turfPrice!.eveningPrice!,
                    data: bookingData,
                    heading: 'Evening',
                    headingIcon: Icons.nights_stay_outlined,
                    timesList: providers.eveningTime,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                  width: wid / 3,
                  height: high / 15,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "₹ ${providers.totalFair.toString()}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FloatingActionButton.extended(
                  onPressed: (() {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: SizedBox(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Are You Sure to payment',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Text(
                                    "₹ ${providers.totalFair.toString()}",
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            providers.pay(providers.totalFair,
                                                bookingData.id!);
                                            providers.newTurfBook(
                                                turfId: bookingData.id!);
                                            // controller.continueBooking(
                                            //     bookingDetails, context);
                                            // providers.razorpayOption(
                                            //   providers.totalPrice,
                                            //   bookingData,
                                            //   context,
                                            // );
                                          },
                                          child: const Text("Continue"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                  label: const Text(
                    "BOOK NOW",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  extendedPadding:
                      const EdgeInsetsDirectional.only(start: 100, end: 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container subTextContainer(
      {required Widget title, required Color bacgroundColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: bacgroundColor,
      width: double.infinity,
      child: title,
    );
  }

  Container timePlay(String title, String amount) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 130,
      height: 50,
      decoration: BoxDecoration(
        color: white1Color,
        border: Border.all(color: white1Color),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TurffTheme.lightTextTheme.headline2,
            ),
            Text(
              amount,
              style: TurffTheme.lightTextTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}
