import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/music_provider.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
    final providerTrue = Provider.of<MediaProvider>(context);
    final providerFalse = Provider.of<MediaProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<MediaProvider>(
        builder: (context, provider, child) => Column(
          children: [
            SizedBox(height: 32),
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                  image:  provider.musicModal!.data.results[providerTrue.selectedSong].image.length > 2
                      ? DecorationImage(
                    image: NetworkImage(provider.musicModal!.data.results[providerTrue.selectedSong].image[2].url),
                  )
                      : null,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              provider.musicModal!.data.results[providerTrue.selectedSong].name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.055,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              provider.musicModal!.data.results[providerTrue.selectedSong].artists.primary != null &&
                  provider.musicModal!.data.results[providerTrue.selectedSong].artists.primary!.isNotEmpty
                  ? provider.musicModal!.data.results[providerTrue.selectedSong].artists.primary![0].name
                  : 'Unknown Artist',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xff768cbe),
                fontSize: w * 0.05,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            StreamBuilder(
              stream: provider.getCurrentPosition(),
              builder: (context, snapshot) {
                final duration = provider.duration;
                if (duration == null) {
                  return SizedBox(); // Or handle this case as needed
                }
                return Slider(
                  value: (snapshot.data?.inSeconds.toDouble() ?? 0.0),
                  onChanged: (value) {
                    provider.jumpSong(Duration(seconds: value.toInt()));
                  },
                  max: duration.inSeconds.toDouble(),
                  activeColor: Colors.purple,
                  inactiveColor: Colors.white70,
                );
              }
            ),
            StreamBuilder(
              stream: provider.getCurrentPosition(),
              builder: (context, snapshot) {
                final currentPosition = snapshot.data ?? Duration.zero;
                final maxDuration = provider.duration ?? Duration.zero;

                String formatDuration(Duration duration) {
                  String twoDigits(int n) => n.toString().padLeft(2, '0');
                  final minutes = twoDigits(duration.inMinutes.remainder(60));
                  final seconds = twoDigits(duration.inSeconds.remainder(60));
                  return "$minutes:$seconds";
                }

                return Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Add a null check for currentPosition before formatting
                      Text(
                        formatDuration(currentPosition),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: w * 0.04,
                        ),
                      ),
                      // Add a null check for maxDuration before formatting
                      Text(
                        formatDuration(maxDuration),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: w * 0.04,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 50,),
                Icon(CupertinoIcons.shuffle,color: Colors.white,),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.skip_previous, color: Colors.white),
                  onPressed: () {
                    providerFalse.backSong();
                  },
                ),
                IconButton(
                  icon: (provider.isPlay) ? Icon(Icons.pause_circle, color: Colors.purple, size: 48) : Icon(Icons.play_circle, color: Colors.purple, size: 48),
                  onPressed: () {
                    providerFalse.playSong();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.white),
                  onPressed: () {
                    providerFalse.forwardSong();
                  },
                ),
                Spacer(),
                Icon(CupertinoIcons.repeat,color: Colors.white,),
                SizedBox(width: 50,),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        ],
      ),
    );
  }
}
