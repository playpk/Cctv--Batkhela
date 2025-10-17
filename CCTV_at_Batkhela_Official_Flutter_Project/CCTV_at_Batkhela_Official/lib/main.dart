
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isEnglish = false;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _loadLang();
  }

  Future<void> _loadLang() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isEnglish = prefs.getBool('isEnglish') ?? false;
      loaded = true;
    });
  }

  Future<void> _toggleLang() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isEnglish = !isEnglish;
    });
    await prefs.setBool('isEnglish', isEnglish);
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator())));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CCTV at Batkhela Official',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        textTheme: GoogleFonts.notoSansTextTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system, // use device theme (auto dark mode)
      home: SplashWrapper(isEnglish: isEnglish, onToggleLang: _toggleLang),
    );
  }
}

class SplashWrapper extends StatefulWidget {
  final bool isEnglish;
  final VoidCallback onToggleLang;
  SplashWrapper({required this.isEnglish, required this.onToggleLang});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen(isEnglish: widget.isEnglish, onToggleLang: widget.onToggleLang)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg.webp', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.35)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', width: 180, height: 180),
              SizedBox(height: 16),
              Text('CCTV at Batkhela Official', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Powered by CCTV at Batkhela', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback onToggleLang;

  HomeScreen({required this.isEnglish, required this.onToggleLang});

  final String waNumber = "923459270207";
  final String phone1 = "+923459270207";
  final String phone2 = "+923159646431";
  final String email = "subhan.subhan541@gmail.com";
  final String addressUr = "توحید آباد بالا، بٹ خیلہ، ملاکنڈ، پاکستان";
  final String addressEn = "Twheed Abad Bala, Batkhela, Malakand, Pakistan";

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = isEnglish ? "Welcome to CCTV at Batkhela" : "سی سی ٹی وی ایٹ بٹ خیلہ میں خوش آمدید";
    final partner = isEnglish ? "Your trusted security partner in Batkhela and Malakand." : "بٹ خیلہ اور ملاکنڈ میں آپ کا قابلِ اعتماد سیکیورٹی پارٹنر۔";
    final desc = isEnglish ? "We provide high-quality Night Vision CCTV cameras, installation services, and smart monitoring systems." : "ہم جدید نائٹ ویژن سی سی ٹی وی کیمرے، تنصیب، اور اسمارٹ مانیٹرنگ سسٹم فراہم کرتے ہیں۔";

    final servicesHeader = isEnglish ? "Our Services" : "ہماری خدمات";
    final whereHeader = isEnglish ? "Where It's Used" : "کہاں استعمال ہوتا ہے";
    final contactHeader = isEnglish ? "Contact Information" : "رابطہ کی معلومات";
    final contactBtn = isEnglish ? "Contact on WhatsApp" : "واٹس ایپ پر رابطہ کریں";
    final langBtn = isEnglish ? "اردو ورژن" : "English Version";

    return Scaffold(
      appBar: AppBar(
        title: Text("CCTV at Batkhela Official"),
        actions: [
          TextButton(
            onPressed: onToggleLang,
            child: Text(langBtn, style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: isEnglish ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset('assets/logo.png', width: 160, height: 160, fit: BoxFit.contain),
                  SizedBox(height: 8),
                  Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(partner, textAlign: TextAlign.center),
                  SizedBox(height: 6),
                  Text(desc, textAlign: TextAlign.center),
                ],
              ),
            ),
            SizedBox(height: 18),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📦 $servicesHeader", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _bullet(isEnglish ? "High-quality night vision cameras" : "اعلیٰ معیار کے نائٹ ویژن کیمرے"),
                    _bullet(isEnglish ? "Professional installation and maintenance" : "پیشہ ورانہ تنصیب اور دیکھ بھال"),
                    _bullet(isEnglish ? "Mobile monitoring facility" : "موبائل سے مانیٹرنگ کی سہولت"),
                    _bullet(isEnglish ? "Affordable packages for homes, shops, and offices" : "گھروں، دکانوں اور دفاتر کے لیے سستے پیکجز"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🏠 $whereHeader", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _tableRow(isEnglish ? "Homes" : "گھر", isEnglish ? "Family safety and protection" : "سیکیورٹی اور فیملی سیفٹی"),
                    _tableRow(isEnglish ? "Shops" : "دکان", isEnglish ? "Customer and inventory monitoring" : "گاہکوں اور سامان کی نگرانی"),
                    _tableRow(isEnglish ? "Offices" : "دفتر", isEnglish ? "Employee supervision" : "ملازمین کی نگرانی"),
                    _tableRow(isEnglish ? "Schools / Hospitals" : "اسکول / ہسپتال", isEnglish ? "Security and discipline" : "تحفظ اور نظم و ضبط"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text("📞 $contactHeader", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(isEnglish ? addressEn : addressUr),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _contactButton(Icons.phone, phone1, () => _launchUrl("tel:$phone1")),
                        SizedBox(width: 10),
                        _contactButton(Icons.phone, phone2, () => _launchUrl("tel:$phone2")),
                      ],
                    ),
                    SizedBox(height: 8),
                    _linkTile(Icons.email, email, () => _launchUrl("mailto:$email")),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        final encoded = Uri.encodeComponent(isEnglish
                            ? "Hello! I want to know about your CCTV packages."
                            : "السلام علیکم! میں آپ کے CCTV پیکجز کے بارے میں معلومات چاہتا/چاہتی ہوں۔");
                        _launchUrl("https://wa.me/$waNumber?text=$encoded");
                      },
                      icon: Icon(Icons.chat),
                      label: Text(contactBtn),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(child: Text("© 2025 CCTV at Batkhela")),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("•  "),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _tableRow(String left, String right) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(left, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 5, child: Text(right)),
        ],
      ),
    );
  }

  Widget _contactButton(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
    );
  }

  Widget _linkTile(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
