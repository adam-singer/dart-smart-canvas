part of smartcanvas;

int _guid = 0;

/**
 *
 */
class NodeBase extends EventBus {
  int _uid;
  Map<String, dynamic> _attrs = {};

  NodeBase() {
    _uid = ++_guid;
  }

  void _setAttributeFromConfig(String attr, Map<String, dynamic> config, [dynamic defaultVal = null]) {
    if (config.containsKey(attr)) {
      setAttribute(attr, config[attr]);
    } else if (defaultVal != null) {
      setAttribute(attr, defaultVal);
    }
  }

  void setAttribute(String attr, dynamic value) {
    var oldValue = _attrs[attr];
    _attrs[attr] = value;
    if (oldValue != value) {
      var event = attr + CHANGED;
      if (hasListener(event)) {
        fire(event, oldValue, value);
      } else{
        fire(ANY_CHANGED, attr, oldValue, value);
      }
    }
  }

  dynamic getAttribute(String attr, [dynamic defaultValue = null]) {
    dynamic rt = _attrs[attr];
    return rt == null ? defaultValue : rt;
  }

  void removeAttribute(String attr) {
    _attrs.remove(attr);
  }

  String getAttributeString(String attr) {
    var value = getAttribute(attr);
    return '$value';
  }

  bool hasAttribute(String attr){
    return _attrs[attr] != null;
  }

  Map<String, dynamic> get attrs => _attrs;
}