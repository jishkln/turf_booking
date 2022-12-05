import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/booking/controller/booking_controller.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';

class PaymentStatus extends StatelessWidget {
  const PaymentStatus({super.key});
 
  @override
  Widget build(BuildContext context) {
     final   bookingController = Provider.of<BookingProviderm>(context);
    return Scaffold(
      body: Consumer<BookingProviderm>(
        builder: (context, controller,_) {
          bookingController.isSuccess 
              ? bookingController.afterPayment()
              : null;
          return bookingController.isPaymentLoading 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Payment Processing...',
                        style: TextStyle(
                          color: black1Color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                )
              : ColoredBox(
                  color: white1Color,
                  child: Stack(
                    children: [
                      ConfettiWidget(
                        shouldLoop: false,
                        confettiController:
                            bookingController.confettiController,
                        blastDirection: pi / 3,
                        numberOfParticles: 60,
                        blastDirectionality: BlastDirectionality.explosive,
                        maxBlastForce: 20, // set a lower max blast force
                        minBlastForce: 5, // set a lower min blast force
                        emissionFrequency: 0.02,
                        gravity: 0.02,
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple,
                          black1Color,
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Payment Successful".toUpperCase(),
                              style: const TextStyle(
                                color: black1Color,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            kWidth10,
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
