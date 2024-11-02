
import '../../utils/basic_screen_imports.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ProfileSetupScreenState createState() => ProfileSetupScreenState();
}

class ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: TitleHeading3Widget(text: (_currentStep + 1).toString(), color: CustomColor.whiteColor),
          ),
        ),
        title: TitleHeading3Widget(text: _currentStep == 0 ? "Add Profile Picture" : _currentStep == 1 ? "Add Profile Video" : _currentStep == 2 ? "Add Biography" : "Select Languages",),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStep1(),
            _buildStep2(),
            _buildStep3(),
            _buildStep4(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentStep > 0) // Show Back button from Step 2 onward
              TextButton(
                onPressed: _previousStep,
                child: const Text('Back'),
              ),
            const Spacer(),
            if (_currentStep < 3) // Show Next button for all but last step
              TextButton(
                onPressed: _nextStep,
                child: const Text('Next'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(Dimensions.radius),
            onTap: (){
              
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * .7,
              height: MediaQuery.sizeOf(context).height * .5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                color: Theme.of(context).primaryColor
              ),
              child: const TitleHeading3Widget(text: "Select Profile Picture", color: CustomColor.whiteColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(Dimensions.radius),
            onTap: (){

            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * .7,
              height: MediaQuery.sizeOf(context).height * .5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  color: Theme.of(context).primaryColor
              ),
              child: const TitleHeading3Widget(text: "Select Profile Video", color: CustomColor.whiteColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading3Widget(text: 'Biography'),
          SizedBox(height: 20),
          TextField(
            maxLines: 8,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your biography',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep4() {
    List<String> languages = ['English', 'Spanish', 'French', 'Portuguese'];
    List<String> selectedLanguages = [];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: crossStart,
        children: [
          const TitleHeading4Widget(text: 'Please select all languages in which you can respond to a request'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8.0,
            children: languages.map((language) {
              bool isSelected = selectedLanguages.contains(language);
              return FilterChip(
                label: Text(
                  language,
                  style: TextStyle(
                    color: isSelected ? Colors.green : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedLanguages.add(language);
                    } else {
                      selectedLanguages.remove(language);
                    }
                    debugPrint(language);
                    debugPrint(selected.toString());
                    debugPrint(isSelected.toString());
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

}