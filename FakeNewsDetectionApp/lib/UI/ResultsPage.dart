import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultsPage extends StatefulWidget {
  final int userId;
  const ResultsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List predictions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPredictions();
  }

  Future<void> fetchPredictions() async {
    try {
      final url =
      Uri.parse('http://10.0.2.2:5017/api/Prediction/${widget.userId}');
      final response = await http.get(url, headers: {
        "accept": "text/plain",
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          predictions = data;
          isLoading = false;
        });

        // Listeyi animasyonlu şekilde doldur
        Future.delayed(Duration.zero, () {
          for (int i = 0; i < predictions.length; i++) {
            _listKey.currentState?.insertItem(i, duration: Duration(milliseconds: 300 + i * 100));
          }
        });
      } else {
        setState(() => isLoading = false);
        print("API Hatası: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("Hata: $e");
    }
  }

  Future<void> deletePrediction(int predictionId, int index) async {
    try {
      final url =
      Uri.parse('http://10.0.2.2:5017/api/Prediction/$predictionId');
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        final removedItem = predictions.removeAt(index);
        _listKey.currentState?.removeItem(
          index,
              (context, animation) => _buildItem(removedItem, index, animation),
          duration: const Duration(milliseconds: 500),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tahmin başarıyla silindi.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Silme hatası: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  Widget _buildItem(dynamic item, int index, Animation<double> animation) {
    final isReal = item["predictionResult"] == "Gerçek";

    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
                  item["text"] ?? "",
                  style: const TextStyle(fontSize: 16),
                )),
            Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isReal ? Colors.green.shade600 : Colors.red.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item["predictionResult"] ?? "",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Silme Onayı'),
                        content: const Text(
                            'Bu tahmini silmek istediğinize emin misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('İptal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              deletePrediction(item['id'], index);
                            },
                            child: const Text('Sil',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonuçlar'),
        backgroundColor: Colors.green.shade700,
        elevation: 6,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade800, Colors.greenAccent.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? const Center(
            child: CircularProgressIndicator(color: Colors.white))
            : predictions.isEmpty
            ? const Center(
          child: Text(
            "Tahmin bulunamadı.",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
            : AnimatedList(
          key: _listKey,
          initialItemCount: predictions.length,
          itemBuilder: (context, index, animation) {
            return _buildItem(predictions[index], index, animation);
          },
        ),
      ),
    );
  }
}
