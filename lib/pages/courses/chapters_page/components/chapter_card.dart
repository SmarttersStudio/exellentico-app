import 'package:ecommerceapp/data_models/chapter_data.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 7:45 AM
///

class ChapterCard extends StatelessWidget {
  final ChapterDatum data;
  ChapterCard({required this.data});
  @override
  Widget build(BuildContext context) {
    return data == null
        ? Container()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              Ink.image(
                image: NetworkImage(
                  'https://img.freepik.com/free-vector/business-people-looking-book_52683-28612.jpg?size=626&ext=jpg',
                ),
                height: 120,
                width: 180,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      data.name ?? '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      data.description ?? '',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              )
            ],
          );
  }
}
