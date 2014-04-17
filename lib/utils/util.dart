part of smartcanvas;

String capitalize(String s) {
  if (s != null && s.length > 0) {
    if (s.length == 1) {
      return s[0].toUpperCase();
    }
    return s[0].toUpperCase() + s.substring(1);
  }
  return s;
}

dynamic getValue(Map map, key, [defaultValue = null]) {
  if (map == null) {
    return defaultValue;
  }

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
          rt[k] = merge(rt[k], map[k]);
        } else if (v is Iterable){
          int i = 0;
          List listLeft = rt[k];
          for (; i < v.length && i < rt[k].length; i++) {
            if (v[i] is Map) {
              listLeft[i] = merge(listLeft[i], v[i]);
            } else {
              listLeft[i] = v[i];
            }
          }

          for (; i < v.length; i++) {
            listLeft.add(v[i]);
          }

        } else {
          rt[k] = v;
        }
      } else {
        rt[k] = v;
      }
    });
  }

  if (map2 != null) {
    _merge(map2);
  }

  if (map3 != null) {
    _merge(map3);
  }
  if (map4 != null) {
    _merge(map4);
  }
  return rt;
}