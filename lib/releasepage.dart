import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'anime_service.dart';
import 'model_class.dart';
import 'typography.dart';

class ReleasePage extends StatefulWidget {
  const ReleasePage({Key? key}) : super(key: key);

  @override
  State<ReleasePage> createState() => _ReleasePageState();
}



class _ReleasePageState extends State<ReleasePage> {
  late Future<ModelClass> _releaseFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _releaseFuture = AnimeService().getAnimeList();
  }


  DateTime? _parseReleaseDate(String? releaseDate) {
    if (releaseDate == null || releaseDate.isEmpty) {
      return null;
    }
    try {
      return DateFormat('MMM d, yyyy').parse(releaseDate);
    } catch (e) {
      return null;
    }
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
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "New Releases",
                style: FontClass.title,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<ModelClass>(
                future: _releaseFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    var releases = snapshot.data!.data ?? [];

                    // Sort releases based on the release date (latest first)
                    releases.sort((a, b) {
                      DateTime? dateA = _parseReleaseDate(a.aired?.string);
                      DateTime? dateB = _parseReleaseDate(b.aired?.string);
                      if (dateA == null) return 1; // Consider null dates as last
                      if (dateB == null) return -1;
                      return dateB.compareTo(dateA); // Latest first
                    });

                    if (releases.isEmpty) {
                      return const Center(
                        child: Text(
                          'No releases available.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: releases.length,
                      itemBuilder: (context, index) {
                        Data anime = releases[index];
                        var release = releases[index];
                        String? imageUrl = release.images?.jpg?.imageUrl ??
                            release.images?.jpg?.largeImageUrl ??
                            release.images?.imageUrl;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image section
                              Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.all(6),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: imageUrl != null
                                      ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[800],
                                        child: Icon(
                                          Icons.image,
                                          size: 50,
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
                                      size: 50,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),



                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),

                                    Text(
                                      release.titleEnglish ?? 'No English Title',
                                      style: FontClass.subtitle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Release Date: ${anime.aired?.string ?? 'Unknown'}",
                                      style: FontClass.contentText,
                                    ),
                                    const SizedBox(height: 8),



                                    Text(
                                      release.synopsis ?? 'No description available',
                                      style: FontClass.contentText,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text(
                      'No releases found',
                      style: TextStyle(color: Colors.white),
                    ),
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
