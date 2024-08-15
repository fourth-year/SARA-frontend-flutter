import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/Posts_cubit/cubit/posts_cubit.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/screen/comments_page.dart';

class EditCommentPage extends StatelessWidget {
  const EditCommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool empty;
    return BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          TextEditingController comment_text = TextEditingController(
              text: PostsCubit.get(context).get_comment_by_id?.data.comment);
          return Scaffold(
            appBar: AppBar(
              //  leading: IconButton(
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => CommentsPage()));
              //       PostsCubit.get(context).getComments(id: id));
              //     },
              //     icon: Icon(Icons.arrow_back)),
              title: Text('Edit your comment'.tr()),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 240, 239, 239),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: comment_text,
                        onChanged: (value) {
                          if (value == null || value.isEmpty) {
                            empty = true;
                          } else
                            empty = false;
                        },
                        decoration: InputDecoration(
                            hintText: 'type what you want ...'.tr(),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                        //  expands: true,
                        minLines: 2,
                        maxLines: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      defaultButton(
                        onTap: () {
                          //  Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => CommentsPage()));
              //       PostsCubit.get(context).getComments(id: id));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentsPage(
                                    id: CachHelper.getData(key: "post_id")),
                              ));
                        },
                        text: 'Cancel'.tr(),
                        color: Color.fromARGB(255, 240, 239, 239),
                        h: 50,
                        w: 100,
                        textColor: Colors.black54,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      defaultButton(
                        onTap: () {
                          PostsCubit.get(context).updateComment(
                              comment: comment_text.text,
                              id: PostsCubit.get(context)
                                  .get_comment_by_id!
                                  .data
                                  .id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentsPage(
                                    id: CachHelper.getData(key: "post_id")),
                              ));
                        },
                        text: 'Update'.tr(),
                        h: 50,
                        w: 100,
                        color: ColorApp.color2,
                      ),
                      // (empty = true)
                      //     /? defaultButton(
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => CommentsPage(),
                      //               ));
                      //         },
                      //         text: 'Update',
                      //         h: 50,
                      //         w: 100,
                      //         color: Color.fromARGB(255, 240, 239, 239),
                      //         textColor: Colors.black54,
                      //       )
                      //     : defaultButton(
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => CommentsPage(),
                      //               ));
                      //         },
                      //         text: 'Update',
                      //         h: 50,
                      //         w: 100,
                      //         color: ColorApp.color2,
                      //       ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
