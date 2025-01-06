import 'package:flutter/material.dart';

class HelpFAQPage extends StatefulWidget {
  const HelpFAQPage({super.key});

  @override
  _HelpFAQPageState createState() => _HelpFAQPageState();
}

class _HelpFAQPageState extends State<HelpFAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help/FAQ'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/image/backgroundimage.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var faq in faqs)
                  FAQItem(
                    question: faq['question'] ?? '',
                    answer: faq['answer'] ?? '',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(answer, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        Divider(
          color: Colors.blue.shade800,
        ),
      ],
    );
  }
}

// Sample FAQs data
final List<Map<String, String>> faqs = [
  {
    'question': 'What is the purpose of this app?',
    'answer': 'The app is designed to detect fake audio and provide insights into the authenticity of audio files.',
  },
  {
    'question': 'How do I upload an audio file?',
    'answer': 'Navigate to the "Upload Audio" section and follow the on-screen instructions to upload your file.',
  },
  {
    'question': 'How long does the analysis take?',
    'answer': 'The analysis duration depends on the size and complexity of the audio file. It usually takes a few moments.',
  },
  {
    'question': 'Can I analyze multiple audio files simultaneously?',
    'answer': 'Currently, the app supports the analysis of one audio file at a time.',
  },
  {
    'question': 'What types of audio files are supported?',
    'answer': 'The app supports common audio formats such as MP3, WAV, and FLAC.',
  },
  {
    'question': 'How accurate is the fake audio detection?',
    'answer': 'The accuracy depends on various factors. The app utilizes advanced AI algorithms for reliable results.',
  },
  {
    'question': 'Are my uploaded audio files stored?',
    'answer': 'No, the app does not store your uploaded audio files. Your privacy is important to us.',
  },
  {
    'question': 'How can I provide feedback or report issues?',
    'answer': 'Navigate to the "Feedback" section in the navigation drawer and follow the instructions to submit your feedback or report issues.',
  },
  {
    'question': 'Is the app available on multiple platforms?',
    'answer': 'Currently, the app is available on Android and iOS platforms.',
  },
  {
    'question': 'Can I use the app offline?',
    'answer': 'Certain features may require an internet connection, but the app supports basic functionalities offline.',
  },
];
