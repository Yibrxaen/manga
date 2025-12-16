import 'package:flutter/material.dart';
import 'dart:async';

// ---------------------------------------------------------
// [1] จุดเริ่มต้นของแอป (MAIN) - ต้องอยู่ตรงนี้
// ---------------------------------------------------------
void main() {
  runApp(NekoToonApp());
}

// ---------------------------------------------------------
// [MODEL] ข้อมูลมังงะและอนิเมะ
// ---------------------------------------------------------
class Anime {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  int views;
  double totalRatingSum;
  int ratingCount;
  bool isSaved;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    this.views = 0,
    this.totalRatingSum = 0.0,
    this.ratingCount = 0,
    this.isSaved = false,
  });

  double get averageRating =>
      ratingCount == 0 ? 0.0 : totalRatingSum / ratingCount;
}

// ---------------------------------------------------------
// [DATABASE] ข้อมูล 110 เรื่อง
// ---------------------------------------------------------
class AppData {
  static List<Anime> allAnime = [];
  static bool isLoggedIn = false;
  static String userName = "Guest";

  static void init() {
    if (allAnime.isNotEmpty) return;
    _data.forEach((cat, list) {
      for (int i = 0; i < list.length; i++) {
        allAnime.add(
          Anime(
            id: "${cat}_$i",
            title: list[i]['t']!,
            category: cat,
            imageUrl: list[i]['img']!,
            views: (300 + (i * 42)),
          ),
        );
      }
    });
  }

  static final Map<String, List<Map<String, String>>> _data = {
    "แอกชัน": [
      {
        "t": "One Piece",
        "img": "https://cdn.myanimelist.net/images/anime/6/73245.jpg",
      },
      {
        "t": "Naruto",
        "img": "https://cdn.myanimelist.net/images/anime/13/17405.jpg",
      },
      {
        "t": "Demon Slayer",
        "img": "https://cdn.myanimelist.net/images/anime/1286/99889.jpg",
      },
      {
        "t": "Jujutsu Kaisen",
        "img": "https://cdn.myanimelist.net/images/anime/1171/109222.jpg",
      },
      {
        "t": "Solo Leveling",
        "img":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjjydKUpH1rz3V2N2oTcKX7O3QIMkH_-xqqw&s",
      },
      {
        "t": "Attack on Titan",
        "img": "https://cdn.myanimelist.net/images/anime/10/47347.jpg",
      },
      {
        "t": "Chainsaw Man",
        "img": "https://cdn.myanimelist.net/images/anime/1806/126216.jpg",
      },
      {
        "t": "One Punch Man",
        "img": "https://cdn.myanimelist.net/images/anime/12/76649.jpg",
      },
      {
        "t": "Black Clover",
        "img": "https://cdn.myanimelist.net/images/anime/2/88336.jpg",
      },
      {
        "t": "Hunter x Hunter",
        "img": "https://cdn.myanimelist.net/images/anime/11/33657.jpg",
      },
    ],
    "แฟนตาซี": [
      {
        "t": "Frieren",
        "img": "https://cdn.myanimelist.net/images/anime/1015/138006.jpg",
      },
      {
        "t": "Mushoku Tensei",
        "img": "https://cdn.myanimelist.net/images/anime/1530/117776.jpg",
      },
      {
        "t": "Black Butler",
        "img": "https://cdn.myanimelist.net/images/anime/1202/141295.jpg",
      },
      {
        "t": "Magi",
        "img": "https://cdn.myanimelist.net/images/anime/11/43301.jpg",
      },
      {
        "t": "Soul Eater",
        "img": "https://cdn.myanimelist.net/images/anime/12/12535.jpg",
      },
      {
        "t": "Fullmetal Alchemist",
        "img": "https://cdn.myanimelist.net/images/anime/1223/96541.jpg",
      },
      {
        "t": "Noragami",
        "img": "https://cdn.myanimelist.net/images/anime/9/77809.jpg",
      },
      {
        "t": "Blue Exorcist",
        "img": "https://cdn.myanimelist.net/images/anime/10/75195.jpg",
      },
      {
        "t": "Made in Abyss",
        "img": "https://cdn.myanimelist.net/images/anime/11/86337.jpg",
      },
      {
        "t": "Dororo",
        "img": "https://cdn.myanimelist.net/images/anime/1935/98506.jpg",
      },
    ],
    "ต่างโลก": [
      {
        "t": "Slime Datta Ken",
        "img": "https://cdn.myanimelist.net/images/anime/2/91546.jpg",
      },
      {
        "t": "Overlord",
        "img": "https://cdn.myanimelist.net/images/anime/7/74637.jpg",
      },
      {
        "t": "Re:Zero",
        "img": "https://cdn.myanimelist.net/images/anime/11/79410.jpg",
      },
      {
        "t": "Konosuba",
        "img": "https://cdn.myanimelist.net/images/anime/8/77831.jpg",
      },
      {
        "t": "Shield Hero",
        "img": "https://cdn.myanimelist.net/images/anime/1490/101365.jpg",
      },
      {
        "t": "No Game No Life",
        "img": "https://cdn.myanimelist.net/images/anime/1074/111944.jpg",
      },
      {
        "t": "Sword Art Online",
        "img": "https://cdn.myanimelist.net/images/anime/11/39717.jpg",
      },
      {
        "t": "Log Horizon",
        "img": "https://cdn.myanimelist.net/images/anime/6/54467.jpg",
      },
      {
        "t": "Eminence in Shadow",
        "img": "https://cdn.myanimelist.net/images/anime/1244/127113.jpg",
      },
      {
        "t": "Mushoku Tensei II",
        "img": "https://cdn.myanimelist.net/images/anime/1283/135930.jpg",
      },
    ],
    "กีฬา": [
      {
        "t": "Blue Lock",
        "img": "https://cdn.myanimelist.net/images/anime/1908/135431.jpg",
      },
      {
        "t": "Haikyuu",
        "img": "https://cdn.myanimelist.net/images/anime/7/76014.jpg",
      },
      {
        "t": "Slam Dunk",
        "img": "https://cdn.myanimelist.net/images/anime/1633/135323.jpg",
      },
      {
        "t": "Kuroko no Basket",
        "img": "https://cdn.myanimelist.net/images/anime/11/50331.jpg",
      },
      {
        "t": "Ace of Diamond",
        "img": "https://cdn.myanimelist.net/images/anime/10/76189.jpg",
      },
      {
        "t": "Hajime no Ippo",
        "img": "https://cdn.myanimelist.net/images/anime/4/80011.jpg",
      },
      {
        "t": "Free!",
        "img": "https://cdn.myanimelist.net/images/anime/11/51765.jpg",
      },
      {
        "t": "Aoashi",
        "img": "https://cdn.myanimelist.net/images/anime/1749/122047.jpg",
      },
      {
        "t": "Yowamushi Pedal",
        "img": "https://cdn.myanimelist.net/images/anime/12/54941.jpg",
      },
      {
        "t": "Prince of Tennis",
        "img": "https://cdn.myanimelist.net/images/anime/6/22026.jpg",
      },
    ],
    "โรแมนติก": [
      {
        "t": "Kaguya-sama",
        "img": "https://cdn.myanimelist.net/images/anime/1295/106551.jpg",
      },
      {
        "t": "Horimiya",
        "img": "https://cdn.myanimelist.net/images/anime/1695/111486.jpg",
      },
      {
        "t": "Your Lie in April",
        "img": "https://cdn.myanimelist.net/images/anime/3/67177.jpg",
      },
      {
        "t": "Your Name",
        "img": "https://cdn.myanimelist.net/images/anime/5/87048.jpg",
      },
      {
        "t": "A Silent Voice",
        "img": "https://cdn.myanimelist.net/images/anime/1122/96435.jpg",
      },
      {
        "t": "My Dress-Up Darling",
        "img": "https://cdn.myanimelist.net/images/anime/1173/119271.jpg",
      },
      {
        "t": "Clannad",
        "img": "https://cdn.myanimelist.net/images/anime/1806/123131.jpg",
      },
      {
        "t": "Toradora",
        "img": "https://cdn.myanimelist.net/images/anime/13/22128.jpg",
      },
      {
        "t": "Fruits Basket",
        "img": "https://cdn.myanimelist.net/images/anime/4/115801.jpg",
      },
      {
        "t": "Blue Box",
        "img": "https://cdn.myanimelist.net/images/anime/1202/145455.jpg",
      },
    ],
    "ตลก": [
      {
        "t": "Spy x Family",
        "img": "https://cdn.myanimelist.net/images/anime/1441/122795.jpg",
      },
      {
        "t": "Gintama",
        "img": "https://cdn.myanimelist.net/images/anime/10/73274.jpg",
      },
      {
        "t": "Mashle",
        "img": "https://cdn.myanimelist.net/images/anime/1043/133644.jpg",
      },
      {
        "t": "Bocchi the Rock!",
        "img": "https://cdn.myanimelist.net/images/anime/1448/127968.jpg",
      },
      {
        "t": "Nichijou",
        "img": "https://cdn.myanimelist.net/images/anime/3/75617.jpg",
      },
      {
        "t": "Saiki K",
        "img": "https://cdn.myanimelist.net/images/anime/1522/115143.jpg",
      },
      {
        "t": "Grand Blue",
        "img": "https://cdn.myanimelist.net/images/anime/1410/94101.jpg",
      },
      {
        "t": "Daily HS Boys",
        "img": "https://cdn.myanimelist.net/images/anime/1501/139260.jpg",
      },
      {
        "t": "Asobi Asobase",
        "img": "https://cdn.myanimelist.net/images/anime/1110/93310.jpg",
      },
    ],
    "สยองขวัญ": [
      {
        "t": "Another",
        "img": "https://cdn.myanimelist.net/images/anime/4/75509.jpg",
      },
      {
        "t": "Mieruko-chan",
        "img": "https://cdn.myanimelist.net/images/anime/1269/117565.jpg",
      },
      {
        "t": "Parasyte",
        "img": "https://cdn.myanimelist.net/images/anime/3/73178.jpg",
      },
      {
        "t": "Promised Neverland",
        "img": "https://cdn.myanimelist.net/images/anime/1125/96929.jpg",
      },
      {
        "t": "Tokyo Ghoul",
        "img": "https://cdn.myanimelist.net/images/anime/10/63287.jpg",
      },
      {
        "t": "Higurashi",
        "img": "https://cdn.myanimelist.net/images/anime/12/19630.jpg",
      },
      {
        "t": "Shiki",
        "img": "https://cdn.myanimelist.net/images/anime/5/25046.jpg",
      },
      {
        "t": "Hell Girl",
        "img": "https://cdn.myanimelist.net/images/anime/2/74738.jpg",
      },
      {
        "t": "Uzumaki",
        "img": "https://cdn.myanimelist.net/images/anime/1118/145452.jpg",
      },
      {
        "t": "Elfen Lied",
        "img": "https://cdn.myanimelist.net/images/anime/10/19128.jpg",
      },
    ],
    "ดราม่า": [
      {
        "t": "Oshi no Ko",
        "img": "https://cdn.myanimelist.net/images/anime/1813/135656.jpg",
      },
      {
        "t": "Violet Evergarden",
        "img": "https://cdn.myanimelist.net/images/anime/1795/95088.jpg",
      },
      {
        "t": "Anohana",
        "img": "https://cdn.myanimelist.net/images/anime/5/74531.jpg",
      },
      {
        "t": "To Your Eternity",
        "img": "https://cdn.myanimelist.net/images/anime/1075/108994.jpg",
      },
      {
        "t": "March Lion",
        "img": "https://cdn.myanimelist.net/images/anime/1177/111582.jpg",
      },
      {
        "t": "Erased",
        "img": "https://cdn.myanimelist.net/images/anime/10/77957.jpg",
      },
      {
        "t": "Orange",
        "img": "https://cdn.myanimelist.net/images/anime/9/79393.jpg",
      },
      {
        "t": "Clannad After",
        "img": "https://cdn.myanimelist.net/images/anime/13/13225.jpg",
      },
      {
        "t": "Great Pretender",
        "img": "https://cdn.myanimelist.net/images/anime/1155/107872.jpg",
      },
      {
        "t": "Plastic Memories",
        "img": "https://cdn.myanimelist.net/images/anime/7/73507.jpg",
      },
    ],
    "ไซไฟ": [
      {
        "t": "Dr. Stone",
        "img": "https://cdn.myanimelist.net/images/anime/1613/102179.jpg",
      },
      {
        "t": "Steins;Gate",
        "img": "https://cdn.myanimelist.net/images/anime/15/35833.jpg",
      },
      {
        "t": "Psycho-Pass",
        "img": "https://cdn.myanimelist.net/images/anime/5/43393.jpg",
      },
      {
        "t": "86 Eighty-Six",
        "img": "https://cdn.myanimelist.net/images/anime/1987/117507.jpg",
      },
      {
        "t": "Cowboy Bebop",
        "img": "https://cdn.myanimelist.net/images/anime/4/19644.jpg",
      },
      {
        "t": "Akira",
        "img": "https://cdn.myanimelist.net/images/anime/10/77974.jpg",
      },
      {
        "t": "Evangelion",
        "img": "https://cdn.myanimelist.net/images/anime/1314/108922.jpg",
      },
      {
        "t": "Trigun",
        "img": "https://cdn.myanimelist.net/images/anime/7/20310.jpg",
      },
      {
        "t": "Cyberpunk",
        "img": "https://cdn.myanimelist.net/images/anime/1444/127111.jpg",
      },
      {
        "t": "Code Geass",
        "img": "https://cdn.myanimelist.net/images/anime/18/43977.jpg",
      },
    ],
    "เหนือธรรมชาติ": [
      {
        "t": "Death Note",
        "img": "https://cdn.myanimelist.net/images/anime/9/9453.jpg",
      },
      {
        "t": "Mob Psycho 100",
        "img": "https://cdn.myanimelist.net/images/anime/1770/97704.jpg",
      },
      {
        "t": "Natsume",
        "img": "https://cdn.myanimelist.net/images/anime/1209/142998.jpg",
      },
      {
        "t": "Durarara!!",
        "img": "https://cdn.myanimelist.net/images/anime/10/24859.jpg",
      },
      {
        "t": "Bakemonogatari",
        "img": "https://cdn.myanimelist.net/images/anime/11/12991.jpg",
      },
      {
        "t": "Mushishi",
        "img": "https://cdn.myanimelist.net/images/anime/2/73861.jpg",
      },
      {
        "t": "Hell's Paradise",
        "img": "https://cdn.myanimelist.net/images/anime/1075/133060.jpg",
      },
      {
        "t": "Darker Than Black",
        "img": "https://cdn.myanimelist.net/images/anime/11/48207.jpg",
      },
      {
        "t": "Fate/Zero",
        "img": "https://cdn.myanimelist.net/images/anime/2/73250.jpg",
      },
      {
        "t": "Noragami S2",
        "img": "https://cdn.myanimelist.net/images/anime/7/77820.jpg",
      },
    ],
    "ชีวิตประจำวัน": [
      {
        "t": "K-On!",
        "img": "https://cdn.myanimelist.net/images/anime/10/76120.jpg",
      },
      {
        "t": "Yuru Camp",
        "img": "https://cdn.myanimelist.net/images/anime/1113/141695.jpg",
      },
      {
        "t": "Barakamon",
        "img": "https://cdn.myanimelist.net/images/anime/11/64345.jpg",
      },
      {
        "t": "Non Non Biyori",
        "img": "https://cdn.myanimelist.net/images/anime/9/54467.jpg",
      },
      {
        "t": "Hyouka",
        "img": "https://cdn.myanimelist.net/images/anime/13/40451.jpg",
      },
      {
        "t": "Wolf Children",
        "img": "https://cdn.myanimelist.net/images/anime/10/39717.jpg",
      },
      {
        "t": "Totoro",
        "img": "https://cdn.myanimelist.net/images/anime/12/76649.jpg",
      },
      {
        "t": "Silver Spoon",
        "img": "https://cdn.myanimelist.net/images/anime/11/50331.jpg",
      },
      {
        "t": "Lucky Star",
        "img": "https://cdn.myanimelist.net/images/anime/11/39717.jpg",
      },
      {
        "t": "Aria",
        "img": "https://cdn.myanimelist.net/images/anime/12/35833.jpg",
      },
    ],
  };
}

// ---------------------------------------------------------
// [HELPER] รูปภาพ
// ---------------------------------------------------------
Widget buildImage(String url, String title) {
  return Image.network(
    url,
    fit: BoxFit.cover,
    loadingBuilder: (c, child, lp) => lp == null
        ? child
        : Container(
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
                strokeWidth: 2,
              ),
            ),
          ),
    errorBuilder: (c, e, s) => Container(
      color: Colors.blueGrey[900],
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------
// [APP MAIN]
// ---------------------------------------------------------
class NekoToonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0F0F0F),
        primaryColor: Colors.greenAccent,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0F0F0F),
          elevation: 0,
        ),
      ),
      home: SplashScreen(),
    );
  }
}

// ---------------------------------------------------------
// [SPLASH SCREEN] หน้าเข้าแอป
// ---------------------------------------------------------
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0F0F), Color(0xFF00331A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NekoToon",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.greenAccent,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "The Best Anime & Manga Community",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(color: Colors.greenAccent),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// [หน้า LOGIN]
// ---------------------------------------------------------
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final u = TextEditingController();

  void _handleSocialLogin(String provider) {
    setState(() {
      AppData.isLoggedIn = true;
      AppData.userName = "$provider User";
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (c) => MainController()),
    );
  }

  Widget _socialBtn(IconData icon, Color color, String label) =>
      GestureDetector(
        onTap: () => _handleSocialLogin(label),
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white10,
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(height: 5),
            Text(label, style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F0F0F), Color(0xFF1A2A22)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pets, size: 80, color: Colors.greenAccent),
              Text(
                "NekoToon",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: Colors.greenAccent,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: u,
                decoration: InputDecoration(
                  labelText: "ชื่อผู้ใช้",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "รหัสผ่าน",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    AppData.userName = u.text.isEmpty ? "Guest" : u.text;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (c) => MainController()),
                    );
                  },
                  child: Text(
                    "เข้าสู่ระบบ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("หรือเข้าสู่ระบบด้วย"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _socialBtn(Icons.g_mobiledata, Colors.red, "Google"),
                  _socialBtn(Icons.facebook, Colors.blue, "Facebook"),
                  _socialBtn(Icons.camera_alt, Colors.pink, "Instagram"),
                  _socialBtn(Icons.chat_bubble, Colors.green, "Line"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainController extends StatefulWidget {
  @override
  _MainControllerState createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  int _idx = 0;
  void _ref() => setState(() {});
  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomePage(onUpdate: _ref),
      SearchPage(onUpdate: _ref),
      LibraryPage(onUpdate: _ref),
      RankPage(),
      ProfilePage(onUpdate: _ref),
    ];
    return Scaffold(
      body: tabs[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.greenAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'ค้นหา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_rounded),
            label: 'คลัง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'อันดับ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'โปรไฟล์',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// [หน้าหลัก]
// ---------------------------------------------------------
class HomePage extends StatefulWidget {
  final VoidCallback onUpdate;
  HomePage({required this.onUpdate});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCat = "แอกชัน";

  Widget _title(String t, VoidCallback? onAll) => Padding(
    padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(t, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (onAll != null)
          TextButton(
            onPressed: onAll,
            child: Text(
              "ดูทั้งหมด",
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
      ],
    ),
  );

  Widget _rankingList(List<Anime> list) => Container(
    height: 220,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 10),
      itemCount: list.length,
      itemBuilder: (c, i) => GestureDetector(
        onTap: () {
          list[i].views++;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => DetailPage(manga: list[i])),
          ).then((_) => widget.onUpdate());
        },
        child: Container(
          width: 140,
          margin: EdgeInsets.all(8),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: buildImage(list[i].imageUrl, list[i].title),
              ),
              Positioned(
                bottom: -5,
                left: 5,
                child: Text(
                  "${i + 1}",
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _horizontalList(List<Anime> list) => Container(
    height: 230,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 10),
      itemCount: list.length,
      itemBuilder: (c, i) => GestureDetector(
        onTap: () {
          list[i].views++;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => DetailPage(manga: list[i])),
          ).then((_) => widget.onUpdate());
        },
        child: Container(
          width: 130,
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: buildImage(list[i].imageUrl, list[i].title),
                ),
              ),
              SizedBox(height: 5),
              Text(
                list[i].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                list[i].category,
                style: TextStyle(fontSize: 11, color: Colors.greenAccent),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final cats = AppData.allAnime.map((m) => m.category).toSet().toList();
    final trending = AppData.allAnime.reversed.toList();
    final recommended = AppData.allAnime
        .where((a) => a.id.contains("3") || a.id.contains("8"))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NekoToon",
          style: TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("ยอดนิยมตามหมวดหมู่", null),
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15),
                children: cats
                    .map(
                      (c) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: ChoiceChip(
                          label: Text(c),
                          selected: selectedCat == c,
                          onSelected: (v) => setState(() => selectedCat = c),
                          selectedColor: Colors.greenAccent,
                          labelStyle: TextStyle(
                            color: selectedCat == c
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            _rankingList(
              AppData.allAnime.where((m) => m.category == selectedCat).toList(),
            ),
            _title("เรื่องมาแรงที่กำลังฮิต 🔥", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => FullListPage(
                    title: "เรื่องมาแรง",
                    animeList: trending,
                    onUpdate: widget.onUpdate,
                  ),
                ),
              );
            }),
            _horizontalList(trending.take(15).toList()),
            _title("แนะนำเฉพาะคุณ ✨", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => FullListPage(
                    title: "แนะนำสำหรับคุณ",
                    animeList: recommended,
                    onUpdate: widget.onUpdate,
                  ),
                ),
              );
            }),
            _horizontalList(recommended.take(15).toList()),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// [หน้าค้นหา]
// ---------------------------------------------------------
class SearchPage extends StatefulWidget {
  final VoidCallback onUpdate;
  SearchPage({required this.onUpdate});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _ctrl = TextEditingController();
  List<Anime> searchRes = [];
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      setState(() {
        isTyping = _ctrl.text.isNotEmpty;
        searchRes = AppData.allAnime
            .where(
              (a) => a.title.toLowerCase().contains(_ctrl.text.toLowerCase()),
            )
            .toList();
      });
    });
  }

  void _toDetail(Anime a) {
    a.views++;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => DetailPage(manga: a)),
    ).then((_) => widget.onUpdate());
  }

  Widget _sectionHead(String t) => Padding(
    padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
    child: Text(t, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  "ค้นหา",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      hintText: "หาเรื่อง, หมวดหมู่ และอื่น ๆ",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              if (!isTyping) ...[
                _sectionHead("เรื่องที่ทุกคนกำลังตามหา"),
                Container(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 15),
                    itemCount: 5,
                    itemBuilder: (c, i) => GestureDetector(
                      onTap: () => _toDetail(AppData.allAnime[i]),
                      child: Container(
                        width: 140,
                        margin: EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: buildImage(AppData.allAnime[i].imageUrl, ""),
                        ),
                      ),
                    ),
                  ),
                ),
                _sectionHead("ดูหมวดหมู่"),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(15),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.8,
                  children:
                      [
                            "แอกชัน",
                            "ต่างโลก",
                            "กีฬา",
                            "แฟนตาซี",
                            "โรแมนติก",
                            "ตลก",
                            "สยองขวัญ",
                            "ดราม่า",
                          ]
                          .map(
                            (cat) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) => FullListPage(
                                      title: cat,
                                      animeList: AppData.allAnime
                                          .where((a) => a.category == cat)
                                          .toList(),
                                      onUpdate: widget.onUpdate,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    cat,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ] else ...[
                _sectionHead("ผลลัพธ์การค้นหา"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: searchRes.length,
                  itemBuilder: (c, i) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(searchRes[i].title),
                    onTap: () => _toDetail(searchRes[i]),
                  ),
                ),
              ],
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// [FullList, Detail, Library, Rank]
// ---------------------------------------------------------
class FullListPage extends StatelessWidget {
  final String title;
  final List<Anime> animeList;
  final VoidCallback onUpdate;
  FullListPage({
    required this.title,
    required this.animeList,
    required this.onUpdate,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
        itemCount: animeList.length,
        itemBuilder: (c, i) => GestureDetector(
          onTap: () {
            animeList[i].views++;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => DetailPage(manga: animeList[i]),
              ),
            ).then((_) => onUpdate());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: buildImage(animeList[i].imageUrl, animeList[i].title),
                ),
              ),
              SizedBox(height: 5),
              Text(
                animeList[i].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                animeList[i].category,
                style: TextStyle(fontSize: 10, color: Colors.greenAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Anime manga;
  DetailPage({required this.manga});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double userRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.manga.title),
        actions: [
          IconButton(
            icon: Icon(
              widget.manga.isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.greenAccent,
            ),
            onPressed: () =>
                setState(() => widget.manga.isSaved = !widget.manga.isSaved),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: buildImage(widget.manga.imageUrl, widget.manga.title),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.manga.category,
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                      ),
                      Text(
                        "👁️ ${widget.manga.views}  ⭐ ${widget.manga.averageRating.toStringAsFixed(1)}",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "เนื้อเรื่องย่อสำหรับ ${widget.manga.title}: ผลงานชั้นเยี่ยมที่คุณห้ามพลาด...",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Divider(height: 50),
                  Center(child: Text("ให้คะแนนเรื่องนี้")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (i) => IconButton(
                        icon: Icon(
                          i < userRating ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                        ),
                        onPressed: () => setState(() => userRating = i + 1.0),
                      ),
                    ),
                  ),
                  if (userRating > 0)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.manga.totalRatingSum += userRating;
                            widget.manga.ratingCount++;
                            userRating = 0;
                          });
                        },
                        child: Text("ส่งคะแนน"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  final VoidCallback onUpdate;
  LibraryPage({required this.onUpdate});
  @override
  Widget build(BuildContext context) {
    final saved = AppData.allAnime.where((a) => a.isSaved).toList();
    return Scaffold(
      appBar: AppBar(title: Text("คลังของฉัน")),
      body: saved.isEmpty
          ? Center(child: Text("ยังว่างเปล่า"))
          : GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: saved.length,
              itemBuilder: (c, i) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: buildImage(saved[i].imageUrl, saved[i].title),
              ),
            ),
    );
  }
}

class RankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sorted = List<Anime>.from(AppData.allAnime)
      ..sort((a, b) => b.views.compareTo(a.views));
    return Scaffold(
      appBar: AppBar(title: Text("อันดับยอดนิยม")),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (c, i) => ListTile(
          leading: Text(
            "#${i + 1}",
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(sorted[i].title),
          trailing: Text("${sorted[i].views} views"),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final VoidCallback onUpdate;
  ProfilePage({required this.onUpdate});

  Widget _statItem(String label, String val, IconData icon, Color col) =>
      Column(
        children: [
          Icon(icon, color: col),
          SizedBox(height: 5),
          Text(
            val,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      );

  Widget _menuItem(IconData icon, String title, String extra, Color iconCol) =>
      ListTile(
        leading: Icon(icon, color: iconCol),
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (extra.isNotEmpty)
              Text(extra, style: TextStyle(color: Colors.grey, fontSize: 13)),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    final savedCount = AppData.allAnime.where((a) => a.isSaved).length;
    return Scaffold(
      appBar: AppBar(title: Text("โปรไฟล์")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.black),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppData.userName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "สมาชิกระดับ: Neko Gold",
                        style: TextStyle(color: Colors.greenAccent),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "ID: 12345678",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statItem(
                    "ตั๋วฟรี",
                    "3",
                    Icons.confirmation_number,
                    Colors.blue,
                  ),
                  _statItem("คะแนน", "1,250", Icons.star, Colors.yellow),
                ],
              ),
            ),
            SizedBox(height: 25),
            Divider(thickness: 8, color: Colors.white10),
            _menuItem(
              Icons.bookmark,
              "เรื่องที่บันทึกไว้",
              "$savedCount เรื่อง",
              Colors.greenAccent,
            ),
            _menuItem(
              Icons.history,
              "ประวัติการอ่าน",
              "24 เรื่อง",
              Colors.white,
            ),
            _menuItem(Icons.notifications, "แจ้งเตือน", "5 ใหม่", Colors.white),
            Divider(thickness: 8, color: Colors.white10),
            _menuItem(Icons.help_outline, "ศูนย์ช่วยเหลือ", "", Colors.white),
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.redAccent),
                  ),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (c) => LoginScreen()),
                  ),
                  child: Text(
                    "ออกจากระบบ",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
