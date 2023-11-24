import 'package:flutter/material.dart';

import 'menu_items.dart';

class SharedAppBar extends StatefulWidget {
  String?Titel;
   SharedAppBar({
    super.key,
    this.Titel='',
  });

  @override
  State<SharedAppBar> createState() => _SharedAppBarState();
}

class _SharedAppBarState extends State<SharedAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

//             IconButton(onPressed:(){
// setState(() {
//
// });
//
//             } ,
//                 icon: Icon(
//                   Icons.menu,
//                   color: Color(0xFFFA7031),
//                   size: 40,
//                 ),
//             ),
            MenuItems(),
            Text(
              widget.Titel! ,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFA7031),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Color(0xFFFA7031),
                  size: 40,
                )),
          ],
        ),
      ),
    );
  }
}
