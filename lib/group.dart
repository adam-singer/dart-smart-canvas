part of smartcanvas;

class Group extends Node implements Container<Node> {
  List<Node> _children = new List<Node>();

  Group([Map<String, dynamic> config = null]): super(config) {}

  NodeImpl _createSvgImpl() {
    SvgGroup impl = new SvgGroup(this);
    _children.forEach((node) {
      node._impl = node.createImpl(svg);
      impl.add(node._impl);
    });
    return impl;
  }

  NodeImpl _createCanvasImpl() {
    throw 'Not implemented';
  }

  void add(Node child) {
    if (child._parent != null) {
      child.moveTo(this);
    } else {
      _children.add(child);
      child._parent = this;
//      child.stage = this.stage;
      child._layer = this._layer;
      if (_impl != null ) {
        if (child._impl == null || child._impl.type != _impl.type) {
          child._impl = child.createImpl(_impl.type);
        }
        (_impl as Container).add(child._impl);
      }
    }
  }

  void removeChild(Node node) {
    node._parent = null;
    _children.remove(node);
  }

  void insert(int index, Node node) {
    _children.insert(index, node);
    if (_impl != null) {
      if (node._impl == null || node._impl.type != _impl.type) {
        node._impl = node.createImpl(_impl.type);
      }
      (_impl as Container).insert(index, node._impl);
    }
  }

  List<Node> get children => _children;

  void _addChildImpl(NodeImpl impl, Node child, Layer layer) {
    NodeImpl chldImpl = child.createImpl(layer.type);
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

    _children.forEach((child) {
      (clone as Container).add(child.clone());
    });
    return clone;
  }

//  void set stage(Stage stage) {
//    super.stage = stage;
//    _children.forEach((node) {
//      node.stage = stage;
//    });
//  }
}