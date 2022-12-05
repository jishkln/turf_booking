import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/booking/controller/booking_controller.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';

class BookingChip extends StatelessWidget {
  const BookingChip({
    super.key,
    required this.data,
    required this.amount,
    required this.heading,
    required this.headingIcon,
    required this.timesList,
  });
  final DataList data;
  final String heading;
  final IconData headingIcon;
  final List<String> timesList;
  final int amount;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookingProviderm>(context);
    return Column(children: [
      ListTile(
        leading: Icon(
          headingIcon,
        ),
        title: Text(
          heading,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        trailing: Text(
          '₹ $amount',
          style: TextStyle(
            fontSize: 20,
            color: Colors.amber[300],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Consumer<BookingProviderm>(builder: (context, value, _) {
        return Wrap(
            children: List.generate(
                timesList.length,
                (index) => GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          color: value.multySelectClr(
                            timeValue: timesList[index],
                            heading: heading,
                          ),
                        ),
                        height: 50,
                        width: 100,
                        child: Center(
                          child: Text(
                            timesList[index].trim(),
                          ),
                        ),
                      ),
                      onTap: () {
                        value.mulSelection(
                            times: timesList[index],
                            amount: amount,
                            heading: heading);
                      },
                    )));
      }),
    ]);
  }
}
