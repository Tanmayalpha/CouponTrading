import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataFound extends StatelessWidget {
  final String slug;

  const NoDataFound({Key? key, required this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset('assets/images/no_data.svg',
              height: MediaQuery.of(context).size.height * .2),
          SizedBox(height: 5),
          Center(
              child: Text(
            "No $slug Found",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}
