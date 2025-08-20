import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:helpers_hive/profile/controller/helper_profile_controller.dart';
import 'package:helpers_hive/profile/controller/seeker_profile_controller.dart';
import 'package:helpers_hive/utils/widgets/brief_description.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart';
import '../utils/widgets/custom_text_field.dart';
import '../utils/widgets/phone_field.dart';
import 'model/employment_model.dart';

class ProfileScreen extends StatefulWidget {
  final String userRole;
  const ProfileScreen({super.key, required this.userRole});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  HelperProfileController helperProfileController = HelperProfileController();
  SeekerProfileController seekerProfileController = SeekerProfileController();
  bool isEditing = false;
  bool employmentEditing = false;
  final emailController = TextEditingController(text: 'abdulbasit@example.com');
  final countryNameController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final websiteController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  bool isCurrentCompany = true;
  String employmentType = 'Full-Time';
  String selectedCompany = 'Google';
  String selectedNotice = '1 Month';
  final experienceYearsController = TextEditingController();
  final experienceMonthsController = TextEditingController();
  final joiningDateController = TextEditingController();
  final jobTitleController = TextEditingController();
  final salaryController = TextEditingController();
  final List<String> noticeOptions = [
    '15 Days',
    '1 Month',
    '2 Month',
    '3 Month',
    'Serving Notice Period',
  ];
  File? _pickedImage;
  final picker = ImagePicker();
  final dobController = TextEditingController();
  DateTime? selectedDOB;
  final List<String> allRoles = ['Nanny', 'Home Cleaner', 'House Maid'];
  String? selectedStartMonth;
  String? selectedStartYear;
  String? selectedEndMonth;
  String? selectedEndYear;

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<String> years = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
  ]; // Or any range of years you'd prefer
  final TextEditingController briefDescriptionController =
      TextEditingController();
  bool isPresent = false;
  // File? _cvFile;

  // Future<void> _pickCV() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'doc', 'docx'],
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     setState(() {
  //       _cvFile = File(result.files.single.path!);
  //     });
  //   }
  // }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDOB(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDOB ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDOB = picked;
        dobController.text =
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Picture and Name
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              _pickedImage != null
                                  ? FileImage(_pickedImage!)
                                  : const AssetImage('assets/images/logo.png')
                                      as ImageProvider,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Suhel Ahmad',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Conditionally show based on userRole
            if (widget.userRole == 'helpSeeker') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Basic Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: Icon(
                      isEditing ? Icons.close : Icons.edit,
                      color: primaryBg,
                    ),
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (isEditing)
                Column(
                  children: [
                    CustomTextField(
                      label: 'First Name',
                      controller: seekerProfileController.firstNameController,
                    ),
                    CustomTextField(
                      label: 'Middle Name',
                      controller: seekerProfileController.middleNameController,
                    ),
                    CustomTextField(
                      label: 'Last Name',
                      controller: seekerProfileController.lastNameController,
                    ),
                    CustomTextField(
                      label: 'Email',
                      controller: emailController,
                    ),
                    CustomTextField(
                      label: 'Country Name',
                      controller: countryNameController,
                    ),
                    PhoneField(label: 'Phone', controller: phoneController),
                    CustomTextField(
                      label: 'Country',
                      controller: countryController,
                    ),
                    CustomTextField(
                      label: 'Website',
                      controller: websiteController,
                    ),
                    CustomTextField(
                      label: 'Address',
                      controller: addressController,
                    ),
                    CustomTextField(
                      label: 'ZipCode',
                      controller: zipCodeController,
                    ),
                  ],
                ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Personal Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: Icon(
                      isEditing ? Icons.close : Icons.edit,
                      color: primaryBg,
                    ),
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (isEditing)
                Column(
                  children: [
                    CustomTextField(
                      label: 'First Name',
                      controller: helperProfileController.firstNameController,
                    ),
                    CustomTextField(
                      label: 'Middle Name',
                      controller: helperProfileController.middleNameController,
                    ),
                    CustomTextField(
                      label: 'Last Name',
                      controller: helperProfileController.lastNameController,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Male'),
                                  value: 'Male',
                                  groupValue:
                                      helperProfileController
                                          .selectedGender
                                          .value,
                                  activeColor: primaryBg,
                                  onChanged: (value) {
                                    if (value != null)
                                      helperProfileController
                                          .selectedGender
                                          .value = value;
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Female'),
                                  value: 'Female',
                                  groupValue:
                                      helperProfileController
                                          .selectedGender
                                          .value,
                                  activeColor: primaryBg,
                                  onChanged: (value) {
                                    if (value != null)
                                      helperProfileController
                                          .selectedGender
                                          .value = value;
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _selectDOB(context),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          label: 'Date of Birth',
                          controller: helperProfileController.dobController,
                        ),
                      ),
                    ),
                    CustomBriefDescriptionField(
                      label: 'Brief Description (about yourself)',
                      controller: helperProfileController.descriptionController,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selected Roles',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ...allRoles.map((role) {
                            return CheckboxListTile(
                              value: helperProfileController.selectedJobRoles
                                  .contains(role),
                              contentPadding: EdgeInsets.zero,
                              title: Text(role),
                              activeColor: primaryBg,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    helperProfileController.selectedJobRoles
                                        .add(role);
                                  } else {
                                    helperProfileController.selectedJobRoles
                                        .remove(role);
                                  }
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
            if (widget.userRole == 'helper')
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Employment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: Icon(
                      employmentEditing ? Icons.close : Icons.edit,
                      color: primaryBg,
                    ),
                    onPressed: () {
                      setState(() {
                        employmentEditing = !employmentEditing;
                      });
                    },
                  ),
                ],
              ),
            const SizedBox(height: 20),
            if (employmentEditing)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    helperProfileController.experiences.length,
                    (index) => buildEmploymentForm(index),
                  ),
                  if (helperProfileController.experiences.length < 3)
                    TextButton.icon(
                      icon: Icon(Icons.add, color: primaryBg),
                      label: Text(
                        'Add Experience',
                        style: TextStyle(color: primaryBg),
                      ),
                      onPressed: () {
                        setState(() {
                          helperProfileController.experiences.add(
                            EmploymentExperience(),
                          );
                        });
                      },
                    ),
                ],
              ),
            const SizedBox(height: 10),
            // widget.userRole == 'helper'
            //     ? Column(
            //       children: [
            //         const SizedBox(height: 20),
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text(
            //             'Upload CV',
            //             style: TextStyle(
            //               fontSize: 18,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               _cvFile != null
            //                   ? _cvFile!.path.split('/').last
            //                   : 'No file selected',
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //             TextButton.icon(
            //               icon: Icon(Icons.upload_file, color: primaryBg),
            //               label: Text(
            //                 'Choose File',
            //                 style: TextStyle(color: primaryBg),
            //               ),
            //               onPressed: _pickCV,
            //             ),
            //           ],
            //         ),
            //       ],
            //     )
            //     : Container(),
            const SizedBox(height: 20),

            NextButton(label: 'Update', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget buildEmploymentForm(int index) {
    final experience = helperProfileController.experiences[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Employment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            if (helperProfileController.experiences.length > 1)
              IconButton(
                icon: const Icon(Icons.delete, color: primaryBg),
                onPressed: () {
                  setState(() {
                    helperProfileController.experiences.removeAt(index);
                  });
                },
              ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Start Date',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: experience.startMonth,
                        items:
                            months
                                .map(
                                  (month) => DropdownMenuItem(
                                    value: month,
                                    child: Text(month),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (val) =>
                                setState(() => experience.startMonth = val),
                        hint: const Text('Month'),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: experience.startYear,
                        items:
                            years
                                .map(
                                  (year) => DropdownMenuItem(
                                    value: year,
                                    child: Text(year),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (val) => setState(() => experience.startYear = val),
                        hint: const Text('Year'),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'End Date',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Checkbox(
                        value: experience.isPresent,
                        activeColor: primaryBg,
                        onChanged:
                            (val) => setState(() {
                              experience.isPresent = val!;
                              if (val) {
                                experience.endMonth = null;
                                experience.endYear = null;
                              }
                            }),
                      ),
                      const Text(
                        'Present',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      DropdownButton<String>(
                        value: experience.endMonth,
                        items:
                            months
                                .map(
                                  (month) => DropdownMenuItem(
                                    value: month,
                                    child: Text(month),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            experience.isPresent
                                ? null
                                : (val) =>
                                    setState(() => experience.endMonth = val),
                        hint: const Text('Month'),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: experience.endYear,
                        items:
                            years
                                .map(
                                  (year) => DropdownMenuItem(
                                    value: year,
                                    child: Text(year),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            experience.isPresent
                                ? null
                                : (val) =>
                                    setState(() => experience.endYear = val),
                        hint: const Text('Year'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: 'Position',
                controller: experience.positionController,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextField(
                label: 'Employer',
                controller: experience.employerController,
              ),
            ),
          ],
        ),
        CustomTextField(
          label: 'Country',
          controller: experience.countryController,
        ),
        CustomBriefDescriptionField(
          label: 'Job Description',
          controller: experience.jobDescController,
        ),
        const Divider(height: 40, thickness: 1),
      ],
    );
  }
}
