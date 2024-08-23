import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  final String articleTitle;
  final List<Map<String, String>> articleContent;

  const ArticlePage({super.key, required this.articleTitle, required this.articleContent});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < widget.articleContent.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleTitle),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        itemCount: widget.articleContent.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                if (details.primaryVelocity! < 0) {
                  nextPage();
                } else if (details.primaryVelocity! > 0) {
                  previousPage();
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color:
                      Colors.grey[200], // Background color for the sub-header
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.articleContent[index]['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        '${index + 1}/${widget.articleContent.length}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              widget.articleContent[index]['content']!,
                              style: const TextStyle(
                                  fontSize: 18), // Increased font size
                            ),
                            if (widget.articleContent[index]['image'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Image.asset(
                                    widget.articleContent[index]['image']!),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
