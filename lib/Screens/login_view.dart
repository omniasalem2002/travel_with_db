import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guru/core/component/custom_text_form_field.dart';
import 'package:guru/core/utils/colors_app.dart';
import 'package:guru/core/utils/custom_text_button.dart';
import 'package:guru/core/utils/styles.dart';
import 'package:image_picker/image_picker.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _selectedUserType = '';
  final _birthdateController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedPaymentType;
  File? _image;
  final List<String> _paymentTypes = ['Credit Card', 'PayPal', 'Bank Transfer'];

  final ImagePicker _picker = ImagePicker();
  // Function to handle image selection
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _birthdateController.text = '${pickedDate.toLocal()}'.split(' ')[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                children: [
                const  SizedBox(height: 30,),
          Center(
          child: Container(
              alignment: Alignment.center,
              width: 140,
              height: 140,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(70)),
              child: Image.asset(
                "images/logo_remove.png",
                height: 120,
                width: 120,
                // fit: BoxFit.fill,
              )),
                ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedUserType = 'Tourist';
                          });
                        },
                        icon: const Icon(Icons.person,color: ColorsApp.primaryColor,),
                        label: const Text('Tourist',style: TextStyle(color: ColorsApp.primaryColor),),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => {
                        setState(() {
                        _selectedUserType = 'Tour Guide';
                        }
                        )
                        },
                        icon: const Icon(Icons.map,color: ColorsApp.primaryColor,),
                        label: const Text('Tour Guide',style: TextStyle(color: ColorsApp.primaryColor),),
                      ),
                    ],
                  ),
                  if(_selectedUserType=='Tour Guide')
                    Form(
                      //formKey
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       const SizedBox(height: 20),
                          Container(
                            width: double.infinity, // This makes the container take up the full width
                            child: Align(
                              alignment: Alignment.centerLeft, // Align the text to the start of the container
                              child: Text(
                                "Register",
                                style: Styles.font26LightGreyMedium(context),
                                textAlign: TextAlign.left, // Align text inside the Text widget to the left
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Name", style: Styles.font17GreyRegular(context),),
                          CustomTextFormField(hintText: "enter your name", validator:  (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            if (value.length < 3) {
                              return 'Name must be at least 3 characters long';
                            }
                            return null;
                          },),
                          const SizedBox(height: 20),
                          Text("Phone number", style: Styles.font17GreyRegular(context),),
                          CustomTextFormField(hintText: "enter your Phone number", validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length != 10) { // Adjust length as per your requirement
                              return 'Phone number must be exactly 10 digits';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Phone number must contain only digits';
                            }
                            return null;
                          },
                          ),
                          const SizedBox(height: 20),
                          Text("Date Of Birth", style: Styles.font17GreyRegular(context),),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Birthdate',fillColor: ColorsApp.primaryColor,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: ColorsApp.primaryColor,
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: ColorsApp.primaryColor,
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: ColorsApp.primaryColor,
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            controller: _birthdateController,
                            onTap: _presentDatePicker,
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: _selectedPaymentType,
                            decoration: InputDecoration(
                              labelText: 'Select Payment Type',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: ColorsApp.primaryColor,
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            items: _paymentTypes.map((String type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedPaymentType = value;
                              });
                            },
                          ),
                         const SizedBox(height: 20),
                          _image != null ? Image.file(_image!) : Text('No image selected.',style: TextStyle(color: Colors.red)),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.upload_file,color: ColorsApp.semiPrimaryColor,),
                            label: const Text('Upload Photo',style: TextStyle(color: ColorsApp.semiPrimaryColor),),
                            onPressed: _pickImage,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Email",
                            style: Styles.font17GreyRegular(context),
                          ),
                          CustomTextFormField(
                            hintText: "Enter your email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        const  SizedBox(height: 20),
                          Text(
                            "City",
                            style: Styles.font17GreyRegular(context),
                          ),
                          CustomTextFormField(
                            hintText: "Enter your city",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              }
                              if (value.length < 3) {
                                return 'City must be at least 3 characters long';
                              }
                              return null;
                            },
                          ),
                        const  SizedBox(height: 20),
                          Text(
                            "Personal Website",
                            style: Styles.font17GreyRegular(context),
                          ),
                          CustomTextFormField(
                            hintText: "Enter your personal website",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your personal website';
                              }
                              // Simple URL validation
                              final urlPattern = r'^(http[s]?:\/\/)?([^\s(["<,>]*\.)*[^\s[",><]*\.[^\s[",><]*$';
                              final urlRegExp = RegExp(urlPattern);
                              if (!urlRegExp.hasMatch(value)) {
                                return 'Please enter a valid URL';
                              }
                              return null;
                            },
                          ),
                         const SizedBox(height: 20),
                          Text(
                            "Professional Summary",
                            style: Styles.font17GreyRegular(context),
                          ),
                          CustomTextFormField(
                            hintText: "Enter your professional summary",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your professional summary';
                              }
                              return null;
                            },
                            maxLines: 5,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Work Experience",
                            style: Styles.font17GreyRegular(context),
                          ),
                          CustomTextFormField(
                            hintText: "Enter your work experience",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your work experience';
                              }
                              return null;
                            },
                            maxLines: 5,
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: AppTextButton(
                              buttonText: 'Create',
                              textStyle: Styles.font17GreyRegular(context),
                              backgroundColor: ColorsApp.primaryColor,
                              onPressed: () {
                                //validateThenDoAddDepartment(context);
                              },
                            ),
                          ),

                        ],
                      ),
                    ),

                  if(_selectedUserType=='Tourist')
                   const Text("kkkkkk")

                ],
              )
            ],
          ),
        )
       ),
    );
  }
}
