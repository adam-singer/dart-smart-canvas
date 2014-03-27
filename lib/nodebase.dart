part of smartcanvas;

int _guid = 0;

/**
 *
 */
class NodeBase {
  int _uid;
  Map<String, dynamic> _attrs = {};

  Map<String, EventHandlers> _eventListeners = {};

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

  NodeBase on(String events, Function handler, [String id]) {
    List<String> ss = events.split(' ');
    ss.forEach((event) {
      if (_eventListeners[event] == null) {
        _eventListeners[event] = new EventHandlers();
      }
      _eventListeners[event].add(new EventHandler(id, handler));
    });
    return this;
  }

  NodeBase off(String event, [String id]) {
    EventHandlers listeners = _eventListeners[event];
    if (listeners != null) {
      var i = 0;
      while (i < listeners.length) {
        EventHandler listener = listeners[i];
        if (listener.id == id) {
          listeners.removeAt(i);
        } else {
          i++;
        }
      }

      if (listeners.isEmpty) {
        _eventListeners.remove(event);
      }
    }
    return this;
  }

  void fire(String event, [dynamic arg0, arg1, arg2, arg3, arg4, arg5]) {
    EventHandlers listeners = _eventListeners[event];
    if (listeners != null) {
      listeners(arg0, arg1, arg2, arg3, arg4, arg5);
    }
  }

  bool hasListener(String event) {
    return _eventListeners[event] != null;
  }

  Map<String, dynamic> get attrs => _attrs;
  Map<String, EventHandlers> get eventListeners => _eventListeners;
}