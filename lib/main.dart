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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          //width: double.infinity, 
          //length: 100,
          decoration: BoxDecoration(
            //height: 100,
            image: DecorationImage(
              
              image: AssetImage('assets/Distillbackground.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Center(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Distill',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
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

  Widget buildBody() {
    if (currentIndex == 0) {
      return FeedPage();
    } else if (currentIndex == 1) {
      return ProfilePage();
    } else {
      return FeedPage();
    }
  }
}

class FeedPage extends StatefulWidget {
  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  late List<Post> shownPosts;

  @override
  void initState() {
    super.initState();
    shownPosts = List.from(dummyPosts);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Distillbackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SearchBar(onSearch: filterPosts),
        ),
        Expanded(
          child: PostFeed(shownPosts: shownPosts),
        ),
      ],
    );
  }

  void filterPosts(String query) {
    if (query.isNotEmpty) {
      final filteredPosts = dummyPosts
          .where((post) =>
              post.caption.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredPosts.sort((a, b) => b.upvotes.compareTo(a.upvotes));
      setState(() {
        shownPosts = filteredPosts;
      });
    } else {
      setState(() {
        shownPosts = List.from(dummyPosts);
      });
    }
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profileimage1.png'),
              radius: 50.0,
            ),
            Text(
              'May Green',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Education',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Bachelor of Science in Computer Science',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Biometrics',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Height: 5\'6"',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              'Weight: 130 lbs',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Job History',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Software Engineer at XYZ Company',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Interests',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Reading, Traveling, Photography',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  SearchBar({required this.onSearch});

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0), 
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          controller: searchController,
          onChanged: (query) {
            widget.onSearch(query);
          },
          decoration: InputDecoration(
            hintText: 'Search for a problem or product...',
            fillColor: Colors.white70,
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                widget.onSearch('');
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
      ),
    );
  }
}

class PostFeed extends StatelessWidget {
  final List<Post> shownPosts;

  PostFeed({required this.shownPosts});

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
                    Column(
                      children: [
                        SizedBox(height: 8.0),
                        Text(
                          post.userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(post.userAvatar),
                          radius: 50,
                        ),
                      ],
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 14.0),
                          Row(
                            children: [
                              Image.network(
                                post.imageURL,
                                width: 300,
                                height: 300,
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.lightGreen,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    post.caption,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Comments:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                              itemCount: post.comments.length,
                              itemBuilder: (context, commentIndex) {
                              final comment = post.comments[commentIndex];
                              return ListTile(
                                title: Text(comment),
                              );
                            },
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
                        post.upvotes++;
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
}
class Post {
  final String userName;
  final String userAvatar;
  final String caption;
  final String imageURL;
  final List<String> comments;
  int upvotes;

  Post({
    required this.userName,
    required this.userAvatar,
    required this.caption,
    required this.imageURL,
    required this.upvotes,
    required this.comments,
  });
}





List<Post> dummyPosts = [
  Post(
    userName: 'May Green',
    userAvatar: 'assets/profileimage1.png',
    caption: 'I broke a bone and turns out I was deficient in Vitamin D:\n\n\n\n\n\n\n\n\n',
    imageURL: 'assets/vitaminD.png',
    comments: ["Isla: Wait I use this too and I love it!", "user922: Oh my doctor recommended this to me too!"],
    upvotes: 15,
  ),
  Post(
    userName: 'July Blue',
    userAvatar: 'assets/profileimage2.png',
    caption: 'I was having phantom burns and turns out I had anxiety:\n\n\n\n\n\n\n\n\n',
    imageURL: 'assets/anxietyburn.png',
    comments: ["Jerry: Wait I use this too and I love it!", "Bary: Oh my doctor recommended this to me too!"],
    upvotes: 10,
  ),
  Post(
    userName: 'April Yellow',
    userAvatar: 'assets/profileimage3.png',
    caption: 'I have been having so much acne and this has been the only thing that has helped me\n\n\n\n\n\n\n\n',
    imageURL: 'assets/face scrub.png',
    comments: ["Nyra: Wait I use this too and I love it!", "Jenny: Oh my doctor recommended this to me too!"],
    upvotes: 5,
  ),
  Post(
    userName: 'John Smith',
    userAvatar: 'assets/profileimage4.png',
    caption: 'I had constant fatigue and it turned out I was deficient in Vitamin B12:\n\n\n\n\n\n\n\n',
    imageURL: 'assets/vitaminB12.png',
    comments: ["Emma: I had the same issue and Vitamin B12 helped me a lot!", "Alex: My doctor also recommended Vitamin B12 for fatigue."],
    upvotes: 8,
  ),
  Post(
    userName: 'Sarah Thompson',
    userAvatar: 'assets/profileimage5.png',
    caption: 'I had weak immune system and it turned out I was deficient in Vitamin C:\n\n\n\n\n\n\n\n',
    imageURL: 'assets/vitaminC.png',
    comments: ["Michael: Vitamin C really boosts the immune system!", "Olivia: I take Vitamin C supplements too."],
    upvotes: 12,
  ),
  Post(
    userName: 'David Johnson',
    userAvatar: 'assets/profileimage6.png',
    caption: 'I had poor vision and it turned out I was deficient in Vitamin A:\n\n\n\n\n\n\n\n',
    imageURL: 'assets/vitaminA.png',
    comments: ["Sophia: Vitamin A is essential for good vision!", "William: I had the same issue and Vitamin A helped me."],
    upvotes: 6,
  ),
  Post(
    userName: 'Emily Davis',
    userAvatar: 'assets/profileimage7.png',
    caption: 'I had muscle cramps and it turned out I was deficient in Vitamin E:\n\n\n\n\n\n\n\n',
    imageURL: 'assets/vitaminE.png',
    comments: ["Daniel: Vitamin E is great for muscle health!", "Ava: I take Vitamin E supplements too."],
    upvotes: 9,
  ),
  Post(
    userName: 'James Wilson',
    userAvatar: 'assets/profileimage8.png',
    caption: 'I had brittle nails and it turned out I was deficient in Biotin:\n\n\n\n\n\n\n\n\n',
    imageURL: 'assets/biotin.png',
    comments: ["Mia: Biotin really helps with nail health!", "Ethan: My doctor also recommended Biotin for brittle nails."],
    upvotes: 7,
  ),
  Post(
    userName: 'Lily Martinez',
    userAvatar: 'assets/profileimage9.png',
    caption: 'I had poor memory and it turned out I was deficient in Vitamin B6:\n\n\n\n\n\n\n\n',
    imageURL: 'assets/vitaminB6.png',
    comments: ["Noah: Vitamin B6 is important for brain function!", "Sofia: I take Vitamin B6 supplements too."],
    upvotes: 11,
  ),
  Post(
    userName: 'Benjamin Anderson',
    userAvatar: 'assets/profileimage10.png',
    caption: 'I had frequent headaches and it turned out I was deficient in Magnesium:\n\n\n\n\n\n\n\n',
    imageURL: 'assets/magnesium.png',
    comments: ["Charlotte: Magnesium can help reduce headaches!", "Henry: My doctor also recommended Magnesium for headaches."],
    upvotes: 4,
  ),
  Post(
    userName: 'Victoria Clark',
    userAvatar: 'assets/profileimage11.png',
    caption: 'I had joint pain and it turned out I was deficient in Omega-3 fatty acids:\n\n\n\n\n\n\n',
    imageURL: 'assets/omega3.png',
    comments: ["Leo: Omega-3 fatty acids are great for joint health!", "Grace: I take Omega-3 supplements too."],
    upvotes: 3,
  ),
  
];


