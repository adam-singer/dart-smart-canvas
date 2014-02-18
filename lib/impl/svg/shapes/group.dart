part of smartcanvas;

class _SvgGroup extends _SvgDraggableNode implements _IGroupImpl {
  Set<_SvgNode> _children = new Set<_SvgNode>();
  _SvgGroup(SvgCanvas canvas, Map<String, dynamic> attr, Set<Node> children)
    : super(canvas, attr) {
    for (int i = 0; i < children.length; i++) {
      _SvgNode node = children.elementAt(i)._createImpl(canvas);
      this.add(node);
    }
  }

  SVG.SvgElement _createElement() {
    return new SVG.GElement();
  }

  void add(_SvgNode child) {
    _children.add(child);
    child._parent = this;
    this._element.append(child._element);
  }
}