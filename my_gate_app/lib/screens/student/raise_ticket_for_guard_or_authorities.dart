// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_gate_app/screens/student/student_authorities_side/student_authorities_tabs.dart';
import 'package:my_gate_app/screens/student/student_guard_side/student_tabs.dart';

class RaiseTicketForGuardOrAuthorities extends StatefulWidget {
  const RaiseTicketForGuardOrAuthorities(
      {super.key, required this.location, required this.pre_approval_required});
  final String location;
  final bool pre_approval_required;

  @override
  State<RaiseTicketForGuardOrAuthorities> createState() =>
      _RaiseTicketForGuardOrAuthoritiesState();
}

class _RaiseTicketForGuardOrAuthoritiesState
    extends State<RaiseTicketForGuardOrAuthorities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.center,
          "Raise Request",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
          color: Colors.orange.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            // add Column
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text('Welcome', style: TextStyle( // your text
              //     fontSize: 50.0,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white)
              // ),
              // RaisedButton(onPressed: () {Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StudentTicketTable(location: widget.location))
              // );
              // }, child: Text('Raise Ticket for Guard'),
              // ), // your button beneath text
              // Image.asset('assets/images/security-guard.png'),

              SizedBox(
                height: 100,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentTabs(
                        location: widget.location,
                        pre_approval_required: widget.pre_approval_required,
                      ),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(0.0),
                elevation: 6,
                color: Colors.black,
                textColor: Colors.white,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Raise Ticket for Guard",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 50),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentAuthoritiesTabs(
                        location: widget.location,
                      ),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(0.0),
                elevation: 6,
                color: Colors.black,
                textColor: Colors.white,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Raise Ticket for Authorities",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              // RaisedButton(onPressed: () {}, child: Text('Raise Ticket for Authorities'),), // your button beneath text
            ],
          ),
        ),
      ),
    );
  }
}
