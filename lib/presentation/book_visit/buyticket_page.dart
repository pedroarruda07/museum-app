import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/book_visit/ticketcheckout_page.dart';
import 'package:table_calendar/table_calendar.dart';


class BuyTicketPage extends StatefulWidget {
  const BuyTicketPage({super.key});

  @override
  _BuyTicketPageState createState() => _BuyTicketPageState();

}

class _BuyTicketPageState extends State<BuyTicketPage> {
  int counter = 0;

  DateTime _selectedDate = DateTime.now();

  get totalPrice => null;


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Book your tickets'),
        centerTitle: true, // This centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              onDaySelected: (date, events) {
                setState(() {
                  _selectedDate = date;
                });
              }, focusedDay:DateTime.now(), firstDay: DateTime.utc(2023, 11, 1), lastDay: DateTime.utc(2030, 3, 14),
               availableCalendarFormats: const {CalendarFormat.month: 'Month'},
               headerStyle: const HeaderStyle(
                   titleTextStyle: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 18.0,
                          ),
                    titleCentered: true
               ),
               calendarStyle: const CalendarStyle(
                  cellMargin: EdgeInsets.all(2)
                  ),
              rowHeight: 25.0,
              daysOfWeekHeight: 40.0
            ),
            const SizedBox(height: 30),
            Text(
              'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            CustomBox(text: 'Normal ( 6€ )'),
            const SizedBox(height: 20),
            CustomBox(text: 'Student ( 4€ )'),
            const SizedBox(height: 20),
            CustomBox(text: 'Family Pack ( 13.50 € )'),
            const SizedBox(height: 40),
            ElevatedButton(
            onPressed: () {
              // Perform booking logic here
              // For example, you can show a confirmation dialog

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketCheckoutPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
            ),
            child: const Text('PAY')
        )
          ],
        ),
      ),
    );
  }
}

class CustomBox extends StatefulWidget {

  String text;

  CustomBox({super.key, required this.text});

  @override
  _CustomBoxState createState() => _CustomBoxState(text);

  }



class _CustomBoxState extends State<CustomBox> {

  int counter = 0;

  late String text;

  _CustomBoxState(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 40,
        color: Colors.black87,
        child: Stack(
            children: <Widget> [
              Positioned(
                  left: 1.0,
                  top: 5.0,
                  child: ElevatedButton(
                      onPressed: () {
                        // Perform booking logic here
                        // For example, you can show a confirmation dialog
                        if(counter > 0) {
                          setState(() {
                          counter--;
                        });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder()
                      ),
                      child: const Text('-')
                  ))
              ,Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Align(
                        alignment: const Alignment(0, 0),
                        child: Text(
                          '$text : $counter ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ))])
              ,
              Positioned(
                  right: 1.0,
                  top: 5.0,
                  child: ElevatedButton(
                      onPressed: () {
                        // Perform booking logic here
                        // For example, you can show a confirmation dialog
                        setState(() {
                          counter++;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder()
                      ),
                      child: const Text('+')
                  )),
            ]
        ));
  }

  int getNumOfTickets(int counter) {
    return counter;
  }
    
}



