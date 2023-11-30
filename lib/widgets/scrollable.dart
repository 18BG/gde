import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();
  final List<String> universities =
      List.generate(30, (index) => 'Université ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
            controller: _pageController,
            itemCount: (universities.length / 10).ceil(),
            itemBuilder: (context, pageIndex) {
              int startIndex = pageIndex * 10;
              int endIndex = (pageIndex + 1) * 10;
              endIndex = endIndex > universities.length
                  ? universities.length
                  : endIndex;

              List<String> currentPageUniversities =
                  universities.sublist(startIndex, endIndex);

              return UniversityPage(universities: currentPageUniversities);
            },
          ),
        ),
        Positioned(
          left: 8.0,
          top: 0.0,
          bottom: 0.0,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_pageController.page! > 0) {
                _pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
            },
          ),
        ),
        Positioned(
          right: 8.0,
          top: 0.0,
          bottom: 0.0,
          child: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              if (_pageController.page! <
                  (universities.length / 10).ceil() - 1) {
                _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
            },
          ),
        ),
      ],
    );
  }
}

class UniversityPage extends StatelessWidget {
  final List<String> universities;

  UniversityPage({required this.universities});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (String university in universities)
            UniversityCard(name: university),
        ],
      ),
    );
  }
}

class UniversityCard extends StatelessWidget {
  final String name;

  UniversityCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(name),
      ),
    );
  }
}
