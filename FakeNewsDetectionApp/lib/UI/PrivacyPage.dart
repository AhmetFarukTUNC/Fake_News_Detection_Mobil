import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gizlilik Politikası'),
        backgroundColor: Colors.orange.shade600,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade800, Colors.orangeAccent.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gizlilik Politikası',
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
                'Bu uygulama, kullanıcıların verilerini gizli tutmayı ve üçüncü taraflarla paylaşmamayı taahhüt eder. '
                    'Kullanıcı verileri yalnızca tahmin yapmak, geçmiş tahminleri kaydetmek ve uygulama deneyimini kişiselleştirmek için kullanılır.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Toplanan Veriler:',
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
                  Text('• Kullanıcı ID', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text('• Girilen haber metni', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text('• Tahmin sonuçları', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text('• Uygulama kullanım istatistikleri (opsiyonel)', style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Verilerin Kullanımı:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Toplanan veriler, aşağıdaki amaçlar için kullanılır:\n'
                    '• Kullanıcıya özel tahmin sonuçları sağlamak\n'
                    '• Tahmin geçmişini ve uygulama kullanımını kaydetmek\n'
                    '• Uygulama performansını ve doğruluk oranını artırmak\n'
                    '• Yeni özelliklerin geliştirilmesi ve kullanıcı deneyiminin iyileştirilmesi',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Veri Güvenliği:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Kullanıcı verileri güvenli sunucularda şifrelenmiş olarak saklanır ve yetkisiz erişimlere karşı korunur. '
                    'Veriler asla izinsiz üçüncü taraflarla paylaşılmaz ve sadece belirtilen amaçlar için kullanılır.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Kullanıcı Hakları:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Kullanıcılar, istedikleri zaman kişisel verilerini görüntüleme, düzeltme veya silme hakkına sahiptir. '
                    'Ayrıca uygulamanın veri kullanım politikaları hakkında bilgi talep edebilirler.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Üçüncü Taraf Hizmetler:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Uygulama, veri analizinde ve tahmin modelinde üçüncü taraf servisleri kullanabilir. '
                    'Ancak kullanıcı verileri bu servislerle paylaşılmaz veya anonimleştirilmeden gönderilmez.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                'Geliştirici: Ömer Faruk  & Ahmet Faruk TUNC',
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
