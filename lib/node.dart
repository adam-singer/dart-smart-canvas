part of smartcanvas;

abstract class Node extends NodeBase {
  CanvasImpl _canvas = null;
  NodeImpl _impl = null;
  Node _parent = null;
  int _index = null;

  Node([Map<String, dynamic> config = null]): super() {
    if (config == null) {
      config = {};
    }
    populateConfig(config);
  }

  void populateConfig(Map<String, dynamic> config) {
    config.forEach(setAttribute);
    if (_attrs['fill'] == null) {
      _attrs['fill'] = 'transparent';
    }
  }

  void remove() {
    var container = _parent as Container;
    if (container) {
      if (_impl != null) {
        _impl.remove();
      }

      container.children.remove(this);
      _parent = null;
    }
  }

  NodeImpl createImpl(type) {
    switch (type) {
      case 'svg':
        _impl = _createSvgImpl();
        break;
      default:
        _impl = _createCanvasImpl();
    }

    return _impl;
  }

  NodeImpl _createSvgImpl();
  NodeImpl _createCanvasImpl();

  void moveTo(Container parent) {
    if (_parent != null) {
      (_parent as Container).removeChild(this);
    }
    parent.add(this);
  }

  void moveUp() {
    int index;
    Container container = _parent as Container;
    if (container != null) {
      index = container.children.indexOf(this);
      if (index != container.children.length - 1) {
        container.removeChild(this);
        container.insert(index + 1, this);
      }
    }
  }

  void moveDown() {
    int index;
    Container container = _parent as Container;
    if (container != null) {
      index = container.children.indexOf(this);
      if (index > 0) {
        container.removeChild(this);
        container.insert(index - 1, this);
      }
    }
  }

  void moveToTop() {
    int index;
    Container container = _parent as Container;
    if (container != null) {
      index = container.children.indexOf(this);
      if (index != container.children.length - 1) {
        container.removeChild(this);
        container.add(this);
      }
    }
  }

  void moveToBottom() {
    int index;
    Container container = _parent as Container;
    if (container != null) {
      index = container.children.indexOf(this);
      if (index > 0) {
        container.removeChild(this);
        container.insert(0, this);
      }
    }
  }

  void on(String events, Function handler, [String id]) {
    List<String> ss = events.split(' ');
    ss.forEach((event) {
      if (_eventListeners[event] == null) {
        _eventListeners[event] = new List<_EventListener>();
      }
      _eventListeners[event].add(new _EventListener(id, handler));

      if (_impl != null) {
        _impl.on(event, handler, id);
      }
    });
  }

  CanvasImpl get canvas => _canvas;

  void set id(String value) => setAttribute('id', value);
  String get id => getAttribute('id');

  void set x(num value) => setAttribute('x', value);
  num get x => getAttribute('x');

  void set y(num value) => setAttribute('y', value);
  num get y => getAttribute('y');

  void set stroke(String value) => setAttribute('stroke', value);
  String get stroke => getAttribute('stroke');

  void set strokeWidth(num value) => setAttribute('stroke-width', value);
  num get strokeWidth => getAttribute('strokeWidth');

  void set strokeOpacity(num value) => setAttribute('stroke-opacity', value);
  num get strokeOpacity => getAttribute('stroke-opacity');

  void set fill(String value) => setAttribute('fill', value);
  String get fill => getAttribute('fill');

  void set opacity(String value) => setAttribute('opacity', value);
  String get opacity => getAttribute('opacity');

  num get index => _index;
}