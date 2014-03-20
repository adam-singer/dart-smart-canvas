part of smartcanvas;

abstract class Node extends NodeBase {
  Stage _stage;
  Layer _layer;
  NodeImpl _impl;
  Node _parent;
  _ReflectionNode _reflection;

  Node([Map<String, dynamic> config = null]): super() {
    if (config == null) {
      config = {};
    }
    populateConfig(config);
  }

  void populateConfig(Map<String, dynamic> config) {
    _attrs.addAll(config);
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
      case svg:
        return _createSvgImpl();
        break;
      default:
        return _createCanvasImpl();
    }
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

  NodeBase on(String events, Function handler, [String id]) {
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
    return this;
  }

  Node clone([Map<String, dynamic> config]) {
    ClassMirror cm = reflectClass(this.runtimeType);
    Map<String, dynamic> cnfg;
    if(config != null) {
      cnfg = new Map<String, dynamic>.from(_attrs);
      cnfg.addAll(config);
    } else {
      cnfg = _attrs;
    }
    Node clone = cm.newInstance(const Symbol(''), [cnfg]).reflectee;
    if (_impl != null) {
      clone._impl = clone.createImpl(_impl.type);
    }
    return clone;
  }

  Layer get layer {
    Node parent = this._parent;
    while(parent._parent != null) {
      parent = parent._parent;
    }
    return (parent is Layer) ? parent : null;
  }

  void set id(String value) => setAttribute('id', value);
  String get id => getAttribute('id');

  void set x(num value) => setAttribute('x', value);
  num get x => getAttribute('x', 0);

  void set y(num value) => setAttribute('y', value);
  num get y => getAttribute('y', 0);

  void set width(num value) => setAttribute('width', value);
  num get width => getAttribute('width', 0);

  void set height(num value) => setAttribute('height', value);
  num get height => getAttribute('height', 0);

  void set stroke(String value) => setAttribute('stroke', value);
  String get stroke => getAttribute('stroke');

  void set strokeWidth(num value) => setAttribute('stroke-width', value);
  num get strokeWidth => getAttribute('stroke-width');

  void set strokeOpacity(num value) => setAttribute('stroke-opacity', value);
  num get strokeOpacity => getAttribute('stroke-opacity');

  void set fill(String value) => setAttribute('fill', value);
  String get fill => getAttribute('fill');

  void set opacity(int value) => setAttribute('opacity', value);
  int get opacity => getAttribute('opacity', 1);

  void set draggalbe(bool value) => setAttribute('draggable', value);
  bool get draggable => getAttribute('draggable', false);

  void set isListening(bool value) => setAttribute('listening', value);
  bool get isListening => getAttribute('listening', false);
}