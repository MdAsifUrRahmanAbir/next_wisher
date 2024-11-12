import 'package:next_wisher/backend/model/common/common_success_model.dart';

import '../../backend/download_file.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../backend/services/wish/mail_index_model.dart';
import '../../backend/services/wish/wish_service.dart';
import '../../utils/basic_screen_imports.dart';
import 'bottom_nav_controller.dart';

class MessageController extends GetxController with WishService, DownloadFile {

  final inboxController = TextEditingController();
  RxInt selectedType = 1.obs;

  @override
  void onInit() {
    mailIndexProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxList<Email> sent = <Email>[].obs;
  RxList<Email> inbox = <Email>[].obs;

  late MailIndexModel _mailIndexModel;
  MailIndexModel get mailIndexModel => _mailIndexModel;

  ///* Get MailIndex in process
  Future<MailIndexModel> mailIndexProcess() async {
    sent.clear();
    inbox.clear();
    _isLoading.value = true;
    update();
    await mailIndexProcessApi().then((value) {
      _mailIndexModel = value!;

      if (LocalStorage.isUser()) {
        for (var e in _mailIndexModel.data.emails) {

          if (LocalStorage.getId() == e.userId.toString()) {
            if (e.role == "user") {
              sent.add(e);
            } else {
              inbox.add(e);
            }
          }
        }
      }else{
        for (var e in _mailIndexModel.data.emails) {

          if (LocalStorage.getId() == e.talentId.toString()) {
            if (e.role == "talent") {
              sent.add(e);
            } else {
              inbox.add(e);
            }
          }
        }
      }

      debugPrint("Total Length: ${_mailIndexModel.data.emails.length}");
      debugPrint("Inbox Length: ${inbox.length}");
      debugPrint("Sent Length: ${sent.length}");

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _mailIndexModel;
  }

  /// ------------------------------------- >>
  final _isSeenLoading = false.obs;
  bool get isSeenLoading => _isSeenLoading.value;

  late CommonSuccessModel _mailSeenModel;
  CommonSuccessModel get mailSeenModel => _mailSeenModel;

  ///* Get MailSeen in process
  Future<CommonSuccessModel> mailSeenProcess(String id) async {
    _isSeenLoading.value = true;
    update();
    await mailSeenProcessApi(id).then((value) {
      _mailSeenModel = value!;
      mailIndexProcess();
      Get.find<BottomNavController>().mailCountProcess();
      _isSeenLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSeenLoading.value = false;
    update();
    return _mailSeenModel;
  }

  /// ------------------------------------- >>
  final _isReplyLoading = false.obs;
  bool get isReplyLoading => _isReplyLoading.value;

  late CommonSuccessModel _mailReplyModel;
  CommonSuccessModel get mailReplyModel => _mailReplyModel;

  ///* MailReply in process
  Future<CommonSuccessModel> mailReplyProcess(String id, String filePath) async {
    _isReplyLoading.value = true;
    update();
    Map<String, String> inputBody = {
      'mail_id': id,
      'instructions': inboxController.text
    };

    await mailReplyProcessApi(body: inputBody, filePath: filePath).then((value) {
      _mailReplyModel = value!;
      _isReplyLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isReplyLoading.value = false;
    update();
    return _mailReplyModel;
  }

  /// ------------------------------------- >>
  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late CommonSuccessModel _ratingSubmitModel;
  CommonSuccessModel get ratingSubmitModel => _ratingSubmitModel;

  ///* RatingSubmit in process
  Future<CommonSuccessModel> ratingSubmitProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'talent_id': '',
      'user_id': '',
      'talent_earning_id': '',
      'rating': '',
      'feedback': ''
    };
    await ratingSubmitProcessApi(body: inputBody).then((value) {
      _ratingSubmitModel = value!;
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _ratingSubmitModel;
  }

  /// ------------------------------------- >>
  final _isDownloadLoading = false.obs;
  bool get isDownloadLoading => _isDownloadLoading.value;

  late CommonSuccessModel _downloadFileModel;
  CommonSuccessModel get downloadFileModel => _downloadFileModel;

  ///* Get DownloadFile in process
  Future<CommonSuccessModel> downloadFileProcess(String path, String id) async {
    _isDownloadLoading.value = true;
    update();
    await downloadFileProcessApi("${path.split("/").last}/$id").then((value) {
      _downloadFileModel = value!;

      _isDownloadLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isDownloadLoading.value = false;
    update();
    return _downloadFileModel;
  }
}
