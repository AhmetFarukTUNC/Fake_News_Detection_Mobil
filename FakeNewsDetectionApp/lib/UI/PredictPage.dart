import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ResultsPage.dart';

class PredictPage extends StatefulWidget {
  final int userId;
  const PredictPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  String _result = '';

  Future<void> makePrediction() async {
    if (_textController.text.isEmpty) {
      setState(() => _result = "Lütfen bir metin girin!");
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final url = Uri.parse("http://10.0.2.2:5017/api/prediction");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "text": _textController.text,
          "userId": widget.userId,
        }),
      );

      if (response.statusCode == 200) {
        setState(() => _result = "Tahmin başarılı!");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(userId: widget.userId),
          ),
        );
      } else {
        setState(() => _result = "API Hatası: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _result = "Hata: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahmin Yap'),
        backgroundColor: Colors.green.shade700,
        elevation: 6,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade800, Colors.greenAccent.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Tahmin yapmak için metin girin',
                filled: true,
                fillColor: Colors.white.withOpacity(0.9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : ElevatedButton(
              onPressed: makePrediction,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                shadowColor: Colors.black87,
              ),
              child: const Text(
                'Tahmin Et',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
