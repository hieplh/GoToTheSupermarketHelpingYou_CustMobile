import 'package:flutter/cupertino.dart';

class SearchBlocs extends InheritedWidget {
  SearchBlocs(
      {Key key,
        this.child})
      : super(key: key, child: child);

  final Widget child;

  static SearchBlocs of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SearchBlocs)
    as SearchBlocs);
  }

  @override
  bool updateShouldNotify(SearchBlocs oldWidget) {
    return true;
  }
}