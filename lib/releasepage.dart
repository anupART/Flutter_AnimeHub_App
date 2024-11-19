import 'package:animeapp/typography.dart';
import 'package:flutter/material.dart';

class ReleasePage extends StatefulWidget {
  const ReleasePage({super.key});

  @override
  State<ReleasePage> createState() => _ReleasePageState();
}

class _ReleasePageState extends State<ReleasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Text(
              "New Releases",
              style: FontClass.title,
            ),
          ),
          SizedBox(height: 20,),

        ],
      )),
    );
  }
}
