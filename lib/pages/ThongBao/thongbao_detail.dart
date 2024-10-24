import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ThongBaoDetailPage extends StatelessWidget {
  final String? tieuDe;
  final String? noiDung;
  final String? date1;

  const ThongBaoDetailPage({
    Key? key,
    this.tieuDe,
    this.noiDung,
    this.date1,
  }) : super(key: key);

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return date;
    }
  }

 void _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

  List<TextSpan> _buildTextSpans(String text) {
    final List<TextSpan> spans = [];
    final RegExp urlRegExp = RegExp(
      r'(https?:\/\/[^\s]+)',
      caseSensitive: false,
    );

    final matches = urlRegExp.allMatches(text);
    int start = 0;

    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: const TextStyle(color: Colors.black),
        ));
      }

      final String url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.none,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _launchURL(url); 
            },
        ),
      );

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: const TextStyle(color: Colors.black),
      ));
    }

    return spans;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: TitleAppBarWidget(title: tieuDe ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: _buildTextSpans(noiDung ?? ''),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      height: 1.4,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              color: Colors.grey.shade400,
              thickness: 0.5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _formatDate(date1),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                      height: 1.4,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
