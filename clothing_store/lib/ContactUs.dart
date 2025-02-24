import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/Nav_bar_bottom.dart';
import 'package:webmax_store/Store.dart';
import 'package:webmax_store/messagespop/success.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  final String username = 'mailapi348@gmail.com';
  final String password = 'lhhoqgnfyjfgpvvg';

  void _sendMessage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
    if (_formKey.currentState!.validate()) {
      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address(username, 'Your name')
        ..recipients.add(_emailController.text)
        ..subject = 'From WM Store :😀'
        ..text = 'This is the plain text.\nThis is line 2 of the text part.'
        ..html =
            "<h4>From ${_fullNameController.text}</h4> \n<p>${_emailController.text}</p>\n<p>${_messageController.text}</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
        SuccessscaffMessenger(context, 'Message sent successfully!', 5);
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message.')),
        );
      }
    }
  }

  InputDecoration inputdecoration(Icon textfieldIcon, String textlabel) {
    return InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      prefixIcon: textfieldIcon,
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 0.0),
      ),
      filled: true,
      fillColor: Colors.white,
      labelText: textlabel,
      labelStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: redcolor,
        elevation: 0,
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _fullNameController,
                decoration: inputdecoration(
                    Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    'Full Name'),
                maxLines: 1,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Full Name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                decoration: inputdecoration(
                    const Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                    'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.black,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Message',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
                maxLines: 6,
                minLines: 6,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _sendMessage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0XFF82C9D2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.only(
                          left: 100, right: 100, top: 10, bottom: 10),
                      child: Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
