part of smartcanvas;

class Group extends Node implements Container<Node> {
  List<Node> _children = new List<Node>();
  Group([Map<String, dynamic> config = null]): super(config) {}

  NodeImpl _createSvgImpl() {
    return  new SvgGroup(this);
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
      if (_impl != null ) {
        (_impl as Container).add(child.createImpl(_impl.type));
      }
    }
  }

  void removeChildAt(int index) {
    Node child = _children[index];
    child.remove();
  }

  void removeChild(Node node) {
    node._parent = null;
    _children.remove(node);
  }

  void insert(int index, Node node) {
    _children.insert(index, node);
    if (_impl != null) {
      (_impl as Container).insert(index, node);
    }
  }

  List<Node> get children => _children;

  void _addChildImpl(NodeImpl impl, Node child, CanvasImpl canvas) {
    NodeImpl chldImpl = child.createImpl(canvas);
  }
}