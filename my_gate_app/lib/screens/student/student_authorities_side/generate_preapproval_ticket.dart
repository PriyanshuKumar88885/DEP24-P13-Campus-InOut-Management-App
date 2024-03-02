  // ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print, must_be_immutable

  import 'package:flutter/material.dart';
  import 'package:my_gate_app/database/database_interface.dart';
  import 'package:my_gate_app/get_email.dart';
  import 'package:my_gate_app/screens/admin/utils/dropdown.dart';
  import 'package:my_gate_app/screens/admin/utils/submit_button.dart';
  import 'package:my_gate_app/screens/admin/utils/textbox.dart';
  import 'package:my_gate_app/screens/utils/custom_snack_bar.dart';

  class GeneratePreApprovalTicket extends StatefulWidget {
    const GeneratePreApprovalTicket({Key? key, required this.location})
        : super(key: key);
    final String location;

    @override
    _GeneratePreApprovalTicketState createState() =>
        _GeneratePreApprovalTicketState();
  }

  class _GeneratePreApprovalTicketState extends State<GeneratePreApprovalTicket> {
    String chosen_authority = "None";
    List<String> authorities = [];
    String entry_or_exit_heading = "";
    String ticket_generated_message = "";
    String student_message = ""; // TODO
    final student_message_form_key = GlobalKey<FormState>();
    String ticket_type =
        ""; // TODO It should take the value either "enter" or "exit"

    Future<void> get_authorities_list() async {
      List<String> authorities_backend =
          await databaseInterface.get_authorities_list();
      setState(() {
        authorities = authorities_backend;
      });
    }

    @override
    void initState() {
      super.initState();
      get_authorities_list();
      // if (widget.in_or_out == 'in') {
      //   this.entry_or_exit_heading = "Generate Exit Preapproval";
      // } else {
      //   this.entry_or_exit_heading = "Generate Entry Preapproval";
      // }
    }

    Future<void> clear_ticket_generated_message() async {
      await Future.delayed(Duration(milliseconds: 2500), () {
        ticket_generated_message = "";
      });
    }

    Future<int> insert_in_authorities_ticket_table() async {
      // ignore: todo
      // TODO Add popup before button is pressed
      // setState(() {
      //   ticket_generated_message = "Generating Ticket";
      // });
      print("submit button insert_in_authorities_ticket_table pressed");
      String email = LoggedInDetails.getEmail();
      String date_time = DateTime.now().toString();
      // ticket_type = "enter";
      // student_message = "Hello Sir, I want to go home for some urgent work. Please give me permission"
      int statusCode = await databaseInterface.insert_in_authorities_ticket_table(
          chosen_authority,
          ticket_type,
          student_message,
          email,
          date_time,
          widget.location);
      //String from_whom, String for_whom,
      //String ticket_type, String location, String message
      // print("Auth email=${chosen_authority},email= ${email}\n\n\n");
      String auth_email = chosen_authority.split("\n")[1];
      // print("Auth email=${auth_email},email= ${email}\n\n\n");
      await databaseInterface.insert_notification_guard_accept_reject(
          email, auth_email, ticket_type, widget.location, student_message);
      return statusCode;
    }

    void display_further_status(int statusCode) {
      Navigator.of(context).pop();
      if (statusCode == 200) {
        final snackBar =
            get_snack_bar("Ticket raised successfully", Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // snackbar
        final snackBar = get_snack_bar("Failed to raise ticket", Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Color.fromARGB(255, 255, 255, 255)
                        ]),
                  ),
                  // color: Colors.yellow,
                  child: Column(children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      this.entry_or_exit_heading,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontSize: 30),
                    ),
                    Image.asset(
                      'assets/images/ticket.jpg',
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    dropdown(
                      context,
                      this.authorities,
                      (String? s) {
                        if (s != null) {
                          print("inside funciton:" + this.chosen_authority);
                          this.chosen_authority = s;
                          print(this.chosen_authority);
                        }
                      },
                      "Choose Authority",
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    dropdown(
                      context,
                      ["enter", "exit"],
                      (String? s) {
                        if (s != null) {
                          print("inside funciton:" + this.ticket_type);
                          this.ticket_type = s;
                          print(this.ticket_type);
                        }
                      },
                      "Choose Ticket Type",
                      Icon(
                        Icons.sticky_note_2,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: TextField(
                        maxLines: null,
                        maxLength: 106,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          this.student_message = value;
                          print("text form: $student_message");
                        },
                        style: TextStyle(
                            color: Colors.black), // Set text color to black
                        decoration: InputDecoration(
                          labelText: "Enter message",
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width:
                                    2), // Set border color and width for inactive state
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width:
                                    2), // Set border color and width for active state
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SubmitButton(
                      submit_function: () async {
                        print("auth ticket raised");
                        print("");
                        final student_message_validity = this
                            .student_message_form_key
                            .currentState
                            ?.validate();
                        FocusScope.of(context).unfocus();
                        if (student_message_validity != null &&
                            student_message_validity) {
                          this.student_message_form_key.currentState?.save();
                        }
                        int statusCode =
                            await insert_in_authorities_ticket_table();
                        display_further_status(statusCode);
                      },
                      button_text: "Generate",
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      this.ticket_generated_message,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ]))));
    }
  }