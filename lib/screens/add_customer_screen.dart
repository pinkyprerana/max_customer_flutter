import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../core/infrastructure/db_helper.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/app_text_styles.dart';
import '../customWidgets/app_button.dart';
import '../customWidgets/custom_input_field.dart';
import '../customWidgets/name_input_field.dart';
import '../customWidgets/toast.dart';
import '../models/customer_model.dart';

@RoutePage()
class AddCustomerScreen extends StatefulWidget {
   const AddCustomerScreen({super.key});

  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController geoAddressController = TextEditingController();
  File? image;

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() { image = File(pickedFile.path); });
    }
  }

  // Function to get user's current location
  Future<void> _fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToastMessage('Location services are disabled.');
      return;
    }

    // Request permission if not granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToastMessage('Location permission denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showToastMessage('Location permissions are permanently denied.');
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks.first;

    String address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

    // Update text fields with lat & long
    setState(() {
      latController.text = position.latitude.toString();
      longController.text = position.longitude.toString();
      geoAddressController.text = address.toString();
    });
  }

  // Function to save customer data
  void saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      final newCustomer = Customer(
        name: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        address: addressController.text,
        latitude: double.parse(latController.text),
        longitude: double.parse(longController.text),
        geoAddress: geoAddressController.text,
        image: image?.path ?? "",
      );

      final dbHelper = DBHelper();
      await dbHelper.addCustomer(newCustomer);

      showToastMessage('Customer added successfully!');
      await dbHelper.getCustomers();
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            alignment: Alignment.center,
            margin:
            const EdgeInsets.only(top: 10, left: 20, right: 0, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.colorPrimary.withValues(alpha:0.20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                5.horizontalSpace,
                Icon(Icons.arrow_back_ios,
                    color: AppColors.colorPrimary, size: 15.h),
              ],
            ),
          ),
        ),
        title: Text(
          'Add Customer',
          style: AppTextStyles.textStylePoppinsBold.copyWith(
            color: AppColors.colorPrimary,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              NameFormField(
                controller: nameController,
                label: "Full Name",
                hint: "Enter your full name",
                validator: (value) => value!.isEmpty ? "Enter a valid name" : null,
              ),

              10.verticalSpace,
              CustomInputField(
                controller: mobileController,
                label: "Contact Number",
                hint: "Enter contact number",
                maxLength: 10,
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Enter a valid mobile number" : null,
              ),

              10.verticalSpace,
              CustomInputField(
                controller: emailController,
                label: 'Email Address',
                hint: 'Enter email address',
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value!)
                    ? "Enter a valid email"
                    : null,
              ),

              10.verticalSpace,
              CustomInputField(
                controller: addressController,
                label: "Address",
                hint: "Enter address",
                maxLength: 40,
                keyboardType: TextInputType.text,
                validator: (value) => value!.isEmpty ? "Enter address" : null,
              ),

              10.verticalSpace,
              CustomInputField(
                controller: latController,
                label: "Latitude",
                hint: "Enter latitude",
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Capture latitude" : null,
              ),

              10.verticalSpace,
              CustomInputField(
                controller: longController,
                label: "Longitude",
                hint: "Enter longitude",
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Capture longitude" : null,
              ),

              10.verticalSpace,
              CustomInputField(
                controller: geoAddressController,
                label: "Geo Address",
                hint: "Enter geographical address",
                maxLength: 40,
                keyboardType: TextInputType.text,
                validator: (value) => value!.isEmpty ? "Capture location" : null,
              ),

              10.verticalSpace,
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _fetchLocation,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.colorGrey,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: AppColors.colorPrimary,),
                      5.horizontalSpace,
                      Text(
                            'Fetch Location',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.textStylePoppinsBold.copyWith(
                              fontSize: 15.sp,
                              color: AppColors.colorPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    ],
                  ),
                ),
              ),

              10.verticalSpace,
              if (image != null) Image.file(image!, height: 100),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _pickImage,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.colorGrey,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: AppColors.colorPrimary,),
                      5.horizontalSpace,
                      Text(
                        'Pick Image',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textStylePoppinsBold.copyWith(
                          fontSize: 15.sp,
                          color: AppColors.colorPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              10.verticalSpace,
              AppButton(
                onPressed: saveCustomer,
                text: "Save Customer",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
