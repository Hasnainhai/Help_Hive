import 'package:get/get.dart';

class JobController extends GetxController {
  // Track bookmark states by job index
  RxList<bool> bookmarks = <bool>[].obs;

  // Initialize bookmarks with false values
  void initializeBookmarks(int length) {
    bookmarks.assignAll(List.filled(length, false));
  }

  // Toggle bookmark state
  void toggleBookmark(int index) {
    bookmarks[index] = !bookmarks[index];
  }
}
