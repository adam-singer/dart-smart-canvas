part of smartcanvas.svg;

class SvgGroup extends SvgNode implements Container<SvgNode> {
  List<SvgNode> _children = new List<SvgNode>();
  SvgGroup(Group shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.GElement();
  }

  void add(SvgNode child) {
    _children.add(child);
    child.parent = this;
//    child.stage = this.stage;
    this._element.append(child._element);
  }

  void removeChild(SvgNode node) {
    node.parent = null;
    node.remove();
  }

  void removeChildren() {
    _children.forEach((child) => child.remove());
  }

  void insert(int index, SvgNode node) {
    node.parent = this;
    _children.insert(index, node);
    this._element.nodes.insert(index, node._element);
  }

  void _setElementAttribute(String attr) {
    super._setElementAttribute(attr);
    if (attrs['x'] != null || attrs['y'] != null) {
      _element.setAttribute('transform', 'translate(${getAttribute('x', 0)}, ${getAttribute('y', 0)})');
    }
  }

  List<SvgNode> get children => _children;
}