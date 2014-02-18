part of smartcanvas;

int _guid = 0;
class _EventListener {
  String id;
  Function handler;

  _EventListener(this.id, this.handler);
}

class NodeBase {
  int _uid;
  Map<String, dynamic> _attrs = {};

  Map<String, List<_EventListener>> _eventListeners = {};

  NodeBase() {
    _uid = ++_guid;
  }

  void _setAttributeFromConfig(String attr, Map<String, dynamic> config, [dynamic defaultVal = null]) {
    if (config.containsKey(attr)) {
      _setAttribute(attr, config[attr]);
    } else if (defaultVal != null) {
      _setAttribute(attr, defaultVal);
    }
  }

  void _setAttribute(String attr, dynamic value) {
    var oldValue = _attrs[attr];
    _attrs[attr] = value;
    fire(attr + 'Changed', oldValue, value);
  }

  dynamic _getAttribute(String attr) {
    return _attrs[attr];
  }

  String _getAttributeString(String attr) {
    var value = _getAttribute(attr);
    return '$value';
  }

  void on(String event, Function handler, String id) {
    List<String> ss = event.split(' ');
    for (int i = 0; i < ss.length; i++) {
      String event = ss[i];
      if (_eventListeners[event] != null) {
        _eventListeners[event] = new List<_EventListener>();
      }
      _eventListeners[event].add(new _EventListener(id, handler));
    }
  }

  void off(String event, String id) {
    List<_EventListener> listeners = _eventListeners[event];
    if (listeners != null) {
      var i = 0;
      while (i < listeners.length) {
        _EventListener listener = listeners[i];
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
  }

  void fire(String event, [dynamic arg0, arg1, arg2, arg3, arg4, arg5]) {
    var listeners = _eventListeners[event];
    if (listeners != null) {
      for (var i = 0; i < listeners.length; i++) {
        if (arg5 != null) {
          listeners[i].handler(arg0, arg1, arg2, arg3, arg4, arg5);
        } else if (arg4 != null) {
          listeners[i].handler(arg0, arg1, arg2, arg3, arg4);
        } else if (arg3 != null) {
          listeners[i].handler(arg0, arg1, arg2, arg3);
        } else if (arg2 != null) {
          listeners[i].handler(arg0, arg1, arg2);
        } else if (arg1 != null) {
          listeners[i].handler(arg0, arg1);
        } else if (arg0 != null) {
          listeners[i].handler(arg0);
        } else {
          listeners[i].handler();
        }
      }
    }
  }
}