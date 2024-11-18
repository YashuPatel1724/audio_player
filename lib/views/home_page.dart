import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/music_provider.dart';

class MusicHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'), // Replace with profile image
        ),
        title: Text(
          'Yashu Patel\nGold Member',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Listen The Latest Musics',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Music',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[850],
                prefixIcon: Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Recently Played',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildMusicCard('https://i.ytimg.com/vi/dPmhZ8l7zfA/maxresdefault.jpg'),
                  _buildMusicCard('https://i.ytimg.com/vi/xdj5ofJCbSg/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLC4DVjDIAc_bt-REhssk5lCFjPbrw'),
                  _buildMusicCard('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkQZumBctkQgN5PfESTZC-rxZq_ArVU2FsNw&s'),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Recommend for you',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: ListView(
                children: [
                  Provider.of<MediaProvider>(context).musicModal == null
                      ? Center(child: CircularProgressIndicator())
                      : Consumer<MediaProvider>(
                    builder: (context, provider, child) => ListView.builder(
                      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 2,
                      //   crossAxisSpacing: 12.0,
                      //   mainAxisSpacing: 12.0,
                      //   childAspectRatio: 0.75,
                      // ),
                      physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
                      shrinkWrap: true,
                      itemCount: provider.musicModal?.data.results.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.selectSong(index);
                            provider.setSong(provider.musicModal!.data.results[index].downloadUrl[1].url);
                            Navigator.of(context).pushNamed('/play');
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                            width: 70,
                            height: 70 ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: provider.musicModal!.data.results[index].image.length > 2
                                  ? DecorationImage(
                                image: NetworkImage(provider.musicModal!.data.results[index].image[2].url),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                          ),
                            title: Text(
                              provider.musicModal?.data.results[index].name ?? 'Unknown Song',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.044,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              provider.musicModal?.data.results[index].artists.primary?.isNotEmpty == true
                                  ? provider.musicModal!.data.results[index].artists.primary![0].name
                                  : 'Unknown Artist',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Color(0xff768cbe),
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          // child: Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(16),
                          //   ),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         width: double.infinity,
                          //         height: h * 0.2,
                          //         decoration: BoxDecoration(
                          //           borderRadius: const BorderRadius.only(
                          //             topRight: Radius.circular(16),
                          //             topLeft: Radius.circular(16),
                          //           ),
                          //           image: provider.musicModal!.data.results[index].image.length > 2
                          //               ? DecorationImage(
                          //             image: NetworkImage(provider.musicModal!.data.results[index].image[2].url),
                          //             fit: BoxFit.cover,
                          //           )
                          //               : null,
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               provider.musicModal?.data.results[index].name ?? 'Unknown Song',
                          //               overflow: TextOverflow.ellipsis,
                          //               maxLines: 1,
                          //               style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: w * 0.044,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //             Text(
                          //               provider.musicModal?.data.results[index].artists.primary?.isNotEmpty == true
                          //                   ? provider.musicModal!.data.results[index].artists.primary![0].name
                          //                   : 'Unknown Artist',
                          //               overflow: TextOverflow.ellipsis,
                          //               maxLines: 1,
                          //               style: TextStyle(
                          //                 color: Color(0xff768cbe),
                          //                 fontSize: w * 0.04,
                          //                 fontWeight: FontWeight.w400,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
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

  Widget _buildMusicCard(String title) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.network(
        fit: BoxFit.fitHeight,
        title,
      ),
    );
  }

  Widget _buildRecommendationTile(String title, String artist, String streams) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: Text('$artist\n$streams', style: TextStyle(color: Colors.white70, fontSize: 12)),
    );
  }
}
