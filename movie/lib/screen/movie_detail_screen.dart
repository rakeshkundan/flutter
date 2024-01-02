// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie/constants.dart';
import 'package:movie/services/networking.dart';

class MovieDetailScreen extends StatelessWidget {
  static String id = 'movie_detail';
  dynamic movieData;
  MovieDetailScreen({super.key});

  List<RatingStar> setRating({double ratingInScaleOf10 = 10.0}) {
    List<RatingStar> newList = [];
    int rate = (ratingInScaleOf10 / 2.0).round();
    for (int i = 0; i < 5; i++) {
      if (i < rate) {
        newList.add(
          RatingStar(
            color: kIconColor,
          ),
        );
      } else {
        newList.add(
          RatingStar(
            color: Colors.white,
          ),
        );
      }
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    movieData = ModalRoute.of(context)!.settings.arguments as Map;
    movieData = movieData['data'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.share_outlined,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      ),
                    ),
                    child: Image(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${movieData['backdrop_path'] ?? '/hOx2kPyniEHJj9wquzJMuStFFUG.jpg'}',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image(
                              height: 170.0,
                              width: 100.0,
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movieData['poster_path'] ?? '/tvp7vaLbiUD76P3DTiUe4iz8up9.jpg'}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                            '${movieData['title']}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: Icon(
                                            Icons.discord,
                                            color: Colors.indigo,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Release Date:${movieData['release_date']}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: kInactiveTextColor),
                                  ),
                                  Row(
                                    children: setRating(
                                      ratingInScaleOf10:
                                          movieData['vote_average'] ?? 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                '${movieData['overview']}',
                maxLines: 6,
                style: TextStyle(color: Color(0xFF88878B), letterSpacing: -.5),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                RowIcon(
                  iconData: Icons.bookmark_add_outlined,
                ),
                RowIcon(
                  iconData: Icons.favorite_border_outlined,
                ),
                RowIcon(
                  iconData: Icons.remove_red_eye_outlined,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(color: kIconColor, fontSize: 15.0),
                    ),
                  )
                ],
              ),
            ),
            Reviews(
              reviews: NetworkHelper(
                url:
                    'https://api.themoviedb.org/3/movie/${movieData['id']}/reviews?api_key=b195f787962173c1ee91ddc986379adc',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Reviews extends StatefulWidget {
  final NetworkHelper reviews;
  const Reviews({super.key, required this.reviews});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  dynamic reviewData;
  List<RatingStar> setRating({double ratingInScaleOf10 = 10.0}) {
    List<RatingStar> newList = [];
    int rate = (ratingInScaleOf10 / 2.0).round();
    for (int i = 0; i < 5; i++) {
      if (i < rate) {
        newList.add(
          RatingStar(
            color: kIconColor,
          ),
        );
      } else {
        newList.add(
          RatingStar(
            color: Colors.white,
          ),
        );
      }
    }
    return newList;
  }

  @override
  void initState() {
    reviewData = widget.reviews.getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: FutureBuilder(
          future: reviewData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
            if (snapShot.hasData) {
              var data = snapShot.data;

              if (data["total_results"] > 0) {
                return ListView.builder(
                  padding: EdgeInsets.only(top: 0),
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF2B2B2B),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              data['results'][index]['author_details']
                                          ['avatar_path'] !=
                                      null
                                  ? ('https://image.tmdb.org/t/p/w500${data['results'][index]['author_details']['avatar_path']}')
                                  : 'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${data['results'][index]['author']}'),
                                    Row(
                                      children: setRating(
                                        ratingInScaleOf10: data['results']
                                                    [index]['author_details']
                                                ['rating'] ??
                                            0.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '20 Dec 2023',
                                  style: TextStyle(
                                      color: kInactiveTextColor, fontSize: 12),
                                ),
                                Text(
                                  '${data['results'][index]['content']}',
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 3.5,
                                          ),
                                          child: Text(
                                            '😊109',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 3.5,
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Center(
                                            child: Text(
                                              '👍',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 3.5,
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            '😂109',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 3.5,
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            '❤️109',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 3.5,
                                      ),
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.chat_bubble,
                                            color: Colors.black,
                                            size: 15.0,
                                          ),
                                          Text(
                                            '120',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: data["total_results"],
                );
              } else {
                return Text('No reviews');
              }
            } else if (snapShot.hasError) {
              return Text('Network Problem!');
            }
            return SpinKitRing(
              color: kIconColor,
            );
          },
        ));
    // Expanded(
    //   flex: 1,
    //   child: FutureBuilder(
    //     future: reviewData,
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
    //       if (snapShot.hasData) {
    //         var data = snapShot.data;
    //         // print(data['results'][0]['author_details']['avatar_path']);
    //         return data["total_results"] > 0
    //             ? ListView.builder(
    //                 padding: EdgeInsets.only(top: 0),
    //                 itemBuilder: (context, index) {
    //                   return Container(
    //                     margin: EdgeInsets.symmetric(
    //                         horizontal: 20, vertical: 10),
    //                     padding:
    //                         EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    //                     decoration: BoxDecoration(
    //                       color: Color(0xFF2B2B2B),
    //                       borderRadius: BorderRadius.all(
    //                         Radius.circular(10),
    //                       ),
    //                     ),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         CircleAvatar(
    //                           radius: 25,
    //                           backgroundImage: NetworkImage(
    //                             data['results'][index]['author_details']
    //                                         ['avatar_path'] !=
    //                                     null
    //                                 ? ('https://image.tmdb.org/t/p/w500${data['results'][index]['author_details']['avatar_path']}')
    //                                 : 'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 10,
    //                         ),
    //                         Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Text(
    //                                       '${data['results'][index]['author']}'),
    //                                   Row(
    //                                     children: setRating(
    //                                       ratingInScaleOf10: data['results']
    //                                                       [index]
    //                                                   ['author_details']
    //                                               ['rating'] ??
    //                                           0.0,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                               Text(
    //                                 '20 Dec 2023',
    //                                 style: TextStyle(
    //                                     color: kInactiveTextColor,
    //                                     fontSize: 12),
    //                               ),
    //                               Text(
    //                                 '${data['results'][index]['content']}',
    //                               ),
    //                               SizedBox(
    //                                 height: 10.0,
    //                               ),
    //                               Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Row(
    //                                     children: [
    //                                       Container(
    //                                         decoration: BoxDecoration(
    //                                           color: Colors.white,
    //                                           borderRadius: BorderRadius.all(
    //                                               Radius.circular(20)),
    //                                         ),
    //                                         padding: EdgeInsets.all(5),
    //                                         margin: EdgeInsets.symmetric(
    //                                           horizontal: 3.5,
    //                                         ),
    //                                         child: Text(
    //                                           '😊109',
    //                                           style: TextStyle(
    //                                             color: Colors.black,
    //                                             fontSize: 12.0,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         decoration: BoxDecoration(
    //                                           color: Colors.white,
    //                                           borderRadius: BorderRadius.all(
    //                                               Radius.circular(15)),
    //                                         ),
    //                                         margin: EdgeInsets.symmetric(
    //                                           horizontal: 3.5,
    //                                         ),
    //                                         padding: EdgeInsets.all(5),
    //                                         child: Center(
    //                                           child: Text(
    //                                             '👍',
    //                                             style: TextStyle(
    //                                               color: Colors.black,
    //                                               fontSize: 12.0,
    //                                             ),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         decoration: BoxDecoration(
    //                                           color: Colors.white,
    //                                           borderRadius: BorderRadius.all(
    //                                               Radius.circular(20)),
    //                                         ),
    //                                         margin: EdgeInsets.symmetric(
    //                                           horizontal: 3.5,
    //                                         ),
    //                                         padding: EdgeInsets.all(5),
    //                                         child: Text(
    //                                           '😂109',
    //                                           style: TextStyle(
    //                                             color: Colors.black,
    //                                             fontSize: 12.0,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         decoration: BoxDecoration(
    //                                           color: Colors.white,
    //                                           borderRadius: BorderRadius.all(
    //                                             Radius.circular(20),
    //                                           ),
    //                                         ),
    //                                         margin: EdgeInsets.symmetric(
    //                                           horizontal: 3.5,
    //                                         ),
    //                                         padding: EdgeInsets.all(5),
    //                                         child: Text(
    //                                           '❤️109',
    //                                           style: TextStyle(
    //                                             color: Colors.black,
    //                                             fontSize: 12.0,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   Container(
    //                                     decoration: BoxDecoration(
    //                                       color: Colors.white,
    //                                       borderRadius: BorderRadius.all(
    //                                           Radius.circular(20)),
    //                                     ),
    //                                     margin: EdgeInsets.symmetric(
    //                                       horizontal: 3.5,
    //                                     ),
    //                                     padding: EdgeInsets.all(5),
    //                                     child: Row(
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.center,
    //                                       children: [
    //                                         Icon(
    //                                           Icons.chat_bubble,
    //                                           color: Colors.black,
    //                                           size: 15.0,
    //                                         ),
    //                                         Text(
    //                                           '120',
    //                                           style: TextStyle(
    //                                             color: Colors.black,
    //                                             fontSize: 12.0,
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   )
    //                                 ],
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //                 itemCount: data["total_results"],
    //               )
    //             : Text('No reviews');
    //       } else if (snapShot.hasError) {
    //         return Text('Network Problem!');
    //       }
    //       return SpinKitRing(
    //         color: kIconColor,
    //       );
    //     },
    //   )),
  }
}

// class Reviews extends StatelessWidget {
//   const Reviews({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 1,
//       child: ListView(
//         padding: EdgeInsets.only(top: 0, bottom: 30),
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//             decoration: BoxDecoration(
//               color: Color(0xFF2B2B2B),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 25,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Rakesh Kundan'),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       Text(
//                         '20 Dec 2023',
//                         style:
//                             TextStyle(color: kInactiveTextColor, fontSize: 12),
//                       ),
//                       Text(
//                         'A gang leader tries to keep a promise made to his dying friend and takes on the other criminal gangs.A gang leader tries to keep a promise made to his dying friend and takes on the other criminal gangs.',
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 child: Text(
//                                   '😊109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(15)),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Center(
//                                   child: Text(
//                                     '👍',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(
//                                   '😂109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(20),
//                                   ),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(
//                                   '❤️109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20)),
//                             ),
//                             margin: EdgeInsets.symmetric(
//                               horizontal: 3.5,
//                             ),
//                             padding: EdgeInsets.all(5),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.chat_bubble,
//                                   color: Colors.black,
//                                   size: 15.0,
//                                 ),
//                                 Text(
//                                   '120',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//             decoration: BoxDecoration(
//               color: Color(0xFF2B2B2B),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 25,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Rakesh Kundan'),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       Text(
//                         '20 Dec 2023',
//                         style:
//                             TextStyle(color: kInactiveTextColor, fontSize: 12),
//                       ),
//                       Text(
//                         'A gang leader tries to keep a promise made to his dying friend and takes on the other criminal gangs.A gang leader tries to keep a promise made to his dying friend and takes on the other criminal gangs.',
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 child: Text(
//                                   '😊109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(15)),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Center(
//                                   child: Text(
//                                     '👍',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(
//                                   '😂109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(20),
//                                   ),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(
//                                   '❤️109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20)),
//                             ),
//                             margin: EdgeInsets.symmetric(
//                               horizontal: 3.5,
//                             ),
//                             padding: EdgeInsets.all(5),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.chat_bubble,
//                                   color: Colors.black,
//                                   size: 15.0,
//                                 ),
//                                 Text(
//                                   '120',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//             decoration: BoxDecoration(
//               color: Color(0xFF2B2B2B),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 25,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Rakesh Kundan'),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: kIconColor,
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       Text(
//                         '20 Dec 2023',
//                         style:
//                             TextStyle(color: kInactiveTextColor, fontSize: 12),
//                       ),
//                       Text(
//                         'A gang leader tries to keep a promise made to his dying friend and takes on the other criminal gangs.A gang leader tries to keep a promise made to his dying friend and takes on the other criminal gangs.',
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 child: Text(
//                                   '😊109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(15)),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Center(
//                                   child: Text(
//                                     '👍',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(
//                                   '😂109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(20),
//                                   ),
//                                 ),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 3.5,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(
//                                   '❤️109',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20)),
//                             ),
//                             margin: EdgeInsets.symmetric(
//                               horizontal: 3.5,
//                             ),
//                             padding: EdgeInsets.all(5),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.chat_bubble,
//                                   color: Colors.black,
//                                   size: 15.0,
//                                 ),
//                                 Text(
//                                   '120',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class RatingStar extends StatelessWidget {
  final Color color;
  const RatingStar({
    super.key,
    this.color = kIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      color: color,
    );
  }
}

class RowIcon extends StatelessWidget {
  final IconData iconData;
  const RowIcon({super.key, this.iconData = Icons.favorite_border});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(minHeight: 0, minWidth: 0),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: SimpleDialog(
                  children: [
                    ////////This is still to be designed
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'operation 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SimpleDialogOption(
                      child: Text('operation 2'),
                    ),
                    SimpleDialogOption(
                      child: Text('operation 2'),
                    ),
                    RawMaterialButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      // splashColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                    ////////This is still to be designed
                  ],
                ),
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(
          iconData,
          size: 30.0,
          color: kIconColor,
        ),
      ),
    );
  }
}
