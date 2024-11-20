import 'package:flutter/material.dart';
import 'anime_service.dart';
import 'animedetail_page.dart';

import 'model_class.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<ModelClass> _animeFuture;

  @override
  void initState() {
    super.initState();
    _animeFuture = AnimeService().getAnimeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                cursorColor: Colors.white,
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.grey[800],
                  hintText: 'Search for anime...',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<ModelClass>(
                future: _animeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    var animeList = snapshot.data!.data ?? [];
                    var filteredAnime = animeList
                        .where((anime) =>
                        (anime.titleEnglish ?? '')
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()))
                        .toList();

                    return GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.7,

                      ),
                      itemCount: filteredAnime.length,
                      itemBuilder: (context, index) {
                        var anime = filteredAnime[index];
                        String? imageUrl = anime.images?.jpg?.imageUrl ??
                            anime.images?.jpg?.largeImageUrl ??
                            anime.images?.imageUrl;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnimeDetailPage(
                                  title: anime.titleEnglish ?? 'No English Title',
                                  imageUrl: imageUrl ?? '',
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        width: double.infinity,
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
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  anime.titleEnglish ?? 'No English Title',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}