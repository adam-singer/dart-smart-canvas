part of smartcanvas;

String capitalize(String s) {
  return s[0].toUpperCase() + s.substring(1);
}

dynamic getValue(Map map, key, [defaultValue = null]) {
  var rt = map[key];
  return rt == null ? defaultValue : rt;
}

void setValue(Map map, key, value) {
  map[key] = value;
}

Map merge(Map map1, Map map2, [Map map3 = null, Map map4 = null]) {
  Map rt = new Map.from(map1);

  void _merge(Map map) {
    map.forEach((k, v) {
      if (rt.containsKey(k)) {
        if (v is Map) {
          rt [k] = merge(rt[k], map[k]);
        } else {
          rt[k] = v;
        }
      } else {
        rt[k] = v;
      }
    });
  }

  _merge(map2);
  if (map3 != null) {
    _merge(map3);
  }
  if (map4 != null) {
    _merge(map4);
  }
  return rt;
}