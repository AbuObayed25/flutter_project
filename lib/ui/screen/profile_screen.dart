import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_2/data/models/network_response.dart';
import 'package:practice_2/data/models/user_model.dart';
import 'package:practice_2/data/services/network_caller.dart';
import 'package:practice_2/data/utils/urls.dart';
import 'package:practice_2/ui/controllers/auth_controller.dart';
import 'package:practice_2/ui/screen/main_bottom_navbar_screen.dart';
import 'package:practice_2/ui/screen/new_task_screen.dart';
import 'package:practice_2/ui/widgets/snack_bar_message.dart';
import 'package:practice_2/ui/widgets/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String name='/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;

  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _phoneTEController.text = AuthController.userData?.Phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text(
                  'Update Profile',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                _buildPhotoPicker(),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: false,
                  controller: _emailTEController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (String?value){
                    if(value?.trim().isEmpty??true){
                      return'Enter your Email';
                    }return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(
                    hintText: 'First name',
                  ),
                  validator: (String?value){
                    if(value?.trim().isEmpty??true){
                      return'Enter your First name';
                    }return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(
                    hintText: 'Last name',
                  ),
                  validator: (String?value){
                    if(value?.trim().isEmpty??true){
                      return'Enter your Last name';
                    }return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneTEController,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                  ),
                  validator: (String?value){
                    if(value?.trim().isEmpty??true){
                      return'Enter your Phone number';
                    }return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: _updateProfileInProgress==false,
                  replacement: CircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateProfile();
                      }
                    },
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );
    _updateProfileInProgress=false;
    setState(() {});
    if(response.isSuccess){
      UserModel userModel = UserModel.fromJson(requestBody);
      await AuthController.saveUserData(userModel);
      showSnackBarMessage(context, "Profile has been updated");
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
  }

  Widget _buildPhotoPicker() => GestureDetector(
    onTap: _pickImage,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "Photo",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Text(_getSelectedPhotoTitle()),
        ],
      ),
    ),
  );

  void _OnTapNextButton() {
    Get.offAllNamed(MainBottomNavbarScreen.name);
  }

  String _getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Select Photo';
  }

  Future<void> _pickImage() async {
    ImagePicker imagepicker = ImagePicker();
    XFile? pickedImage =
    await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }
}
