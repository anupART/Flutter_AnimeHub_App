import 'dart:ui';

import 'package:animeapp/typography.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'anime_service.dart';
import 'color.dart';
import 'model_class.dart';

class AnimeDetailPage extends StatefulWidget {
  final String title;
  final String imageUrl;

  AnimeDetailPage({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Future<ModelClass> _animeFuture;

  @override
  void initState() {
    super.initState();
    _animeFuture = AnimeService().getAnimeList();
  }



  Future<void> _launchTrailer(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No trailer available')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:
            const Text('Anime Detail', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: screenHeight / 3,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight / 5),
                Container(
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                widget.imageUrl,
                                width: screenWidth / 3,
                                height: screenHeight / 5.2,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: screenWidth / 3,
                                    height: screenHeight / 4.3,
                                    color: Colors.grey[800],
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey[600],
                                      size: 50,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: FontClass.subtitle.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  FutureBuilder<ModelClass>(
                                    future: _animeFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        var animeData =
                                            snapshot.data?.data ?? [];
                                        if (animeData.isNotEmpty) {
                                          var anime = animeData[
                                              0];

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Aired: ${anime.aired?.string ?? 'N/A'}',
                                                style: FontClass.contentText,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "Anime Rating: ${anime.score?.toStringAsFixed(1) ?? 'N/A'}",
                                                style: FontClass.contentText,
                                              ),
                                              const SizedBox(height: 8),
                                            ],
                                          );
                                        }
                                      }
                                      return Container();
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Adventure, Drama, Fantasy',
                                    style: FontClass.contentText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'AniPlex',
                                    style: FontClass.contentText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<ModelClass>(
                      future: _animeFuture,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: Size(screenWidth * 0.9, 50),
                          ),
                          onPressed: () {
                            final trailerUrl =
                                snapshot.data?.data?[0].trailer?.url;
                            _launchTrailer(trailerUrl);
                          },
                          child: const Text(
                            'Play Trailer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<ModelClass>(
                      future: _animeFuture,
                      builder: (context, snapshot) {
                        String synopsis = snapshot.data?.data?[0].synopsis ??
                            'No synopsis available';



                        String truncatedSynopsis = synopsis.length > 200
                            ? synopsis.substring(0, 200) + '...'
                            : synopsis;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Anime Synopsis',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              truncatedSynopsis,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      }),
                ),


                _buildTrendingAnime(),
              ],
            ),
          ),
        ],
      ),
    );
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
                                    child: imageUrl != null &&
                                            imageUrl.isNotEmpty
                                        ? Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey[800],
                                                child: Icon(
                                                  Icons.image,
                                                  size: 40,
                                                  color: Colors.grey[600],
                                                ),
                                              );
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Container(
                                                color: Colors.grey[800],
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
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
                                          anime.score?.toStringAsFixed(1) ??
                                              'N/A',
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
                  child: Text('No anime found',
                      style: TextStyle(color: Colors.white)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
