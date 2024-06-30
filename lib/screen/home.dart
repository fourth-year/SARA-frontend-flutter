import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/cubits/Posts_cubit/cubit/posts_cubit.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    PostsCubit.get(context).getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {},
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
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 10),
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
                                  PostsCubit.get(context)
                                      .get_allPosts!
                                      .data[index]
                                      .text,
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
                                    Icon(
                                      Icons.favorite_outline_rounded,
                                      size: 22,
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        _displayBottomSheet(context);
                                      },
                                      child: Icon(
                                        Icons.mode_comment_outlined,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 5),
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

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      builder: (context) {
        return SizedBox();
      },
      isScrollControlled: true,
    );
  }
}


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