import 'package:animeapp/typography.dart';
import 'package:flutter/material.dart';

class ReleasePage extends StatefulWidget {
  const ReleasePage({super.key});

  @override
  State<ReleasePage> createState() => _ReleasePageState();
}

class _ReleasePageState extends State<ReleasePage> {
  final List<Map<String, String>> releases = [
    {
      'title': 'One Punch Man',
      'releaseDate': 'April 1, 2024',
      'description': 'A story of a hero who can defeat any foe with one punch.',
      'imageUrl': 'https://placekitten.com/200/300',
    },
    {
      'title': 'Attack on Titan',
      'releaseDate': 'March 28, 2024',
      'description': 'The epic fight between humanity and the Titans.',
      'imageUrl': 'https://placekitten.com/201/301',
    },
    {
      'title': 'Naruto Shippuden',
      'releaseDate': 'May 5, 2024',
      'description': 'The journey of a ninja aiming to become Hokage.',
      'imageUrl': 'https://placekitten.com/202/302',
    },
  ];

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
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: releases.length,
                itemBuilder: (context, index) {
                  final release = releases[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height:  MediaQuery.of(context).size.height / 5,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        leading: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              release['imageUrl']!,
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            release['title']!,
                            style: FontClass.subtitle,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Release Date: ${release['releaseDate']}",
                              style: FontClass.contentText,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              release['description']!,
                              style: FontClass.contentText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
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
