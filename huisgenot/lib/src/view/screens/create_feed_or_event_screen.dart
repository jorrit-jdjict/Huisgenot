import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/event_controller.dart';
import 'package:huisgenot/src/controller/feed_controller.dart';
import 'package:huisgenot/src/model/feed_model.dart';
import 'package:huisgenot/src/model/event_model.dart';
import 'package:huisgenot/src/model/house_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:huisgenot/src/view/screens/feed_screen.dart';

class CreateFeedOrEventScreen extends StatefulWidget {
  const CreateFeedOrEventScreen({Key? key}) : super(key: key);

  @override
  _CreateFeedOrEventScreenState createState() =>
      _CreateFeedOrEventScreenState();
}

class _CreateFeedOrEventScreenState extends State<CreateFeedOrEventScreen> {
  String selectedOption = 'Feed'; // Default selected option
  late String imagePath; // To store the selected image path
  DateTime selectedDate = DateTime.now(); // To store the selected date
  FeedController feedController = FeedController();
  EventController eventController = EventController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Function to handle image picking
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  // Function to show date picker
// Function to show date picker
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 161, 196, 126), // header background color
              onPrimary: Color.fromARGB(255, 52, 78, 26), // header text color
              onSurface: Color.fromARGB(255, 52, 78, 26), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 52, 78, 26), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _handleUpload() {
    // Get data from UI
    // Get data from UI
    String title = titleController.text;
    String description = descriptionController.text;
    // Add any other necessary fields
    // Add any other necessary fields
    if (selectedOption == 'Feed') {
      FeedItem newFeed = FeedItem(
        id: '1', //TODO check how to deal with ID
        imageUrl: 'https://example.com/image.jpg',
        postTitle: title,
        postDate: DateTime.now(),
        postAuthor: House(
            id: 'bQQXe4pRe3IRJBU4GCVZ',
            name: 'Logged in user',
            address: 'test',
            description: 'bruuh',
            lat: 0,
            lng: 0), //TODO: change this to the logged in user house id
      );

      // Upload feed only if the selected option is 'Feed'

      feedController.uploadFeed(newFeed);
    } else if (selectedOption == "Event") {
      EventItem newEvent = EventItem(
        id: '1', //TODO check how to deal with ID
        imageUrl: 'https://example.com/image.jpg',
        eventTitle: title,
        eventDescription: description,
        postDate: selectedDate,
        postAuthor: House(
            id: 'bQQXe4pRe3IRJBU4GCVZ',
            name: 'Logged in user',
            address: 'test',
            description: 'bruuh',
            lat: 0,
            lng: 0), //TODO: change this to the logged in user house id
      );

      // Upload feed only if the selected option is 'Feed'

      eventController.uploadFeed(newEvent);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              stops: [0, 1],
            ),
          ),
        ),
        title: const Text('Bericht/evenement plaatsen',
            style: TextStyle(color: Colors.white)),
        leading: Container(
          margin: const EdgeInsets.all(8.0), // Add margin here
          child: IconButton(
            icon: const Icon(Icons.chevron_left, color: Color(0xFFF7F7F7)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wat wil je posten?:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio(
                  value: 'Feed',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value.toString();
                    });
                  },
                ),
                const Text('Bericht',
                    style:
                        TextStyle(color: Color.fromARGB(255, 161, 196, 126))),
                Radio(
                  value: 'Event',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value.toString();
                    });
                  },
                ),
                const Text('Evenement',
                    style:
                        TextStyle(color: Color.fromARGB(255, 161, 196, 126))),
              ],
            ),
            Visibility(
              visible: selectedOption == 'Event',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('Datum:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 161, 196, 126), // Set the background color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                          selectedDate != null
                              ? selectedDate!.toLocal().toString().split(' ')[0]
                              : 'Selecteer datum',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Text('Titel:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            TextField(
              style: TextStyle(color: Color.fromARGB(255, 161, 196, 126)),
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Titel...',
              ),
            ),
            const SizedBox(height: 24.0),
            Text('Omschrijving:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Expanded(
              child: TextField(
                style: TextStyle(color: Color.fromARGB(255, 161, 196, 126)),
                controller: descriptionController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Omschrijving...',
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 52, 78, 26),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _pickImage,
                  borderRadius: BorderRadius.circular(20.0),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_upload, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('Afbeelding uploaden',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _handleUpload,
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 161, 196, 126),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Posten',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
