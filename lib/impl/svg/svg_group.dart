part of smartcanvas.svg;

class SvgGroup extends SvgNode implements Container<SvgNode> {
  List<SvgNode> _children = new List<SvgNode>();
  SvgGroup(Group shell)
    : super(shell) {
    shell.children.forEach((child) {
      SvgNode node = child.createImpl(shell.layer.type);
      this.add(node);
    });
  }

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

  List<SvgNode> get children => _children;

//  void set stage(Stage stage) {
////    super.stage = stage;
//    _children.forEach((nodeImpl) {
//      nodeImpl.stage = stage;
//    });
//  }
}