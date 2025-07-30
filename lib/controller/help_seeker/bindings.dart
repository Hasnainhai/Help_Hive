import 'package:get/get.dart';
import '../../controller/help_seeker/applications_controller.dart';

class HelpSeekerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationsController>(() => ApplicationsController());
  }
}
