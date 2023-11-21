import 'package:flutter/material.dart';
import 'package:ipm_project/data/ticket.dart';
import 'package:ipm_project/presentation/book_visit/ticketcheckout_page.dart';
import 'package:table_calendar/table_calendar.dart';


class BuyTicketPage extends StatefulWidget {
  const BuyTicketPage({super.key});

  @override
  _BuyTicketPageState createState() => _BuyTicketPageState();

}

class _BuyTicketPageState extends State<BuyTicketPage> {

  Map<String, int> ticketCounts = {};

  void updateTicketCount(String ticketType, int count) {
    setState(() {
      ticketCounts[ticketType] = count;
    });
  }

  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now(); // New state variable for focused day

  get totalPrice => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Book your tickets'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDate = focusedDay; // Update focused day as well
                });
              },
              focusedDay: _focusedDate, // Use the focused day state variable
              selectedDayPredicate: (day) {
                // Use this to determine which day is currently selected
                return isSameDay(_selectedDate, day);
              },
              firstDay: DateTime.utc(2023, 11, 1),
              lastDay: DateTime.utc(2030, 3, 14),
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                titleCentered: true,
              ),
              calendarStyle: const CalendarStyle(
                cellMargin: EdgeInsets.all(2),
              ),
              rowHeight: 25.0,
              daysOfWeekHeight: 40.0,
            ),
            const SizedBox(height: 30),
            Text(
              'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            CustomBox(text: 'Regular ( 6€ )', onCountChanged: updateTicketCount,),
            const SizedBox(height: 20),
            CustomBox(text: 'Student ( 4€ )', onCountChanged: updateTicketCount,),
            const SizedBox(height: 20),
            CustomBox(text: 'Family Pack ( 13.50 € )', onCountChanged: updateTicketCount,),
            const SizedBox(height: 70),
            ElevatedButton(
            onPressed: () {
              navigateToCheckout();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black87,
              fixedSize: const Size(200, 50),
            ),
            child: const Text('PAY', style: TextStyle(color: Colors.white))
        )
          ],
        ),
      ),
    );
  }

  void navigateToCheckout() {
    List<TicketInfo> tickets = ticketCounts.entries.map((entry) =>
        TicketInfo(entry.key, entry.value)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TicketCheckoutPage(tickets: tickets)),
    );
  }

}

class CustomBox extends StatefulWidget {
  final String text;
  final Function(String, int) onCountChanged;

  CustomBox({super.key, required this.text, required this.onCountChanged});

  @override
  _CustomBoxState createState() => _CustomBoxState();
}


class _CustomBoxState extends State<CustomBox> {

  int counter = 0;

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
                  top: -4,
                  child: ElevatedButton(
                      onPressed: () {
                        // Perform booking logic here
                        // For example, you can show a confirmation dialog
                        if(counter > 0) {
                          setState(() {
                          counter--;
                        });
                        }
                        widget.onCountChanged(widget.text, counter);
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
                          '${widget.text} : $counter ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ))]),
              Positioned(
                  right: 1.0,
                  top: -4,
                  child: ElevatedButton(
                      onPressed: () {
                        // Perform booking logic here
                        // For example, you can show a confirmation dialog
                        setState(() {
                          counter++;
                        });
                        widget.onCountChanged(widget.text, counter);
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



