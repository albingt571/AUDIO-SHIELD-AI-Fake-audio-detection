import 'package:flutter/material.dart';

class LegalInformation extends StatelessWidget {
  const LegalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal Information', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/image/backgroundimage.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle('Privacy Policy'),
                SizedBox(height: 8.0),
                SubsectionTitle('Effective date: Feb 01, 2024'),
                SizedBox(height: 12.0),
                StyledText(
                  '''\nWelcome to our AI Fake Audio Detection app. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.
                  \n Information We Collect:
                  \n - Personal Information: We may collect personal information such as your name, email, and user preferences.
                  \n - Non-Personal Information: We may collect non-personal information related to app usage for analytics purposes.

                  \n How We Use Your Information:
                  \n - Provide personalized services based on your preferences.
                  \n - Improve our AI models through aggregated usage data.
                  \n - Notify you about app updates, analysis results, and important announcements.

                  \n Your Choices:
                  \n You can control your personal information through the app settings.

                  [Add more details regarding user choices and controls.]

                  \n Security:
                  \n We prioritize the security of your information and follow industry best practices to protect it.


                  \n Changes to This Privacy Policy:
                  \n We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.


                  \n Contact Us:
                  \n If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at 123-456-789.

                  Last updated: Feb 01, 2024
                  ''',
                ),
                SizedBox(height: 16.0),
                SectionTitle('Terms of Service'),
                SizedBox(height: 8.0),
                SubsectionTitle('Effective date: Feb 01, 2024'),
                SizedBox(height: 12.0),
                StyledText(
                  '''
                  \n Acceptance of Terms:
                  \n By accessing or using the app, you agree to be bound by these Terms. If you disagree with any part of the terms, then you may not access the app.

                  \n User Conduct:
                  \n You agree not to misuse the app, including uploading malicious audio files.

                  \n Termination:
                  \n We reserve the right to terminate or suspend your access to the app for any reason without notice.

                  \n Disclaimer:
                  \n The AI analysis results are provided for informational purposes and may not be 100% accurate.

                  \n Changes to These Terms:
                  \n We may update our Terms of Service from time to time. We will notify you of any changes by posting the new Terms of Service on this page.
              
                  \n Contact Us:
                  \n If you have any questions or suggestions about our Terms of Service, do not hesitate to contact us at 123-456-789.

                  Last updated: Feb 01, 2024
                  ''',
                ),
                // Add more legal information sections as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      textAlign: TextAlign.start,
    );
  }
}

class SubsectionTitle extends StatelessWidget {
  final String title;

  const SubsectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.start,
    );
  }
}

class StyledText extends StatelessWidget {
  final String text;

  const StyledText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}
