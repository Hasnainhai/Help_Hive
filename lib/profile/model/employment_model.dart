import 'package:flutter/cupertino.dart';

class EmploymentExperience {
  String? startMonth;
  String? startYear;
  String? endMonth;
  String? endYear;
  bool isPresent = false;

  TextEditingController positionController = TextEditingController();
  TextEditingController employerController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController jobDescController = TextEditingController();
}
