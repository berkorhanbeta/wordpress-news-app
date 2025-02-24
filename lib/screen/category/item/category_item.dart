import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress/data/model/posts/post_model.dart';

class CategoryItem extends StatelessWidget {

  PostModel pm;
  CategoryItem({super.key, required this.pm});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 350,
      child: Card(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Image.network('${pm.image}', fit: BoxFit.fill)),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0x9D676767)
                ),
                alignment: Alignment.center,
                child: Text('${pm.title}', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white
                )),
              ),
            )
          ],
        )
      )
    );
  }


}