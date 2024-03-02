import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gate_app/database/database_interface.dart';
import 'package:my_gate_app/database/database_objects.dart';
import 'package:my_gate_app/screens/profile2/edit_profile_page.dart';
import 'package:my_gate_app/screens/profile2/model/user.dart';
import 'package:my_gate_app/screens/profile2/utils/user_preferences.dart';
import 'package:my_gate_app/screens/profile2/widget/appbar_widget.dart';
import 'package:my_gate_app/screens/profile2/widget/button_widget.dart';
import 'package:my_gate_app/screens/profile2/widget/profile_widget.dart';
import 'package:my_gate_app/screens/profile2/widget/textfield_widget.dart';
import 'package:my_gate_app/get_email.dart';
import 'package:my_gate_app/screens/profile2/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gate_app/screens/utils/custom_snack_bar.dart';

class Validification_page extends StatefulWidget {
  final String email;
  final bool isEditable;
  final String guard_location;
  final String vehicle_reg;
  final String ticket_type;
  final String destination_addr;
  final String guard_email;
  final String student_location;

  const Validification_page({
    Key? key,
    required this.email,
    required this.guard_location,
    required this.isEditable,
    required this.ticket_type,
    required this.destination_addr,
    required this.vehicle_reg,
    required this.guard_email,
    required this.student_location,
  }) : super(key: key);
  @override
  _Validification_pageState createState() => _Validification_pageState();
}

class _Validification_pageState extends State<Validification_page> {
  bool editAccess = true;
  var user = UserPreferences.myUser;

  late String imagePath;

  late final TextEditingController controller_phone;
  late final TextEditingController controller_department;
  late final TextEditingController controller_year_of_entry;
  late final TextEditingController controller_degree;
  late final TextEditingController controller_gender;
  late final TextEditingController controller_destination_address;
  late final TextEditingController controller_vehicle_reg_num;
  late final TextEditingController controller_location_of_guard;
  late final TextEditingController controller_ticket_type;

  var imagePicker;
  var pic;

  Future<void> init() async {
    String? curr_email = widget.email;

    print("Current Email in validification page: " + curr_email.toString());
    databaseInterface db = new databaseInterface();
    User result = await db.get_student_by_email(curr_email);
    // print("result obj image path" + result.imagePath);
    print("result in validification page=${result.name}");
    setState(() {
      user = result;
      controller_phone.text = result.phone;
      controller_department.text = result.department;
      controller_year_of_entry.text = result.year_of_entry;
      controller_degree.text = result.degree;
      controller_gender.text = result.gender;
      controller_destination_address.text = widget.destination_addr;
      controller_vehicle_reg_num.text = widget.vehicle_reg;
      controller_location_of_guard.text = widget.guard_location;
      controller_ticket_type.text = widget.ticket_type;
      /* controller_gender.text=result. */
      print("Gender in yo:" + result.gender);
      // imagePath = result.imagePath;
      print("image path inside setstate: " + imagePath);
    });

    setState(() {
      pic = result.profileImage;
    });
    /* print("Gender in yo:"+controller_gender.text); */
  }

  @override
  void initState() {
    super.initState();
    controller_phone = TextEditingController();
    controller_department = TextEditingController();
    controller_year_of_entry = TextEditingController();
    controller_degree = TextEditingController();
    controller_gender = TextEditingController();
    controller_destination_address = TextEditingController();
    controller_vehicle_reg_num = TextEditingController();
    controller_location_of_guard = TextEditingController();
    controller_ticket_type = TextEditingController();

    imagePath = UserPreferences.myUser.imagePath;
    pic = NetworkImage(this.imagePath);
    imagePicker = new ImagePicker();
    // print("image path in image widget: " + this.imagePath);
    init();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.guard_location == widget.student_location) {
      return Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        // backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black, // Set the background color to black
          centerTitle: true, // Center-align the title
          iconTheme: IconThemeData(
              color: Color.fromARGB(
                  221, 255, 255, 255)), // Set the back arrow color to white
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          title: Text(
            "Profile Page",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold), // Set the text color to white
          ),
        ),

        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 232, 232, 234),
                Color.fromARGB(255, 255, 255, 255)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              ImageWidget(),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 24),
              builText_phone(controller_phone, "Phone", widget.isEditable, 1),
              const SizedBox(height: 24),
              builText(controller_department, "Department", false, 1),
              const SizedBox(height: 24),
              builText(controller_degree, "Degree", false, 1),
              const SizedBox(height: 24),
              builText(controller_year_of_entry, "Year of Entry", false, 1),
              const SizedBox(height: 24),
              builText(controller_gender, "Gender", false, 1),
              const SizedBox(height: 24),
              builText(controller_destination_address, "Destination Address",
                  false, 1),
              const SizedBox(height: 24),
              builText(controller_vehicle_reg_num,
                  "Vehicle Registeration Number", false, 1),
              const SizedBox(height: 24),
              builText(controller_ticket_type,
                  "Ticket Type", false, 1),
                  const SizedBox(height: 24),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          // await accept_selected_tickets();
                          // List <ResultObj> ticke
                          String time = DateTime.now().toString();
                          print("Accept button pressed == ${widget.email}");
                          await databaseInterface.insert_qr_ticket(
                              widget.email,
                              'Approved',
                              widget.vehicle_reg,
                              widget.ticket_type,
                              time,
                              widget.destination_addr,
                              widget.guard_location,
                              widget.guard_email);
                          await databaseInterface.accept_generated_QR(
                              widget.guard_location,
                              "Approved",
                              widget.ticket_type,
                              time,
                              widget.email);
                          ScaffoldMessenger.of(context).showSnackBar(
                              get_snack_bar("Ticket Approved", Colors.green));
                          Navigator.pop(context);
                        },
                        label: Text(
                          "Accept",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icon(
                          Icons.check_circle_outlined,
                          color: Colors.green,
                          size: 50.0,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 254, 255),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          String time = DateTime.now().toString();
                          // await reject_selected_tickets();
                          await databaseInterface.insert_qr_ticket(
                              widget.email,
                              'Rejected',
                              widget.vehicle_reg,
                              widget.ticket_type,
                              time,
                              widget.destination_addr,
                              widget.guard_location,
                              widget.guard_email);
                          await databaseInterface.accept_generated_QR(
                              widget.guard_location,
                              "Rejected",
                              widget.ticket_type,
                              time,
                              widget.email);
                          ScaffoldMessenger.of(context).showSnackBar(
                              get_snack_bar("Ticket Rejected", Colors.red));
                          Navigator.pop(context);
                        },
                        label: Text(
                          "Reject",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 50.0,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 255, 255),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              /* ElevatedButton(
              onPressed: (){},
              child:Text('Edit '),
            ), */
            ],
          ),
        ),
      );
    } else {
      // Display snack and go back to the previous screen
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //         'You are not authorized for ${widget.student_location} Locations'),
      //     backgroundColor: Colors.red, // Set the background color to red
      //   ),
      // );
      Navigator.of(context).pop();

      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(), // Blank container as the body
      );
    }
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.black.withOpacity(0.7)),
          )
        ],
      );

  Widget builText(TextEditingController controller, String label,
          final bool enabled, int maxLines) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 8),
          TextField(
            style: TextStyle(color: Colors.black),
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(12),
              ),
              labelStyle: TextStyle(
                color: Color(int.parse("0xFF344953")),
              ),
            ),
            maxLines: maxLines,
          ),
        ],
      );

  Widget builText_phone(TextEditingController controller, String label,
          bool enabled, int maxLines) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.black),
                      enabled: enabled, // Use the 'enabled' parameter here
                      controller: controller,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelStyle: TextStyle(
                          color: Color(int.parse("0xFF344953")),
                        ),
                      ),
                      maxLines: maxLines,
                    ),
                    if (enabled) // Only show the edit button if enabled is true
                      Positioned(
                        right: 0,
                        top: 10,
                        child: TextButton(
                          onPressed: () async {
                            // Handle button press here
                            await databaseInterface
                                .update_number(controller.text, user.email)
                                .then((res) => {
                                      if (res == true)
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(get_snack_bar(
                                                  "Phone number updated",
                                                  Colors.green))
                                        }
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(get_snack_bar(
                                                  "Failed to Update Phone Number",
                                                  Colors.red))
                                        }
                                    });
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          )
        ],
      );

  Future<void> pick_image() async {
    print("edit profile page image clicked 2");
    var source = ImageSource.gallery;
    print(source);
    XFile image = await imagePicker.pickImage(source: source);
    var widget_email = widget.email;
    print("image is picked");
    print(image.path);
    if (widget_email != null) {
      await databaseInterface.send_image(
          image, "/students/change_profile_picture_of_student", widget_email);
    }

    databaseInterface db = new databaseInterface();
    User result = await db.get_student_by_email(widget.email);

    var pic_local = await result.profileImage;
    setState(() {
      pic = pic_local;
    });
  }

  Future<void> pick_image_blank() async {
    var source = ImageSource.gallery;
    print(source);
    var filePath =
        "assets/images/dummy_person.jpg"; // Replace with the actual file path
    XFile image = XFile(filePath);
    var widget_email = widget.email;
    if (widget_email != null) {
      await databaseInterface.send_image(
          image, "/students/change_profile_picture_of_student", widget_email);
    }

    databaseInterface db = new databaseInterface();
    User result = await db.get_student_by_email(widget.email);

    var pic_local = await NetworkImage(result.imagePath);
    var remove_image = await AssetImage('images/dummy_person.jpg');
    setState(() {
      pic = remove_image;
    });
  }

  Widget ImageWidget() {
    print("edit 1");
    return ViewValidification_page();
    /* if(widget.isEditable){
      print("edit 2");
      /* return EditableValidification_page(); */
    } */
    /* return ViewValidification_page(); */
  }

  Widget EditableValidification_page() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  // image: AssetImage(image),
                  // image: NetworkImage(widget.imagePath),
                  image: pic,
                  fit: BoxFit.cover,
                  width: 180,
                  height: 180,
                  child: InkWell(
                    onTap: () async {
                      pick_image();
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            // child: buildEditIcon(Theme.of(context).colorScheme.primary),
            child: buildEditIcon(Color(int.parse("0xFF344953"))),
          ),
          /* Positioned(
          bottom:0,
          right: 50,
          child: buildEditIcon_1(Color(int.parse("0xFF344953"))),
        ), */
        ],
      ),
    );
  }

  Widget ViewValidification_page() {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              // color: Colors.blue,
              child: Ink.image(
                // image: AssetImage(image),
                // image: NetworkImage(widget.imagePath),
                image: pic,
                fit: BoxFit.cover,
                width: 180,
                height: 180,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            // child: buildEditIcon(Theme.of(context).colorScheme.primary),
            child: buildEditIcon(Color(int.parse("0xFF344953"))),
          ),
        ],
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildEditIcon_1(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}