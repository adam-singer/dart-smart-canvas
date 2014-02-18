part of smartcanvas;

class Group extends Node {
  Set<Node> _children = new Set<Node>();
  Group([Map<String, dynamic> config = null]): super(config) {}

  _INodeImpl _createSvgImpl(_ICanvasImpl canvas) {
    return  new _SvgGroup(canvas, _attrs, _children);
  }

  _INodeImpl _createCanvasImpl(_ICanvasImpl canvas) {
    throw 'Not implemented';
  }

  void add(Node child) {
    _children.add(child);
    child._parent = this;
    if (this._impl != null ) {
      (_impl as _IGroupImpl).add(child._createImpl(this._canvas));
    }
  }

  void _addChildImpl(_INodeImpl impl, Node child, _ICanvasImpl canvas) {
    _INodeImpl chldImpl = child._createImpl(canvas);

  }
}