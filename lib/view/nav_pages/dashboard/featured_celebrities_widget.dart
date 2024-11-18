import '../../../backend/services/dashboard/home_model.dart';
import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';
import '../../talent_profile/talent_profile.dart';
import 'featured_celebrities_screen.dart';

class FeaturedCelebritiesWidget extends StatelessWidget {
  const FeaturedCelebritiesWidget({super.key, required this.controller});
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            TitleHeading3Widget(
                text: Strings.featuredCelebrities, padding: const EdgeInsets.all(2)),
            Visibility(
              visible: controller.homeModel.data.homeTalents.length.isGreaterThan(4),
              child: TextButton(
                onPressed: () {
                  controller.talentList.value  = controller.homeModel.data.homeTalents;
                  Get.to(FeaturedCelebritiesScreen());
                },
                child: TitleHeading5Widget(text: Strings.seeAll),
              ),
            )
          ],
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: .65,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15),
          itemBuilder: (context, index) {
            HomeTalent data = controller.talentList[index];
            return GestureDetector(
              onTap: () {
                controller.talentsProcess(data.userId.toString());
                Get.to(TalentProfile());
              },
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data.profileImage),
                              fit: BoxFit.cover),
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius * .4)),
                    ),
                  ),
                  TitleHeading3Widget(
                      text: data.name,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis),
                  data.amount.isEmpty
                      ? const SizedBox(
                          height: 25,
                        )
                      : TitleHeading3Widget(
                          text:
                              "\$${data.amount.first.amount.toStringAsFixed(2)}",
                          fontWeight: FontWeight.bold),
                ],
              ),
            );
          },
          itemCount:
              controller.talentList.length.isGreaterThan(4)
                  ? 4
                  : controller.talentList.length,
        ),
      ],
    ));
  }
}