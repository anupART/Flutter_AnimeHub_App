import 'package:animeapp/color.dart';
import 'package:animeapp/releasepage.dart';
import 'package:animeapp/serachpage.dart';
import 'package:animeapp/typography.dart';
import 'package:flutter/material.dart';

import 'anime_service.dart';
import 'model_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<ModelClass> _animeFuture;

  @override
  void initState() {
    super.initState();
    _animeFuture = AnimeService().getAnimeList();
  }


  Widget _buildTrendingAnime() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            height: 300,
            child: FutureBuilder<ModelClass>(
              future: _animeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (snapshot.hasData) {
                  var animeList = snapshot.data!.data ?? [];
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: animeList.length,
                    itemBuilder: (context, index) {
                      var anime = animeList[index];
                      String? imageUrl = anime.images?.jpg?.imageUrl ??
                          anime.images?.jpg?.largeImageUrl ??
                          anime.images?.imageUrl;
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: 120,
                                    height: 160,
                                    child: imageUrl != null && imageUrl.isNotEmpty
                                        ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[800],
                                          child: Icon(
                                            Icons.image,
                                            size: 40,
                                            color: Colors.grey[600],
                                          ),
                                        );
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Container(
                                          color: Colors.grey[800],
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                        : Container(
                                      color: Colors.grey[800],
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          anime.score?.toStringAsFixed(1) ?? 'N/A',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 120,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                softWrap: true,
                                anime.titleEnglish ?? 'No English Title',
                                style: FontClass.subtitle,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('No anime found', style: TextStyle(color: Colors.white)),
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
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.only(left: 8,right: 8,top: 8),
          child: Icon(Icons.menu, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 8,right: 8,top: 8),
            child: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<ModelClass>(
                future: _animeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 500,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final featuredAnime = snapshot.data?.data?.first;
                  final imageUrl = featuredAnime?.images?.jpg?.largeImageUrl ??
                      featuredAnime?.images?.jpg?.imageUrl ??
                      featuredAnime?.images?.imageUrl ?? '';

                  return Stack(
                    children: [
                      Container(
                        height: 500,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                              print('Error loading image: $exception');
                            },
                          ),
                          color: Colors.grey[900],
                        ),
                      ),
                      Container(
                        height: 500,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
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
                              featuredAnime?.titleEnglish ?? 'No English Title',
                              style: FontClass.title,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'After reaching the squid-like abilities...',
                                style: FontClass.subtitle,
                                textAlign: TextAlign.center,
                              ),
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
                                  label: Text('My List', style: FontClass.contentText),
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
                      )
                    ],
                  );
                },
              ),
              _buildTrendingAnime(),
            ],
          ),
        ),
      ),
    );
  }
}