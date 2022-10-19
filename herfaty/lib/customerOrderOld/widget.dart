import 'package:flutter/material.dart';

typedef NavigateWidgetBuilder = Widget Function();

mixin NavigateMixin on Widget {
  NavigateWidgetBuilder? get navigationBuilder;

  Future<T?> navigate<T>(BuildContext context) {
    if (navigationBuilder == null) {
      return Future.value();
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navigationBuilder!(),
        ),
      );
    }
  }
}

const kNavigationCardRadius = 8.0;

class NavigationCard extends StatelessWidget with NavigateMixin {
  const NavigationCard({
    Key? key,
    this.margin,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(kNavigationCardRadius)),
    this.navigationBuilder,
    required this.child,
  }) : super(key: key);

  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Widget child;
  final NavigateWidgetBuilder? navigationBuilder;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: margin,
      shape: borderRadius != null
          ? RoundedRectangleBorder(borderRadius: borderRadius!)
          : null,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => navigate(context),
        child: child,
      ),
    );
  }
}

class TitleAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const TitleAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: TextStyle(color: Color(0xff51908E), fontFamily: "Tajawal")),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Color(0xff51908E)),
      /*leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),*/
    );
  }
}
