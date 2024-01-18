import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/house_controller.dart';
import 'package:huisgenot/src/controller/user_controller.dart';
import 'package:huisgenot/src/model/house_model.dart';
import 'package:huisgenot/src/model/user_model.dart';
import 'package:huisgenot/src/view/screens/feed_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final UserController _userController = UserController();
  final HouseController _houseController = HouseController();
  int? _selectedHouseIndex;
  late List<House> allHouses = [];

  @override
  void initState() {
    super.initState();
    // Initialize the list in the initState method
    _houseController.getHouses().listen((List<House> houses) {
      setState(() {
        allHouses = houses;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 24.0,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(_firstNameController, 'Voornaam'),
                const SizedBox(height: 20),
                _buildTextField(_lastNameController, 'Achternaam'),
                const SizedBox(height: 20),
                _buildTextField(_bioController, 'Vertel wat over jezelf'),
                _buildHouseDropdown(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _createProfile(context),
                  child: const Text(
                    'Profiel aanmaken',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildHouseDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: _buildHouseDropdownButton(),
    );
  }

  Widget _buildHouseDropdownButton() {
    if (allHouses.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: EdgeInsets.only(left: 16.0), // Add padding to the left
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField<int>(
        isExpanded: true,
        iconEnabledColor: Color.fromARGB(255, 46, 72, 20),
        items: allHouses.asMap().entries.map((entry) {
          int index = entry.key;
          House house = entry.value;
          return DropdownMenuItem<int>(
            value: index,
            child: Text(
              house.name,
              style: TextStyle(
                color: _selectedHouseIndex == index
                    ? Color.fromARGB(
                        255, 46, 72, 20) // Change the selected text color
                    : Color.fromARGB(255, 161, 196, 126),
              ),
            ),
          );
        }).toList(),
        onChanged: (int? selectedIndex) {
          setState(() {
            _selectedHouseIndex = selectedIndex;
          });
        },
        value: _selectedHouseIndex,
        decoration: InputDecoration(
          hintText: 'Selecteer een huis',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 46, 72, 20),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<void> _createProfile(BuildContext context) async {
    String first_name = _firstNameController.text;
    String last_name = _lastNameController.text;
    String bio = _bioController.text;

    if (first_name.isNotEmpty &&
        last_name.isNotEmpty &&
        bio.isNotEmpty &&
        _selectedHouseIndex != null) {
      House selectedHouse = allHouses[_selectedHouseIndex!];
      User user = User(
        id: '',
        first_name: first_name,
        last_name: last_name,
        bio: bio,
        house_id: selectedHouse.id,
      );

      await _userController.addUserToFirebase(user);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FeedScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Alle velden zijn verplicht',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
