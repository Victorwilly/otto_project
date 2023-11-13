import '../shared/models/models.dart';

class RouteComposer {
  static List<RouteOption> compose(String base, List<RouteOption> children) {
    final List<RouteOption> result = children.map((RouteOption c) {
      c.path = c.path!.isEmpty ? base : '$base/${c.path}';
      // ensures that page states are not kept in memory when we navigate away
      c.persist = false;

      return c;
    }).toList();

    return result;
  }
}
