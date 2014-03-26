part of smartcanvas;

abstract class Node extends NodeBase {
  Stage _stage;
  Layer _layer;
  NodeImpl _impl;
  Node _parent;
  NodeImpl _reflection;

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
    if (container != null) {
      if (_impl != null) {
        _impl.remove();
      }

      if (_reflection != null) {
        _reflection.shell.remove();
      }

      container.children.remove(this);
      _parent = null;
    }
  }

  NodeImpl createImpl(type) {
    switch (type) {
      case svg:
        return _createSvgImpl();
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
        remove();
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
        remove();
        container.insert(index - 1, this);
      }
    }
  }

  void moveToTop() {
    Container container = _parent as Container;
    if (container != null) {
      int index = container.children.indexOf(this);
      if (index != container.children.length - 1) {
        this.remove();
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
    List<String> ss = events.split(SPACE);
    ss.forEach((event) {
      if (_eventListeners[event] == null) {
        _eventListeners[event] = new List<_EventListener>();
      }
      _eventListeners[event].add(new _EventListener(id, handler));

      if (_impl != null) {
        _impl.on(event, handler, id);
      }

      if (_reflection != null) {
        _reflection.on(event, handler, id);
      }
    });
    return this;
  }

  NodeImpl reflect() {
    return _createSvgImpl();
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
    Node clone = cm.newInstance(const Symbol(EMPTY), [cnfg]).reflectee;
    if (_impl != null) {
      clone._impl = clone.createImpl(_impl.type);
    }
    return clone;
  }

  bool get reflectable {
    return draggable || listening;
  }

  Layer get layer {
    Node parent = this._parent;
    while(parent._parent != null) {
      parent = parent._parent;
    }
    return (parent is Layer) ? parent : null;
  }

  void set id(String value) => setAttribute(ID, value);
  String get id => getAttribute(ID);

  void set x(num value) => setAttribute(X, value);
  num get x => getAttribute(X, 0);

  void set y(num value) => setAttribute(Y, value);
  num get y => getAttribute(Y, 0);

  void set width(num value) => setAttribute(WIDTH, value);
  num get width => getAttribute(WIDTH, 0);

  void set height(num value) => setAttribute(HEIGHT, value);
  num get height => getAttribute(HEIGHT, 0);

  void set stroke(String value) => setAttribute(STROKE, value);
  String get stroke => getAttribute(STROKE);

  void set strokeWidth(num value) => setAttribute(STROKE_WIDTH, value);
  num get strokeWidth => getAttribute(STROKE_WIDTH);

  void set strokeOpacity(num value) => setAttribute(STROKE_OPACITY, value);
  num get strokeOpacity => getAttribute(STROKE_OPACITY);

  void set fill(String value) => setAttribute(FILL, value);
  String get fill => getAttribute(FILL);

  void set opacity(int value) => setAttribute(OPACITY, value);
  int get opacity => getAttribute(OPACITY, 1);

  void set draggalbe(bool value) => setAttribute(DRAGGABLE, value);
  bool get draggable => getAttribute(DRAGGABLE, false);

  void set isListening(bool value) => setAttribute(LISTENING, value);
  bool get isListening => getAttribute(LISTENING, false);
}