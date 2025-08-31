import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkımızda'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blueAccent.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hakkımızda',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Bu mobil uygulama, kullanıcıların haber metinlerini analiz ederek sahte ve gerçek haberleri ayırt etmelerine yardımcı olur. '
                    'Hedefimiz, bilgi kirliliğini azaltmak ve güvenilir içerik erişimini kolaylaştırmaktır.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Kullanıcı Deneyimi:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '• Mobil cihazlarda hızlı ve kolay kullanım.\n'
                    '• Basit ve modern arayüz ile tahmin sonuçlarını hızlı görüntüleme.\n'
                    '• Kullanıcıya özel tahmin geçmişi ve kişiselleştirilmiş içerik.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Özellikler:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Haber tahmini yapabilme', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text('• Tahmin sonuçlarını detaylı şekilde görüntüleme', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text('• Kullanıcı ID ile kişiselleştirilmiş deneyim', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text('• Hızlı ve güvenilir API entegrasyonu', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text('• Veri güvenliği ve gizliliğe odaklı tasarım', style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Gelecek Planları:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '• Daha fazla dil ve platform desteği.\n'
                    '• Tahmin modelinin doğruluk oranını artırmak.\n'
                    '• Kullanıcı geri bildirimlerine dayalı geliştirmeler.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                'Geliştiriciler: Ömer Faruk Çırpan & Ahmet Faruk TUNC',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              Text(
                'Tarih: 2025',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
