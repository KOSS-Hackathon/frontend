import 'package:flutter/material.dart';
import 'package:menurecommend/screen/result_screen.dart';

class AddquestionScreen extends StatefulWidget {
  const AddquestionScreen({super.key});

  @override
  State<AddquestionScreen> createState() => _AddquestionScreenState();
}

class _AddquestionScreenState extends State<AddquestionScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                  decoration: BoxDecoration(
                    color: Color(0xFFE9EEFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    '추가 사항을 알려줘!!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B2B2B),
                    ),
                  ),
                ),
              ),
              Align (
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/add.png',
                  height: 300,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: GestureDetector(
                  onTap: () {
                    String additionalInfo = _textController.text;
                    debugPrint('입력된 내용: $additionalInfo');

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ResultScreen()),
                    );
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF5B8DEF),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text('완료', style: TextStyle(color: Color(0xFFFFFFFF)),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}