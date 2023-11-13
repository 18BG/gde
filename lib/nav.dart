import 'package:flutter/material.dart';
import 'package:gde/main.dart';
import 'package:gde/screens/home_page.dart';
import 'package:gde/widgets/mytext.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int selected = 2;
  final List<Widget> _pges = [
    const Center(
      child: Text("About"),
    ),
    const Center(
      child: Text("News"),
    ),
    const HomePage(),
    const Center(
      child: Text("Premiere"),
    ),
    const Center(
      child: Text("IA"),
    )
  ];

  void changeIndex(int value) {
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CText(
          "G-D-E",
          size: 25,
          color: Colors.blueGrey,
        ),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      ),
      body: _pges.elementAt(selected),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(8, 20),
            blurRadius: 25,
          )
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(

              // type: BottomNavigationBarType.fixed,
              onTap: changeIndex,
              selectedItemColor: Colors.blueGrey[600],
              unselectedItemColor: Colors.black,
              selectedFontSize: 18,
              currentIndex: selected,
              backgroundColor: Colors.blueGrey,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  label: "A propos",
                ),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), label: "Nouvelles"),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Accueil"),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: "Catégorie"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/icons/Icon IA.png",
                      height: 25,
                      //width: 20,
                    ),
                    label: "Assistan IA")
              ]),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class BottomNavigationBarExample extends StatefulWidget {
//   const BottomNavigationBarExample({super.key});

//   @override
//   State<BottomNavigationBarExample> createState() =>
//       _BottomNavigationBarExampleState();
// }

// class _BottomNavigationBarExampleState
//     extends State<BottomNavigationBarExample> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Home',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 1: Business',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 2: School',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 3: Settings',
//       style: optionStyle,
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BottomNavigationBar Sample'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//             //backgroundColor: Colors.red,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Business',
//             //backgroundColor: Colors.green,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'School',
//             //backgroundColor: Colors.purple,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//             //backgroundColor: Colors.pink,
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         //selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
