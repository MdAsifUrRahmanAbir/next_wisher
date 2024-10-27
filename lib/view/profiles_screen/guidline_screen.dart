import '../../../controller/bottom_nav/message_controller.dart';
import '../../../utils/basic_screen_imports.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class GuidelineScreen extends StatelessWidget {
  const GuidelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          HtmlWidget(guideText)
        ],
      ),
    );
  }
}


String guideText = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Guide</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
    }
    h2 {
      color: #333;
    }
    p {
      margin: 10px 0;
    }
    ul {
      margin: 10px 0 20px 20px;
    }
    .highlight {
      font-weight: bold;
      font-style: italic;
      color: #0056b3;
    }
  </style>
</head>
<body>

  <h2>GUIDE</h2>

  <p>As a talent, you will be able to activate up to two (2) options:</p>

  <ul>
    <li>Personalized videos/wishes</li>
    <li>Tips</li>
  </ul>

  <p>Please note that only the options that you choose to activate will be visible on your profile and accessible to users.</p>

  <p>You cannot activate the tip option alone. If you do so without activating the personalized video, it will not work and will not display on your profile. However, you can activate the personalized video without the tip option if you wish not to have it.</p>

  <h3>PERSONALIZED VIDEOS/WISHES</h3>

  <p>As a talent, you will receive wishes requests from users or fans.</p>
  <p>You will have 120 hours (five days) to fulfill their requests and send the wish video to the person who requested it.</p>
  <p>We will hold payments made by any user until the request is fulfilled on time. If not, the requester will be refunded.</p>

  <p><strong>Amount:</strong> The minimum amount for a wish request is set to €30. The maximum is set to €2500.</p>

  <p>Make sure to always check your email for notifications and also respond to the wishes requests on time.</p>

  <p>Please make sure to carefully review the instructions before making the video to avoid any mistake. If you make a mistake (wrong name or anything else), we will ask you to redo the video at no charge if the purchaser requests it. Do not forget that you will get reviews based on what you offer.</p>

  <p class="highlight">Keep in mind that people who request a wish from you are fans, and they love you. Please show them some love while making the video and just be yourself.</p>

  <p>Please note that to be able to accept wish requests, you will have to activate the wish request option on your dashboard.</p>

  <h3>TIPS</h3>

  <p>As a talent, you can receive Tips from anyone. The minimum you can receive for tips per transaction is €10 and the maximum is set to €500.</p>

  <p>Please note that to be able to accept tips, you will have to activate the tip option on your dashboard.</p>

  <p>As a talent, you cannot order a video or send tips to other talents. If you wish to do this, you will need to create a user account.</p>

  <h3>EARNINGS</h3>

  <p>You keep 75% of your total revenue. The remaining 25% and any service, transaction, or order processing fee will go to Nextwisher. The minimum amount to request a payout is €25.</p>

  <p>Please note that the currency used is Euro (€). However, you will receive your payments in the local currency of the country where you live, according to the conversion rate in place on the day of payment.</p>

  <p>You must have a PayPal or a bank account to receive your payments. We also offer mobile payment for Côte d'Ivoire, Senegal, Cameroon, and Benin.</p>

  <p>Revenue generated from Wishes/Personalized videos will first appear in the “Pending” tab on your dashboard until the videos are delivered within 5 days of the request. Then it will automatically move to the “Revenue” tab once the requester gets the video.</p>

  <h3>PAYOUT PROCESSING TIME</h3>

  <p>5 to 10 business days.</p>

</body>
</html>
''';