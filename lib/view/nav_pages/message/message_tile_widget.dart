import 'dart:async';
import 'package:intl/intl.dart';
import 'package:next_wisher/backend/local_storage/local_storage.dart';

import '../../../backend/services/wish/mail_index_model.dart';
import '../../../controller/bottom_nav/message_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class MessageTileWidget extends StatefulWidget {
  final Email data;
  final Function()? onTap;

  const MessageTileWidget({
    super.key,
    required this.onTap,
    required this.data,
  });

  @override
  MessageTileWidgetState createState() => MessageTileWidgetState();
}

class MessageTileWidgetState extends State<MessageTileWidget> {
  late DateTime targetDate;
  late Timer _timer;
  Duration remainingTime = const Duration();

  @override
  void initState() {
    super.initState();
    targetDate = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(widget.data.createdAt.add(const Duration(days: 5)).toLocal().toString());
    // _calculateRemainingTime();
    if (!widget.data.downloadStatus) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!widget.data.fulfilledAt) {
        _calculateRemainingTime();
      }
    });
  }

  bool isNegative = false;
  void _calculateRemainingTime() {
    setState(() {
      remainingTime = targetDate.difference(DateTime.now().toUtc());
      if (remainingTime.isNegative) {
        _timer.cancel();
        isNegative = true;
      }
    });
  }

  @override
  void dispose() {
    if (!widget.data.downloadStatus) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (remainingTime.isNegative) {
    //   return const Text("Countdown finished", style: TextStyle(color: Colors.red));
    // }

    String days = remainingTime.inDays.toString().padLeft(2, '0');
    String hours = (remainingTime.inHours % 24).toString().padLeft(2, '0');
    String minutes = (remainingTime.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (remainingTime.inSeconds % 60).toString().padLeft(2, '0');

    return ListTile(
      tileColor: !LocalStorage.isUser()
          ? (widget.data.role == "user" && widget.data.seen == 0)
              ? CustomColor.redColor.withValues(alpha: .2)
              : null
          : (widget.data.role == "talent" && widget.data.seen == 0)
              ? CustomColor.redColor.withValues(alpha: .2)
              : null,
      shape: Border.all(
        color: Theme.of(context).primaryColor.withValues(alpha: .2),
        // width: .3,
      ),
      // tileColor: data.seen == 0 ? Colors.red.withValues(alpha: .1) : Colors.transparent,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: TitleHeading2Widget(
          text: getInitials(!LocalStorage.isUser()
              ? (Get.find<MessageController>().selectedType.value == 1)
                  ? widget.data.name
                  : widget.data.talentName
              : (Get.find<MessageController>().selectedType.value == 2)
                  ? widget.data.name
                  : widget.data.talentName),
          textAlign: TextAlign.center,
          color: Colors.white,
        ),
      ),
      onTap: widget.onTap,
      dense: true,
      title: TitleHeading4Widget(
        text: !LocalStorage.isUser()
            ? (Get.find<MessageController>().selectedType.value == 1)
                ? widget.data.name
                : widget.data.talentName
            : (Get.find<MessageController>().selectedType.value == 2)
                ? widget.data.name
                : widget.data.talentName,
        fontWeight: FontWeight.bold,
      ),
      subtitle: TitleHeading5Widget(text: widget.data.instructions, maxLines: 2, textOverflow: TextOverflow.ellipsis),
      trailing: FittedBox(
        child: Column(
          crossAxisAlignment: crossEnd,
          children: [
            TitleHeading5Widget(
              text: DateFormat('dd-MM-yyyy').format(widget.data.createdAt.toLocal()),
              maxLines: 1,
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            TitleHeading5Widget(
                text: widget.data.downloadStatus
                    ? widget.data.settings
                    : isNegative
                        ? "00:00:00:00"
                        : "$days:$hours:$minutes:$seconds",
                color: widget.data.downloadStatus ? Colors.green : Colors.red),
          ],
        ),
      ),
    );
  }
}

/// "$days Days : $hours Hours : $minutes Minutes : $seconds Seconds"
String getInitials(String name) {
  List<String> nameParts = name.split(' '); // Split the name by spaces
  String initials = '';

  if (nameParts.length == 1) {
    // If there's only one word, take the first two letters
    initials = nameParts[0]
        .substring(0, nameParts[0].length < 2 ? nameParts[0].length : 2);
  } else {
    // Take initials of the first two words only, if available
    for (int i = 0; i < nameParts.length && i < 2; i++) {
      if (nameParts[i].isNotEmpty) {
        initials += nameParts[i][0]; // Take the first letter of each part
      }
    }
  }

  return initials.toUpperCase();
}
