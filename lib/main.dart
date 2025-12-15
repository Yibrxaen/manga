import 'package:flutter/material.dart';
import 'dart:async';

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
    required this.id, required this.title, required this.imageUrl,
    required this.category, this.views = 0, this.totalRatingSum = 0.0,
    this.ratingCount = 0, this.isSaved = false,
  });

  double get averageRating => ratingCount == 0 ? 0.0 : totalRatingSum / ratingCount;
}

// ---------------------------------------------------------
// [DATABASE] ข้อมูลจริง 11 หมวดหมู่ หมวดละ 10 เรื่อง (110 เรื่อง)
// ---------------------------------------------------------
class AppData {
  static List<Anime> allAnime = [];
  static bool isLoggedIn = false;
  static String userName = "Guest";

  static void init() {
    if (allAnime.isNotEmpty) return;
    
    // ข้อมูลจริงพร้อมรูปภาพปกที่เสถียร
    _data.forEach((cat, list) {
      for (int i = 0; i < list.length; i++) {
        allAnime.add(Anime(
          id: "${cat}_$i",
          title: list[i]['t']!,
          category: cat,
          imageUrl: list[i]['img']!,
        ));
      }
    });
  }

  static final Map<String, List<Map<String, String>>> _data = {
    "แอกชัน": [
      {"t": "One Piece", "img": "https://cdn.myanimelist.net/images/anime/6/73245.jpg"},
      {"t": "Naruto", "img": "https://cdn.myanimelist.net/images/anime/13/17405.jpg"},
      {"t": "Demon Slayer", "img": "https://cdn.myanimelist.net/images/anime/1286/99889.jpg"},
      {"t": "Jujutsu Kaisen", "img": "https://cdn.myanimelist.net/images/anime/1171/109222.jpg"},
      {"t": "Solo Leveling", "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjjydKUpH1rz3V2N2oTcKX7O3QIMkH_-xqqw&s"},
      {"t": "Attack on Titan", "img": "https://cdn.myanimelist.net/images/anime/10/47347.jpg"},
      {"t": "Chainsaw Man", "img": "https://cdn.myanimelist.net/images/anime/1806/126216.jpg"},
      {"t": "One Punch Man", "img": "https://m.media-amazon.com/images/M/MV5BNzMwOGQ5MWItNzE3My00ZDYyLTk4NzAtZWIyYWI0NTZhYzY0XkEyXkFqcGc@._V1_.jpg"},
      {"t": "Black Clover", "img": "https://cdn.myanimelist.net/images/anime/2/88336.jpg"},
      {"t": "Hunter x Hunter", "img": "https://m.media-amazon.com/images/M/MV5BYzYxOTlkYzctNGY2MC00MjNjLWIxOWMtY2QwYjcxZWIwMmEwXkEyXkFqcGc@._V1_.jpg"},
    ],
    "แฟนตาซี": [
      {"t": "Frieren", "img": "https://cdn.myanimelist.net/images/anime/1015/138006.jpg"},
      {"t": "Mushoku Tensei", "img": "https://cdn.myanimelist.net/images/anime/1530/117776.jpg"},
      {"t": "Black Butler", "img": "https://cdn.myanimelist.net/images/anime/1202/141295.jpg"},
      {"t": "Magi", "img": "https://cdn.myanimelist.net/images/anime/11/43301.jpg"},
      {"t": "Soul Eater", "img": "https://cdn.myanimelist.net/images/anime/12/12535.jpg"},
      {"t": "Fullmetal Alchemist", "img": "https://cdn.myanimelist.net/images/anime/1223/96541.jpg"},
      {"t": "Noragami", "img": "https://cdn.myanimelist.net/images/anime/9/77809.jpg"},
      {"t": "Blue Exorcist", "img": "https://cdn.myanimelist.net/images/anime/10/75195.jpg"},
      {"t": "Made in Abyss", "img": "https://cdn.myanimelist.net/images/anime/11/86337.jpg"},
      {"t": "Dororo", "img": "https://cdn.myanimelist.net/images/anime/1935/98506.jpg"},
    ],
    "ต่างโลก": [
      {"t": "Slime Datta Ken", "img": "https://cdn.myanimelist.net/images/anime/2/91546.jpg"},
      {"t": "Overlord", "img": "https://cdn.myanimelist.net/images/anime/7/74637.jpg"},
      {"t": "Re:Zero", "img": "https://cdn.myanimelist.net/images/anime/11/79410.jpg"},
      {"t": "Konosuba", "img": "https://cdn.myanimelist.net/images/anime/8/77831.jpg"},
      {"t": "Shield Hero", "img": "https://cdn.myanimelist.net/images/anime/1490/101365.jpg"},
      {"t": "No Game No Life", "img": "https://cdn.myanimelist.net/images/anime/1074/111944.jpg"},
      {"t": "Sword Art Online", "img": "https://cdn.myanimelist.net/images/anime/11/39717.jpg"},
      {"t": "Log Horizon", "img": "https://cdn.myanimelist.net/images/anime/6/54467.jpg"},
      {"t": "Eminence in Shadow", "img": "https://cdn.myanimelist.net/images/anime/1244/127113.jpg"},
      {"t": "Mushoku Tensei II", "img": "https://cdn.myanimelist.net/images/anime/1283/135930.jpg"},
    ],
    "กีฬา": [
      {"t": "Blue Lock", "img": "https://cdn.myanimelist.net/images/anime/1908/135431.jpg"},
      {"t": "Haikyuu", "img": "https://cdn.myanimelist.net/images/anime/7/76014.jpg"},
      {"t": "Slam Dunk", "img": "https://cdn.myanimelist.net/images/anime/1633/135323.jpg"},
      {"t": "Kuroko no Basket", "img": "https://cdn.myanimelist.net/images/anime/11/50331.jpg"},
      {"t": "Ace of Diamond", "img": "https://cdn.myanimelist.net/images/anime/10/76189.jpg"},
      {"t": "Hajime no Ippo", "img": "https://cdn.myanimelist.net/images/anime/4/80011.jpg"},
      {"t": "Free!", "img": "https://cdn.myanimelist.net/images/anime/11/51765.jpg"},
      {"t": "Aoashi", "img": "https://cdn.myanimelist.net/images/anime/1749/122047.jpg"},
      {"t": "Yowamushi Pedal", "img": "https://cdn.myanimelist.net/images/anime/12/54941.jpg"},
      {"t": "Prince of Tennis", "img": "https://cdn.myanimelist.net/images/anime/6/22026.jpg"},
    ],
    "โรแมนติก": [
      {"t": "Kaguya-sama", "img": "https://cdn.myanimelist.net/images/anime/1295/106551.jpg"},
      {"t": "Horimiya", "img": "https://cdn.myanimelist.net/images/anime/1695/111486.jpg"},
      {"t": "Your Lie in April", "img": "https://cdn.myanimelist.net/images/anime/3/67177.jpg"},
      {"t": "Your Name", "img": "https://cdn.myanimelist.net/images/anime/5/87048.jpg"},
      {"t": "A Silent Voice", "img": "https://cdn.myanimelist.net/images/anime/1122/96435.jpg"},
      {"t": "My Dress-Up Darling", "img": "https://cdn.myanimelist.net/images/anime/1173/119271.jpg"},
      {"t": "Clannad", "img": "https://cdn.myanimelist.net/images/anime/1806/123131.jpg"},
      {"t": "Toradora", "img": "https://cdn.myanimelist.net/images/anime/13/22128.jpg"},
      {"t": "Fruits Basket", "img": "https://cdn.myanimelist.net/images/anime/4/115801.jpg"},
      {"t": "Blue Box", "img": "https://cdn.myanimelist.net/images/anime/1202/145455.jpg"},
    ],
    "ตลก": [
      {"t": "Spy x Family", "img": "https://cdn.myanimelist.net/images/anime/1441/122795.jpg"},
      {"t": "Gintama", "img": "https://cdn.myanimelist.net/images/anime/10/73274.jpg"},
      {"t": "Mashle", "img": "https://cdn.myanimelist.net/images/anime/1043/133644.jpg"},
      {"t": "Bocchi the Rock!", "img": "https://cdn.myanimelist.net/images/anime/1448/127968.jpg"},
      {"t": "One Punch Man S1", "img": "https://cdn.myanimelist.net/images/anime/12/76649.jpg"},
      {"t": "Nichijou", "img": "https://cdn.myanimelist.net/images/anime/3/75617.jpg"},
      {"t": "Saiki K", "img": "https://cdn.myanimelist.net/images/anime/1522/115143.jpg"},
      {"t": "Grand Blue", "img": "https://cdn.myanimelist.net/images/anime/1410/94101.jpg"},
      {"t": "Daily HS Boys", "img": "https://cdn.myanimelist.net/images/anime/1501/139260.jpg"},
      {"t": "Asobi Asobase", "img": "https://cdn.myanimelist.net/images/anime/1110/93310.jpg"},
    ],
    "สยองขวัญ": [
      {"t": "Another", "img": "https://cdn.myanimelist.net/images/anime/4/75509.jpg"},
      {"t": "Mieruko-chan", "img": "https://cdn.myanimelist.net/images/anime/1269/117565.jpg"},
      {"t": "Parasyte", "img": "https://cdn.myanimelist.net/images/anime/3/73178.jpg"},
      {"t": "Promised Neverland", "img": "https://cdn.myanimelist.net/images/anime/1125/96929.jpg"},
      {"t": "Tokyo Ghoul", "img": "https://cdn.myanimelist.net/images/anime/10/63287.jpg"},
      {"t": "Higurashi", "img": "https://cdn.myanimelist.net/images/anime/12/19630.jpg"},
      {"t": "Shiki", "img": "https://cdn.myanimelist.net/images/anime/5/25046.jpg"},
      {"t": "Hell Girl", "img": "https://cdn.myanimelist.net/images/anime/2/74738.jpg"},
      {"t": "Uzumaki", "img": "https://cdn.myanimelist.net/images/anime/1118/145452.jpg"},
      {"t": "Elfen Lied", "img": "https://cdn.myanimelist.net/images/anime/10/19128.jpg"},
    ],
    "ดราม่า": [
      {"t": "Oshi no Ko", "img": "https://cdn.myanimelist.net/images/anime/1813/135656.jpg"},
      {"t": "Violet Evergarden", "img": "https://cdn.myanimelist.net/images/anime/1795/95088.jpg"},
      {"t": "Anohana", "img": "https://cdn.myanimelist.net/images/anime/5/74531.jpg"},
      {"t": "To Your Eternity", "img": "https://cdn.myanimelist.net/images/anime/1075/108994.jpg"},
      {"t": "March Lion", "img": "https://cdn.myanimelist.net/images/anime/1177/111582.jpg"},
      {"t": "Erased", "img": "https://cdn.myanimelist.net/images/anime/10/77957.jpg"},
      {"t": "Orange", "img": "https://cdn.myanimelist.net/images/anime/9/79393.jpg"},
      {"t": "Clannad After", "img": "https://cdn.myanimelist.net/images/anime/13/13225.jpg"},
      {"t": "Great Pretender", "img": "https://cdn.myanimelist.net/images/anime/1155/107872.jpg"},
      {"t": "Plastic Memories", "img": "https://cdn.myanimelist.net/images/anime/7/73507.jpg"},
    ],
    "ไซไฟ": [
      {"t": "Dr. Stone", "img": "https://cdn.myanimelist.net/images/anime/1613/102179.jpg"},
      {"t": "Steins;Gate", "img": "https://cdn.myanimelist.net/images/anime/15/35833.jpg"},
      {"t": "Psycho-Pass", "img": "https://cdn.myanimelist.net/images/anime/5/43393.jpg"},
      {"t": "86 Eighty-Six", "img": "https://cdn.myanimelist.net/images/anime/1987/117507.jpg"},
      {"t": "Cowboy Bebop", "img": "https://cdn.myanimelist.net/images/anime/4/19644.jpg"},
      {"t": "Akira", "img": "https://cdn.myanimelist.net/images/anime/10/77974.jpg"},
      {"t": "Evangelion", "img": "https://cdn.myanimelist.net/images/anime/1314/108922.jpg"},
      {"t": "Trigun", "img": "https://cdn.myanimelist.net/images/anime/7/20310.jpg"},
      {"t": "Cyberpunk", "img": "https://cdn.myanimelist.net/images/anime/1444/127111.jpg"},
      {"t": "Code Geass", "img": "https://cdn.myanimelist.net/images/anime/5/50331.jpg"},
    ],
    "เหนือธรรมชาติ": [
      {"t": "Death Note", "img": "https://cdn.myanimelist.net/images/anime/9/9453.jpg"},
      {"t": "Mob Psycho 100", "img": "https://cdn.myanimelist.net/images/anime/1770/97704.jpg"},
      {"t": "Natsume", "img": "https://cdn.myanimelist.net/images/anime/1209/142998.jpg"},
      {"t": "Durarara!!", "img": "https://cdn.myanimelist.net/images/anime/10/24859.jpg"},
      {"t": "Monogatari", "img": "https://cdn.myanimelist.net/images/anime/11/33657.jpg"},
      {"t": "Bakemonogatari", "img": "https://cdn.myanimelist.net/images/anime/11/12991.jpg"},
      {"t": "Mushishi", "img": "https://cdn.myanimelist.net/images/anime/2/73861.jpg"},
      {"t": "Hell's Paradise", "img": "https://cdn.myanimelist.net/images/anime/1075/133060.jpg"},
      {"t": "Darker Than Black", "img": "https://cdn.myanimelist.net/images/anime/11/48207.jpg"},
      {"t": "Fate/Stay Night", "img": "https://cdn.myanimelist.net/images/anime/9/73507.jpg"},
    ],
    "ชีวิตประจำวัน": [
      {"t": "K-On!", "img": "https://cdn.myanimelist.net/images/anime/10/76120.jpg"},
      {"t": "Yuru Camp", "img": "https://cdn.myanimelist.net/images/anime/1113/141695.jpg"},
      {"t": "Barakamon", "img": "https://cdn.myanimelist.net/images/anime/1410/94101.jpg"},
      {"t": "Non Non Biyori", "img": "https://cdn.myanimelist.net/images/anime/9/54467.jpg"},
      {"t": "Hyouka", "img": "https://cdn.myanimelist.net/images/anime/13/40451.jpg"},
      {"t": "Wolf Children", "img": "https://cdn.myanimelist.net/images/anime/10/39717.jpg"},
      {"t": "Totoro", "img": "https://cdn.myanimelist.net/images/anime/12/76649.jpg"},
      {"t": "Silver Spoon", "img": "https://cdn.myanimelist.net/images/anime/11/50331.jpg"},
      {"t": "Lucky Star", "img": "https://cdn.myanimelist.net/images/anime/12/12991.jpg"},
      {"t": "Aria", "img": "https://cdn.myanimelist.net/images/anime/12/35833.jpg"},
    ],
  };
}

// ---------------------------------------------------------
// [HELPER] Smart Image Widget (แก้ปัญหารูปไม่ขึ้น)
// ---------------------------------------------------------
Widget buildImage(String url, String title) {
  return Image.network(
    url, fit: BoxFit.cover,
    loadingBuilder: (c, child, lp) => lp == null ? child : Container(color: Colors.black26, child: Center(child: CircularProgressIndicator(color: Colors.greenAccent, strokeWidth: 2))),
    errorBuilder: (c, e, s) => Container(
      color: Colors.blueGrey[900],
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.pets, color: Colors.greenAccent, size: 30),
        Padding(padding: EdgeInsets.all(4), child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10))),
      ])),
    ),
  );
}

// ---------------------------------------------------------
// [APP MAIN CONFIG]
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
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF0F0F0F), elevation: 0),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color(0xFF161616), selectedItemColor: Colors.greenAccent, unselectedItemColor: Colors.grey),
      ),
      home: AppData.isLoggedIn ? MainController() : LoginScreen(),
    );
  }
}

// ---------------------------------------------------------
// [หน้า LOGIN]
// ---------------------------------------------------------
class LoginScreen extends StatefulWidget {
  @override _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0F0F0F), Color(0xFF1A2A22)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        padding: EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.pets, size: 80, color: Colors.greenAccent),
          Text("NekoToon", style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.greenAccent)),
          SizedBox(height: 50),
          TextField(controller: userCtrl, decoration: InputDecoration(labelText: "ชื่อผู้ใช้", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
          SizedBox(height: 15),
          TextField(controller: passCtrl, obscureText: true, decoration: InputDecoration(labelText: "รหัสผ่าน", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
          SizedBox(height: 30),
          SizedBox(width: double.infinity, height: 55, child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              if(userCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
                setState(() { AppData.isLoggedIn = true; AppData.userName = userCtrl.text; });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => MainController()));
              }
            },
            child: Text("เข้าสู่ระบบ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          )),
        ]),
      ),
    );
  }
}

class MainController extends StatefulWidget {
  @override _MainControllerState createState() => _MainControllerState();
}
class _MainControllerState extends State<MainController> {
  int _index = 0;
  void _refresh() => setState(() {});

  @override Widget build(BuildContext context) {
    final tabs = [HomePage(onUpdate: _refresh), SearchPage(onUpdate: _refresh), LibraryPage(onUpdate: _refresh), RankPage(), ProfilePage(onUpdate: _refresh)];
    return Scaffold(
      body: tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index, onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'ค้นหา'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_rounded), label: 'คลัง'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'อันดับ'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'โปรไฟล์'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// [หน้า 1] หน้าหลัก - ตกแต่งสวยงาม
// ---------------------------------------------------------
class HomePage extends StatefulWidget {
  final VoidCallback onUpdate;
  HomePage({required this.onUpdate});
  @override _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String selectedCat = "แอกชัน";
  @override Widget build(BuildContext context) {
    final cats = AppData.allAnime.map((m) => m.category).toSet().toList();
    return Scaffold(
      appBar: AppBar(title: Text("NekoToon", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.w900))),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _title("ยอดนิยมตามหมวดหมู่ (1-10)"),
          Container(height: 50, child: ListView(scrollDirection: Axis.horizontal, padding: EdgeInsets.only(left: 15), children: cats.map((c) => Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: ChoiceChip(label: Text(c), selected: selectedCat == c, onSelected: (v) => setState(() => selectedCat = c), selectedColor: Colors.greenAccent, labelStyle: TextStyle(color: selectedCat == c ? Colors.black : Colors.white)))).toList())),
          _rankingList(AppData.allAnime.where((m) => m.category == selectedCat).toList()),
          _title("เรื่องมาแรงที่กำลังฮิต (เลื่อนซ้าย)"),
          _horizontalList(AppData.allAnime.reversed.take(15).toList()),
          _title("แนะนำเฉพาะคุณ"),
          _horizontalList(AppData.allAnime.skip(40).take(10).toList()),
          SizedBox(height: 30),
        ]),
      ),
    );
  }
  Widget _title(String t) => Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 10), child: Text(t, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)));
  
  Widget _rankingList(List<Anime> list) => Container(height: 230, child: ListView.builder(scrollDirection: Axis.horizontal, padding: EdgeInsets.only(left: 10), itemCount: list.length, itemBuilder: (c, i) => GestureDetector(
    onTap: () { list[i].views++; Navigator.push(context, MaterialPageRoute(builder: (c) => DetailPage(manga: list[i]))).then((_) => widget.onUpdate()); },
    child: Container(width: 150, margin: EdgeInsets.all(8), child: Stack(children: [
      ClipRRect(borderRadius: BorderRadius.circular(15), child: buildImage(list[i].imageUrl, list[i].title)),
      Positioned(bottom: -10, left: 5, child: Text("${i + 1}", style: TextStyle(fontSize: 65, fontWeight: FontWeight.w900, color: Colors.white, fontStyle: FontStyle.italic, shadows: [Shadow(blurRadius: 15, color: Colors.black)]))),
    ])),
  )));

  Widget _horizontalList(List<Anime> list) => Container(height: 210, child: ListView.builder(scrollDirection: Axis.horizontal, padding: EdgeInsets.only(left: 10), itemCount: list.length, itemBuilder: (c, i) => GestureDetector(
    onTap: () { list[i].views++; Navigator.push(context, MaterialPageRoute(builder: (c) => DetailPage(manga: list[i]))).then((_) => widget.onUpdate()); },
    child: Container(width: 140, margin: EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(15), child: buildImage(list[i].imageUrl, list[i].title))), SizedBox(height: 5), Text(list[i].title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold))])),
  )));
}

// ---------------------------------------------------------
// [หน้า 4] หน้าค้นหา (ใช้งานได้จริง)
// ---------------------------------------------------------
class SearchPage extends StatefulWidget {
  final VoidCallback onUpdate;
  SearchPage({required this.onUpdate});
  @override _SearchPageState createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  List<Anime> res = AppData.allAnime; 
  void _filter(String q) => setState(() => res = AppData.allAnime.where((a) => a.title.toLowerCase().contains(q.toLowerCase())).toList());

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextField(onChanged: _filter, decoration: InputDecoration(hintText: "ค้นหาชื่ออนิเมะ...", prefixIcon: Icon(Icons.search, color: Colors.greenAccent), border: InputBorder.none))),
      body: GridView.builder(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.7, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: res.length,
        itemBuilder: (c, i) => GestureDetector(
          onTap: () { res[i].views++; Navigator.push(context, MaterialPageRoute(builder: (c) => DetailPage(manga: res[i]))).then((_) => widget.onUpdate()); },
          child: ClipRRect(borderRadius: BorderRadius.circular(10), child: buildImage(res[i].imageUrl, res[i].title)),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// [หน้า 3] หน้าโปรไฟล์
// ---------------------------------------------------------
class ProfilePage extends StatelessWidget {
  final VoidCallback onUpdate;
  ProfilePage({required this.onUpdate});
  @override Widget build(BuildContext context) {
    final saved = AppData.allAnime.where((a) => a.isSaved).length;
    return Scaffold(
      appBar: AppBar(title: Text("โปรไฟล์"), actions: [IconButton(icon: Icon(Icons.logout), onPressed: () { AppData.isLoggedIn = false; onUpdate(); Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => LoginScreen())); })]),
      body: Column(children: [
        Container(
          width: double.infinity, padding: EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.greenAccent.withOpacity(0.15), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(children: [
            CircleAvatar(radius: 55, backgroundColor: Colors.greenAccent, child: Icon(Icons.person, size: 60, color: Colors.black)),
            SizedBox(height: 15),
            Text(AppData.userName, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text("Neko Premium Member", style: TextStyle(color: Colors.greenAccent, letterSpacing: 1.2)),
          ]),
        ),
        ListTile(leading: Icon(Icons.bookmark, color: Colors.greenAccent), title: Text("บันทึกไว้ในคลัง"), trailing: Text("$saved เรื่อง", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        Divider(color: Colors.grey[800]),
        Padding(padding: EdgeInsets.all(20), child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _social(Icons.facebook, Colors.blue), _social(Icons.camera_alt, Colors.pink), _social(Icons.chat_bubble, Colors.green), _social(Icons.video_library, Colors.white),
        ])),
      ]),
    );
  }
  Widget _social(IconData i, Color c) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white10, shape: BoxShape.circle), child: Icon(i, color: c, size: 28));
}

// ---------------------------------------------------------
// [หน้า 7] รายละเอียด (Detail)
// ---------------------------------------------------------
class DetailPage extends StatefulWidget {
  final Anime manga;
  DetailPage({required this.manga});
  @override _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage> {
  double userRating = 0;
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.manga.title), actions: [IconButton(icon: Icon(widget.manga.isSaved ? Icons.bookmark : Icons.bookmark_border, color: Colors.greenAccent), onPressed: () => setState(() => widget.manga.isSaved = !widget.manga.isSaved))]),
      body: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 400, width: double.infinity, child: buildImage(widget.manga.imageUrl, widget.manga.title)),
        Padding(padding: EdgeInsets.all(25), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.greenAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: Text(widget.manga.category, style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold))),
            Text("👁️ ${widget.manga.views}  ⭐ ${widget.manga.averageRating.toStringAsFixed(1)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ]),
          SizedBox(height: 30),
          Text("เนื้อเรื่องย่อสำหรับ ${widget.manga.title}: อนิเมะคุณภาพเยี่ยมที่คุณต้องดู!", style: TextStyle(color: Colors.grey)),
          Divider(height: 50, color: Colors.grey[800]),
          Center(child: Text("ให้คะแนนเรื่องนี้เลย!", style: TextStyle(fontWeight: FontWeight.bold))),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) => IconButton(icon: Icon(i < userRating ? Icons.star : Icons.star_border, color: Colors.orange, size: 45), onPressed: () => setState(() => userRating = i + 1.0)))),
          if(userRating > 0) Center(child: ElevatedButton(onPressed: () { setState(() { widget.manga.totalRatingSum += userRating; widget.manga.ratingCount++; userRating = 0; }); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ขอบคุณสำหรับรีวิว!"))); }, child: Text("ส่งคะแนน"), style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, foregroundColor: Colors.black))),
        ])),
      ])),
    );
  }
}

class LibraryPage extends StatelessWidget {
  final VoidCallback onUpdate; LibraryPage({required this.onUpdate});
  @override Widget build(BuildContext context) {
    final saved = AppData.allAnime.where((a) => a.isSaved).toList();
    return Scaffold(
      appBar: AppBar(title: Text("คลังของฉัน")), 
      body: saved.isEmpty ? Center(child: Text("ยังไม่มีการบันทึก")) : GridView.builder(padding: EdgeInsets.all(12), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.7, mainAxisSpacing: 10, crossAxisSpacing: 10), itemCount: saved.length, itemBuilder: (c, i) => buildImage(saved[i].imageUrl, saved[i].title)),
    );
  }
}
class RankPage extends StatelessWidget { @override Widget build(BuildContext context) {
  final sorted = List.from(AppData.allAnime)..sort((a, b) => b.views.compareTo(a.views));
  return Scaffold(appBar: AppBar(title: Text("อันดับยอดนิยม")), body: ListView.builder(itemCount: 20, itemBuilder: (c, i) => ListTile(leading: Text("#${i+1}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.greenAccent)), title: Text(sorted[i].title), trailing: Text("${sorted[i].views} วิว"))));
}}