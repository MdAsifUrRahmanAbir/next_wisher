import '../../../backend/services/dashboard/home_model.dart';
import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';

import '../../../utils/strings.dart';
import '../../talent_profile/talent_profile.dart';


class FeaturedCelebritiesScreen extends StatelessWidget {
   FeaturedCelebritiesScreen({super.key});
  final controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PrimaryTextInputWidget(
                controller: TextEditingController(), labelText: Strings.search),
            Expanded(
              child: GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: .65,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15),
                itemBuilder: (context, index) {
                  HomeTalent data = controller.homeModel.data.homeTalents[index];
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
                itemCount: controller.homeModel.data.homeTalents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}