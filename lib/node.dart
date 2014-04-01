part of smartcanvas;

abstract class Node extends NodeBase {
  Layer _layer;
  NodeImpl _impl;
  Container<Node> _parent;
  _I_Reflection _reflection;

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
    if (_parent != null) {
      if (_impl != null) {
        _impl.remove();
      }

      if (_reflection != null) {
        (_reflection as Node).remove();
      }

      _parent.children.remove(this);
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
      _parent.removeChild(this);
    }
    parent.add(this);
  }

  void moveUp() {
    int index;
    Container container = _parent;
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
    Container container = _parent;
    if (container != null) {
      index = container.children.indexOf(this);
      if (index > 0) {
        remove();
        container.insert(index - 1, this);
      }
    }
  }

  void moveToTop() {
    Container container = _parent;
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
    Container container = _parent;
    if (container != null) {
      index = container.children.indexOf(this);
      if (index > 0) {
        this.remove();
        container.insert(0, this);
      }
    }
  }

  NodeBase on(String events, Function handler, [String id]) {
    List<String> ss = events.split(SPACE);
    ss.forEach((event) {
      if (_eventListeners[event] == null) {
        _eventListeners[event] = new EventHandlers();
      }
      _eventListeners[event].add(new EventHandler(id, handler));

      if (_impl != null) {
        _impl.on(event, handler, id);
      }

      if (_reflection != null) {
        (_reflection as Node).on(event, handler, id);
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
    Node clone = cm.newInstance(const Symbol(EMPTY), [cnfg]).reflectee;
    if (_impl != null) {
      clone._impl = clone.createImpl(_impl.type);
    }
    return clone;
  }

  BBox getBBox() {
    return new BBox();
  }

  Position getAbsolutePosition() {
    return new Position();
  }

  /**
   * Show the node
   */
  void show() {
    visible = true;
  }

  /**
   * Hide the node
   */
  void hide() {
    visible = false;
  }

  /**
   * Get parent of this node
   */
  Container<Node> get parent => _parent;

  /**
   * Where or not the node if reflectable
   *
   * A node is reflectable if the node was draggable or listening
   */
  bool get reflectable {
    return draggable || listening;
  }

  /**
   * Get the layer of the node
   */
  Layer get layer {
    Node parent = this._parent as Node;
    while(parent != null && parent._parent != null) {
      parent = parent._parent as Node;
    }
    return (parent is Layer) ? parent : null;
  }

  /**
   * Get the stage
   */
  Stage get stage {
    return layer == null ? null : layer.stage;
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

  void set fillOpacity(num value) => setAttribute(FILL_OPACITY, value);
  num get fillOpacity => getAttribute(FILL_OPACITY);

  void set opacity(num value) => setAttribute(OPACITY, value);
  num get opacity => getAttribute(OPACITY, 1);

  void set draggalbe(bool value) => setAttribute(DRAGGABLE, value);
  bool get draggable => getAttribute(DRAGGABLE, false);

  void set listening(bool value) => setAttribute(LISTENING, value);
  bool get listening => getAttribute(LISTENING, false);

  void set visible(bool value) {
    if (!value) {
      setAttribute(DISPLAY, 'none');
    } else {
      removeAttribute(DISPLAY);
    }
  }
  bool get visible => !hasAttribute(DISPLAY);

  bool get isDragging {
    if (_impl != null) {
      return _impl.isDragging;
    }
    return false;
  }

  num get absolutePosition {
    if (_impl != null) {
      return _impl.absolutePosition;
    } else {
      return 0;
    }
  }
}