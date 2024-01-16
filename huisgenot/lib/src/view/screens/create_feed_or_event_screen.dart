import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateFeedOrEventScreen extends StatefulWidget {
  const CreateFeedOrEventScreen({Key? key}) : super(key: key);

  @override
  _CreateFeedOrEventScreenState createState() =>
      _CreateFeedOrEventScreenState();
}

class _CreateFeedOrEventScreenState extends State<CreateFeedOrEventScreen> {
  String selectedOption = 'Feed'; // Default selected option
  late String imagePath; // To store the selected image path
  DateTime? selectedDate; // To store the selected date

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
    // Implement the logic for handling the upload action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Feed or Event'),
        // Add any additional styling you want for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Type:',
              style: Theme.of(context).textTheme.subtitle1,
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
                const Text('Feed'),
                Radio(
                  value: 'Event',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value.toString();
                    });
                  },
                ),
                const Text('Event'),
              ],
            ),
            Visibility(
              visible: selectedOption == 'Event',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date:',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.orange, // Set the background color
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        selectedDate != null
                            ? selectedDate!.toLocal().toString().split(' ')[0]
                            : 'Select Date',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Title:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter title...',
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter description...',
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_upload, color: Colors.white),
                        const SizedBox(width: 8.0),
                        Text('Upload Picture here', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: _handleUpload,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'UPLOAD',
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
