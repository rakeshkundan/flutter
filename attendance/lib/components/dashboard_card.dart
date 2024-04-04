import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onClick;
  const DashboardCard({
    super.key,
    this.icon = Icons.rectangle,
    this.title = "This Is Title",
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: width * .43,
        child: Material(
          elevation: 7,
          borderRadius: BorderRadius.circular(.025 * width),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: .06 * width, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(40),
                  elevation: 7,
                  child: CircleAvatar(
                    radius: .08 * width,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      icon,
                      size: .1 * width,
                      color: kInactiveTextColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: .05 * width,
                    fontWeight: FontWeight.w600,
                    color: kInactiveTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
