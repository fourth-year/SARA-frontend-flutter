import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textButton.dart';
import 'package:sara_front/cubits/Posts_cubit/cubit/posts_cubit.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/screen/EditCommentPage.dart';
import 'package:sara_front/screen/home.dart';
import 'package:sara_front/screen/layout.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({super.key, required this.id});
  int id;
  @override
  State<CommentsPage> createState() => _CommentsPageState(id: id);
}

class _CommentsPageState extends State<CommentsPage> {
  _CommentsPageState({required this.id});
  int id;

  void initState() {
    super.initState();
    PostsCubit.get(context).getComments(id: id);
  }


  bool empty = false;
  var formkey = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // PostsCubit.get(context).getComments(id: id);
    final screenWidth = MediaQuery.of(context).size;

    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if(state is CommentAddedSuccessfully){
          PostsCubit.get(context).getComments(id: id);
        }

      },
      builder: (context, state) {
        if ( PostsCubit.get(context).get_allComments!=null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Layout()),
                  );
                },
                icon: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              title: text(
                themestyle: Theme.of(context).textTheme.headline5,

                text1: 'Comments',
                color: ColorApp.color2,
                size: 22,
              ),
            ),


                       body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: PostsCubit.get(context)
                            .get_allComments!
                            .data
                            .length,
                        itemBuilder: (context, index) {
                          bool isOwner = PostsCubit.get(context)
                              .get_allComments!
                              .data[index]
                              .isOwner;
                          return Container(
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 240, 239, 239),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        child: Image.network(
                                          PostsCubit.get(context)
                                              .get_allComments!
                                              .data[index]
                                              .user
                                              .photo??"",
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return FlutterLogo();
                                          },
                                        ),
                                        radius: 22,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    text(
                                      text1:
                                          "${PostsCubit.get(context).get_allComments!.data[index].user.name}",
                                      size: 17,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    Spacer(),
                                    (isOwner == true)
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, right: 10),
                                            child: PopupMenuButton(
                                              icon: Icon(
                                                  Icons.more_horiz_rounded),
                                              onSelected: (value) {
                                                if (value == "1-Edit") {
                                                  PostsCubit.get(context)
                                                      .getCommentByid(
                                                          id: PostsCubit.get(
                                                                  context)
                                                              .get_allComments!
                                                              .data[index]
                                                              .id);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditCommentPage(),
                                                      ));
                                                } else {
                                                  _openAnimatedDialog(context,
                                                      id: PostsCubit.get(
                                                              context)
                                                          .get_allComments!
                                                          .data[index]
                                                          .id);
                                                }
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: Text('Edit'),
                                                  value: "1-Edit",
                                                ),
                                                PopupMenuItem(
                                                  child: Text('Delete'),
                                                  value: "2-Delete",
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 10, left: 10, bottom: 10),
                                  child: ReadMoreText(
                                    isExpandable: true,
                                    PostsCubit.get(context)
                                        .get_allComments!
                                        .data[index]
                                        .comment,
                                    style: TextStyle(),
                                    trimLines: 3,
                                    trimMode: TrimMode.Line,
                                    colorClickableText: ColorApp.color2,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 21, 91, 148),
                                    ),
                                    lessStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 21, 91, 148),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width:  screenWidth.width/4 +  screenWidth.width/2

                          ,decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 240, 239, 239),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: comment,
                              onChanged: (value) {
                                if (value == null || value.isEmpty) {
                                  empty;
                                } else
                                  empty = true;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  empty;
                                } else
                                  empty = true;
                              },
                              decoration: InputDecoration(
                                  hintText: 'type what you want ...',
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none)),
                              //  expands: true,
                              minLines: 1,
                              maxLines: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // (empty == false)
                        //     ? Container(
                        //         height: 45,
                        //         width: 45,
                        //         decoration: BoxDecoration(
                        //             shape: BoxShape.circle,
                        //             color: Colors.black38),
                        //         child: Center(
                        //             child: IconButton(
                        //                 onPressed: () {},
                        //                 icon: Icon(
                        //                   Icons.send,
                        //                   color: Colors.white,
                        //                 ))),
                        //       )
                        //     :
                        Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorApp.color2),
                                child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            PostsCubit.get(context).addComment(
                                              comment: comment.text,
                                              post_id: CachHelper.getData(
                                                  key: "post_id"),
                                            );
                                            comment.clear();
                                            PostsCubit.get(context).getComments(id: id);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ))),
                              ),
                      ],
                    ),
                  ],
                ),
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

  _openAnimatedDialog(BuildContext context, {required id}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: AlertDialog(
            backgroundColor: ColorApp.colorback,
            content: Text('Are you sure you want to delete this comment?'.tr()),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            actions: [
              textButton(
                  text: 'Cancel'.tr(),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              textButton(
                  text: 'Delete'.tr(),
                  color: ColorApp.color2,
                  onTap: () {
                    PostsCubit.get(context).DeleteComment(id: id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsPage(
                              id: CachHelper.getData(key: "post_id")),
                        ));
                    PostsCubit.get(context)
                        .getComments(id: CachHelper.getData(key: "post_id"));
                  })
            ],
          ),
        );
      },
    );
  }
}
