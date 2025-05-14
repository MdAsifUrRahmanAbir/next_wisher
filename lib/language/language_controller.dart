import 'package:get_storage/get_storage.dart';

import '../../utils/basic_screen_imports.dart';
import 'language_model.dart';
import 'language_service.dart';

final LanguageSettingController languageSettingController = Get.put(LanguageSettingController(), permanent: true);

class LanguageSettingController extends GetxController {
  RxString selectedLanguage = "".obs; // Selected language is English
  RxString defLangKey = "".obs; // Default language is English

  @override
  void onInit() {
    fetchLanguages().then((value) {});
    super.onInit();
  }

  List<Language> languages = [];
  var isLoadingValue = false.obs;

  bool get isLoading => isLoadingValue.value;
  static const String selectedLanguageKey = 'selectedLanguage';

  Future<void> fetchLanguages() async {
    isLoadingValue.value = true;
    try {
      final languageService = LanguageService();
      languages = await languageService.fetchLanguages();
      getDefaultKey();
      isLoadingValue.value = false;
    } catch (e) {
      debugPrint('Error fetching language data: $e');
    }
  }

  // >> get default language key
  String getDefaultKey() {
    isLoadingValue.value = true;
    final selectedLang = languages.firstWhere(
          (lang) => lang.name == "english",
      orElse: () => languages.firstWhere(
            (lang) => lang.name == "english",
      ), // Fallback to language default code, when status true.
    );
    defLangKey.value = selectedLang.name;

    // Load selected language from cache
    final box = GetStorage();
    selectedLanguage.value = box.read(selectedLanguageKey) ?? defLangKey.value;
    isLoadingValue.value = false;
    return selectedLang.name;
  }

  void changeLanguage(String newLanguage) {
    selectedLanguage.value = newLanguage;
    final box = GetStorage();
    box.write(selectedLanguageKey, newLanguage);
    // LocalStorages.saveRtl(type: languageDirection == 'rtl' ? true : false);
    update();

  }

  String getTranslation(String key) {
    final selectedLang = languages.firstWhere(
          (lang) => lang.name == selectedLanguage.value,
      orElse: () => languages.firstWhere(
            (lang) => lang.name == defLangKey.value,
      ),
    );

    final defaultLanguage = languages.firstWhere(
          (lang) => lang.name == 'english',
      orElse: () => languages.firstWhere(
            (lang) => lang.name == 'english',
      ),
    );

    String value;
    if (selectedLang.translateKeyValues[key] == '' ||
        selectedLang.translateKeyValues[key] == null) {
      value = defaultLanguage.translateKeyValues[key] ?? key;
    } else {
      value = selectedLang.translateKeyValues[key] ?? key;
    }

    return value;
  }
  //
  // /// Get text direction [ when selected language null return default direction ]
  // TextDirection get languageDirection {
  //   isLoadingValue.value = true;
  //   try {
  //     final selectedLang = languages.firstWhere(
  //           (lang) => lang.code == selectedLanguage.value,
  //       orElse: () => languages.firstWhere(
  //             (lang) => lang.code == defLangKey.value,
  //       ),
  //     );
  //     isLoadingValue.value = false;
  //     // LocalStorages.saveRtl(type: selectedLang.dir == 'rtl' ? true : false);
  //     update();
  //     return selectedLang.dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr;
  //   } catch (e) {
  //     return TextDirection.ltr; // Fallback to left-to-right (LTR)
  //   }
  // }
}