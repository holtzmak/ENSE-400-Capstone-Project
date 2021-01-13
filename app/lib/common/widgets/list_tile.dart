import 'package:app/common/style/style.dart';
import 'package:app/navigations/nav_bar/navigation.dart';
import 'package:flutter/material.dart';

class TemplateListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle textStyle;

  TemplateListTile(
      {@required this.icon, @required this.text, @required this.textStyle}) {
    assert(icon != null);
    assert(text != null);
    assert(textStyle != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BottomBorderStyle,
        ),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement a better way of routing
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationBarController()),
          );
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(icon),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
