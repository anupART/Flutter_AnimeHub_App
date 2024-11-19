import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> animeList = [
    {'title': 'Naruto', 'imageUrl': 'https://placekitten.com/200/300'},
    {'title': 'Attack on Titan', 'imageUrl': 'https://placekitten.com/201/301'},
    {'title': 'One Piece', 'imageUrl': 'https://placekitten.com/202/302'},
    {'title': 'Demon Slayer', 'imageUrl': 'https://placekitten.com/203/303'},
  ];

  List<Map<String, String>> getFilteredAnime() {
    String query = _searchController.text.toLowerCase();
    return animeList
        .where((anime) => anime['title']!.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomBottomNavBar(),
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
                },style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                focusColor: Colors.white,
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
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: getFilteredAnime().length,
                itemBuilder: (context, index) {
                  var anime = getFilteredAnime()[index];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              anime['imageUrl']!,
                              width: 120,
                              height: 145,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                        child: Text(

                          anime['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
