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
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
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
            id: '1',
            name: 'Logged in user',
            address: 'test',
            description:
                'bruuh'), //TODO: change this to the logged in user house id
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
            id: '1',
            name: 'Logged in user',
            address: 'test',
            description:
                'bruuh'), //TODO: change this to the logged in user house id
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
        title: const Text('Bericht posten'),
        // Add any additional styling you want for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wat wil je posten?:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
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
                const Text('Bericht'),
                Radio(
                  value: 'Event',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value.toString();
                    });
                  },
                ),
                const Text('Evenement'),
              ],
            ),
            Visibility(
              visible: selectedOption == 'Event',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Datum:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.green, // Set the background color
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        selectedDate != null
                            ? selectedDate!.toLocal().toString().split(' ')[0]
                            : 'Selecteer datum',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Titel:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Titel...',
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Omschrijving:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: TextField(
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
                color: Colors.lightGreen,
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
                  backgroundColor: Colors.green,
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
