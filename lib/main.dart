//import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distill \n Find The Essence of What You Are Looking For',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 


  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Distillbackground.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Center(
          child: Text(
            'Distill \n Find The Essence of What You Are Looking For',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),


      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }



  Widget _buildBody() {
    if (_currentIndex == 0) {
      return FeedPage();
    } else if (_currentIndex == 1) {
      return ProfilePage();
    } 
    else {
      return FeedPage();
    }
  }
}


class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Distillbackground.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SearchBar(onSearch: (value) {
              
            }),
          ),
          Expanded(
            child: PostFeed(),
          ),
        ],
      ),





    );
  }
}



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            // Add profile picture logic here
            backgroundImage: AssetImage('assets/profileimage1.png'),
            radius: 50.0,
          ),
          Text(
            // Add biography text here
            'May Green',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Add more profile information as needed
        ],
      ),
    );
  }
}



class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  SearchBar({required this.onSearch});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        onChanged: filterPosts,
        decoration: InputDecoration(
          hintText: 'Search for a problem or product...',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  void filterPosts(String query) {
    if (query.isNotEmpty) {
        
          final filteredPosts = dummyPosts.where((post) {
          final postLower = post.caption.toLowerCase();
          final searchLower = query.toLowerCase();
          return postLower.contains(searchLower);
        }).toList();
        filteredPosts.sort((a, b) => b.upvotes.compareTo(a.upvotes));
        setState(() {
          shownPosts = filteredPosts;
        });
    } else {
      setState(() {
        shownPosts = dummyPosts;
      });
    }
  }
//  void _updatePosts(String query) {
////    setState(() {
 //     filteredPosts = posts;
 //   });
 // }


}

class PostFeed extends StatefulWidget {
  @override
  _PostFeedState createState() => _PostFeedState();
}


class _PostFeedState extends State<PostFeed> {

  //List<Post> filteredPosts = dummyPosts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shownPosts.length,
      itemBuilder: (context, index) {
        final post = shownPosts[index];
        return Card(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(post.userAvatar),
                      radius: 50,
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.userName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Row(
                            children: [
                              Image.network(
                                post.imageURL,
                                width: 300,
                                height: 300,
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  post.caption,
                                  style: TextStyle(
                                    fontSize: 18,
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
                SizedBox(height: 12.0),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        setState(() {
                          post.upvotes++;
                        });
                      },
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '${post.upvotes} upvotes',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
    
  


  
  //List<Post> get filteredPosts {
  //  final query = ModalRoute.of(context)!.settings.arguments as String;
  //  return dummyPosts.where((post) {
  //    final postLower = post.caption.toLowerCase();
  //    final searchLower = query.toLowerCase();
  //    return postLower.contains(searchLower);
  //  }).toList();
  //}


}


//      return ListView.builder(
 //     itemCount: dummyPosts.length,
 //     itemBuilder: (context, index) {
 //       return PostCard(dummyPosts[index]);
 //     },


class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CircleAvatar(
            // Add profile picture logic here
            backgroundImage: AssetImage('assets/profileimage1.png'),
            radius: 50.0,


          ),
          Text(
   //         // Add biography text here
            'May Green',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          
    //      Text(
    //        // Add education information here


    //      ),
        ],
      ),
    );
  }
}
 

//class PostFeed extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return ListView.builder(
//      itemCount: dummyPosts.length,
//      itemBuilder: (context, index) {
//        return PostCard(dummyPosts[index]);
//      },
//    );
//  }
//}

class PostCard extends StatefulWidget {
  final Post post;

  PostCard(this.post);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _upvotes = 0;

  @override
  void initState() {
    _upvotes = widget.post.upvotes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.post.userAvatar),
            ),
            title: Text(widget.post.userName),
            subtitle: Text(widget.post.caption),
          ),
          Image.network(widget.post.imageURL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {
                  setState(() {
                    _upvotes++;
                  });
                },
              ),
              Text('Upvotes: $_upvotes'),
            ],
          ),
        ],
      ),
    );
  }
}

class Post {
  final String userName;
  final String userAvatar;
  final String caption;
  final String imageURL;
 int upvotes;

  Post({
    required this.userName,
    required this.userAvatar,
    required this.caption,
    required this.imageURL,
    required this.upvotes,
  });
}

List<Post> shownPosts = dummyPosts;


List<Post> dummyPosts = [
  Post(
    userName: 'May Green',
    userAvatar: 'assets/profileimage1.png',
    caption: 'I broke a bone and turns out I was defficient in VitaminD:',
    imageURL: 'assets/vitaminD.png',
    upvotes: 15,
  ),
  Post(
    userName: 'July Blue',
    userAvatar: 'assets/profileimage2.png',
    caption: 'I was having phantom burns and turns out I had anxiety:',
    imageURL: 'assets/anxietyburn.png',
    upvotes: 10,
  ),
  Post(
    userName: 'April Yellow',
    userAvatar: 'assets/profileimage3.png',
    caption: 'I have been having so much acne and this has been the only thing that has helped me',
    imageURL: 'assets/face scrub.png',
    upvotes: 5,
  ),
  // Add more dummy posts as needed
];
