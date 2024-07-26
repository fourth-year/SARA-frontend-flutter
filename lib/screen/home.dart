import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/cubits/Posts_cubit/cubit/posts_cubit.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/screen/comments_page.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // void initState() {
  //   super.initState();
  //   PostsCubit.get(context).getAllPosts();
  // }

  @override
  Widget build(BuildContext context) {
    PostsCubit.get(context).getAllPosts();
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is LikeAddedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Like error',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true,
              closeIconColor: Colors.black,
              backgroundColor: ColorApp.colorback,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GetAllPostsSuccessfully) {
          print(PostsCubit.get(context).get_allPosts?.data.length);

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 240, 239, 239),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.only(
                              //           top: 10, right: 10),
                              //       child: Icon(
                              //         Icons.more_horiz_outlined,
                              //         size: 25,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 10, left: 10),
                                child: ReadMoreText(
                                  isExpandable: true,
                                  PostsCubit.get(context)
                                      .get_allPosts!
                                      .data[index]
                                      .text,
                                  style: TextStyle(),
                                  trimLines: 3,
                                  trimMode: TrimMode.Line,
                                  colorClickableText: ColorApp.color2,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 21, 91, 148),
                                  ),
                                  lessStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 21, 91, 148),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (PostsCubit.get(context)
                                            .get_allPosts!
                                            .data[index]
                                            .isLiked) {
                                          PostsCubit.get(context).removeLike(
                                            post_id: PostsCubit()
                                                .get_allPosts
                                                ?.data[index]
                                                .id,
                                          );
                                        } else {
                                          PostsCubit.get(context).addLike(
                                            post_id: PostsCubit()
                                                .get_allPosts
                                                ?.data[index]
                                                .id,
                                          );
                                        }
                                        setState(() {});
                                      },
                                      child: (PostsCubit.get(context)
                                              .get_allPosts!
                                              .data[index]
                                              .isLiked)
                                          ? Icon(
                                              Icons.favorite_rounded,
                                              color: Color.fromARGB(
                                                  255, 148, 23, 14),
                                              size: 22,
                                            )
                                          : Icon(
                                              Icons.favorite_outline_rounded,
                                              size: 22,
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 7),
                                      child: Text(
                                          " ${PostsCubit.get(context).get_allPosts!.data[index].likes.length}"),
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        CachHelper.saveData(
                                            key: "post_id",
                                            value: PostsCubit.get(context)
                                                .get_allPosts!
                                                .data[index]
                                                .id);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentsPage(
                                                        id: PostsCubit.get(
                                                                context)
                                                            .get_allPosts!
                                                            .data[index]
                                                            .id)));
                                      },
                                      child: Icon(
                                        Icons.mode_comment_outlined,
                                        size: 22,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 7),
                                      child: Text(
                                          " ${PostsCubit.get(context).get_allPosts!.data[index].comments.length}"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount:
                          PostsCubit.get(context).get_allPosts!.data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}

//   Future _displayBottomSheet(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white70,
//       builder: (context) {
//         return Comments();
//       },
//       isScrollControlled: true,
//     );
//   }
// }

// class Comments extends StatelessWidget {
//   const Comments({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40), topRight: Radius.circular(40))),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SizedBox(
//           child: ListView.separated(
//             itemCount: PostsCubit.get(context).get_allComments!.data.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 400,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Color.fromARGB(255, 240, 239, 239),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10, right: 10),
//                           child: Icon(
//                             Icons.more_horiz_outlined,
//                             size: 25,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 15, right: 10, left: 10),
//                       child: ReadMoreText(
//                         isExpandable: true,
//                         PostsCubit.get(context)
//                             .get_allComments!
//                             .data[index]
//                             .comment,
//                         style: TextStyle(),
//                         trimLines: 3,
//                         trimMode: TrimMode.Line,
//                         colorClickableText: ColorApp.color2,
//                         trimCollapsedText: 'Show more',
//                         trimExpandedText: 'Show less',
//                         moreStyle: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: const Color.fromARGB(255, 21, 91, 148),
//                         ),
//                         lessStyle: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: const Color.fromARGB(255, 21, 91, 148),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             separatorBuilder: (context, index) => SizedBox(height: 5),
//           ),
//         ),
//       ),
//     );
//   }
// }


/*Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 240, 239, 239),
              ),
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10,right: 10),
                          child: Icon(
                            Icons.more_horiz_outlined,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ReadMoreText(
                        ' shall be made generally available and higher educadنمتشسيسSKJFKJEHSKJFesjkbfjkebjkbfjkbejkbgjskbgjsbdjgbjkrbgsrjgbjskrbgskjrgsnklfkjdsfkjndkjngfdjkgnkfdngkjdhfjkhgdslkhvhfkjvkfdjgoijdoifjgkjflkjvfojbgdfoijgbiofjibfkjktion shall be equally accessible to all on the basis of merijkjkkkknnckjdscvndsmvkdsbvkjdk.jvnkjndjkvjkndkjvnjkdbvkjdnskvkdsnkvnkjsdnjkvnskdnvjkndks.vnjkdsbjkvndnvjkndkjvndkjvndnvjndjkvnkn.',
                        trimLines: 3,
                        isExpandable: true,
                        trimMode: TrimMode.Line,
                        colorClickableText: ColorApp.color2,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 21, 91, 148),
                        ),
                        lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 21, 91, 148),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_outline_rounded,
                            size: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.mode_comment_outlined,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  */