import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../../backend/services/wish/mail_index_model.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class UserInboxScreen extends StatefulWidget {
  const UserInboxScreen({super.key, required this.data});

  final Email data;

  @override
  State<UserInboxScreen> createState() => _UserInboxScreenState();
}

class _UserInboxScreenState extends State<UserInboxScreen> {

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PrimaryAppBar(),
        body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
          children: [
            TitleHeading3Widget(text: widget.data.userName, color: Theme.of(context).primaryColor),
            verticalSpace(Dimensions.paddingSizeVertical * .4),


            Container(
              height: MediaQuery.sizeOf(context).height * .3,
              color: Theme.of(context).primaryColor.withOpacity(.6),
              child: Chewie(
                controller: chewieController,
              ),
            ),


            widget.data.name.isNotEmpty
                ? Column(
              children: [
                _row(Strings.name, widget.data.name),
                verticalSpace(Dimensions.paddingSizeVertical * .2),
              ],
            )
                : Column(
              children: [
                _row(Strings.forText, widget.data.emailFor),
                verticalSpace(Dimensions.paddingSizeVertical * .2),
                _row(Strings.from, widget.data.from),
                verticalSpace(Dimensions.paddingSizeVertical * .2),
              ],
            ),

            _row(Strings.gender, widget.data.genders),
            verticalSpace(Dimensions.paddingSizeVertical * .2),

            _row(Strings.occasion, widget.data.occasion),
            verticalSpace(Dimensions.paddingSizeVertical * .2),

            _row(Strings.message, widget.data.instructions),
          ],
        )));
  }

  _row(String title, String value){
    return Row(
      children: [
        TitleHeading4Widget(text: "$title: ", fontWeight: FontWeight.bold),
        horizontalSpace(Dimensions.paddingSizeHorizontal * .2),
        Expanded(child: TitleHeading5Widget(text: value, opacity: .7,)),
      ],
    );
  }

  void _initVideo() {
    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.data.attachment)
      // Uri.parse("https://next-wisher.skyflightbd.com/public/uploads/1730566102.mp4"),
    )
      ..initialize();

    chewieController = ChewieController(
      // aspectRatio: 1,
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
    );

    setState(() {

    });
  }
}
