part of smartcanvas.svg;

class SvgGroup extends SvgNode implements Container<SvgNode> {
  List<SvgNode> _children = new List<SvgNode>();
  SvgGroup(Group shell)
    : super(shell) {
    for (int i = 0; i < shell.children.length; i++) {
      SvgNode node = shell.children[i].createImpl(shell.canvas.type);
      this.add(node);
    }
  }

  SVG.SvgElement _createElement() {
    return new SVG.GElement();
  }

  void add(SvgNode child) {
    _children.add(child);
    child.parent = this;
    this._element.append(child._element);
  }

  void removeChildAt(int index) {
    SvgNode node = _children[index];
    node.remove();
  }

  void removeChild(SvgNode node) {
    node.parent = null;
    node.remove();
  }

  void removeChildren() {
    _children.forEach((child) => child.remove());
  }

  void insert(int index, SvgNode node) {
    node.parent = null;
  }

  List<SvgNode> get children => _children;
}