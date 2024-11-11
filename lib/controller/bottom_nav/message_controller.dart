import 'package:get/get.dart';
import 'package:next_wisher/backend/model/common/common_success_model.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/services/wish/mail_index_model.dart';
import '../../backend/services/wish/wish_service.dart';
import '../../utils/basic_screen_imports.dart';

class MessageController extends GetxController with WishService {
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
    _isLoading.value = true;
    update();
    await mailIndexProcessApi().then((value) {
      _mailIndexModel = value!;

      for (var e in _mailIndexModel.data.emails) {
        debugPrint(" ID: ${LocalStorage.getId()}");
        debugPrint(" ID: ${LocalStorage.getId() == e.userId.toString()}");
        if(LocalStorage.getId() == e.userId.toString()){
          if(e.role == "user"){
            sent.add(e);
          }else{
            inbox.add(e);
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
  Future<CommonSuccessModel> mailReplyProcess() async {
    _isReplyLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'mail_id': '',
      'instructions': '',
      'attachment': ''
    };
    await mailReplyProcessApi(body: inputBody).then((value) {
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


}