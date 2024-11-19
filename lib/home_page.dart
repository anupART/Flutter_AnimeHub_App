import 'package:animeapp/color.dart';
import 'package:animeapp/releasepage.dart';
import 'package:animeapp/serachpage.dart';
import 'package:animeapp/typography.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, String>> trendingAnime = [
    {
      'title': 'Frieren: Beyond',
      'imageUrl': 'https://placeholder.com/180x250',
      'rating': '9.22'
    },
    {
      'title': 'One Piece Fan Letter',
      'imageUrl': 'https://placeholder.com/180x250',
      'rating': '8.5'
    },
    {
      'title': 'Fullmetal AI',
      'imageUrl': 'https://placeholder.com/180x250',
      'rating': '8.8'
    },
  ];
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex  = index;
    });
  }


  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: Colors.white),
          const Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildTrendingAnime() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trending Anime', style: FontClass.subtitle),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                      fontFamily: FONT_FAMILY,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: buttonColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingAnime.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 120,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  trendingAnime[index]['rating'] ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 120,
                        child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            trendingAnime[index]['title']!,
                            style: FontClass.subtitle),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Stack(
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const NetworkImage(
                            'https://placeholder.com/400x400'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 50,
                    right: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'The Squid Girl 2',
                          style: FontClass.title,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'After reaching the squid-like abilities...',
                          style: FontClass.subtitle,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Play',
                                style: FontClass.contentText,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label:
                              Text('My List', style: FontClass.contentText),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildTrendingAnime(),
            ],
          ),
        ),
      ),

    );
  }
}
