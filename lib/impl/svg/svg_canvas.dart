part of smartcanvas.svg;

class SvgCanvas extends CanvasImpl{
  List<SvgNode> _children = new List<SvgNode>();
  Position _pointerPosition;

  SvgCanvas(container, Canvas shell)
      : super(container, shell) {
  }

  String get type => svg;

  DOM.Element createElement() {
    var svg = new SVG.SvgSvgElement();
    svg.attributes = {
      'width': getAttributeString('width'),
      'height': getAttributeString('height')
    };
    return svg;
  }

  void appendChild(SvgNode node) {
    node.parent = this;
    this.element.nodes.add(node.element);
  }

  void remove() {
    element.remove();
    parent = null;
  }

  void setPointerPosition(e) {
    SVG.SvgSvgElement canvas = this.element;
    num x = (e.client.x - canvas.currentTranslate.x) / canvas.currentScale;
    num y = (e.client.y - canvas.currentTranslate.y) / canvas.currentScale;
    this._pointerPosition = new Position(x, y);
  }

  Position getPointerPosition() {
    return this._pointerPosition;
  }

  void add(SvgNode child) {
    _children.add(child);
    child.parent = this;
    this.element.append(child._element);
  }

  void removeChildAt(int index) {
    SvgNode node = _children[index];
    removeChild(node);
  }

  void removeChild(SvgNode node) {
    _children.remove(node);
    node.element.remove();
    node.parent = null;
    // TODO: remove event listeners
  }

  void removeChildren() {
    _children.forEach((child) {
      removeChild(child);
    });
  }

  void insert(int index, SvgNode node) {
    node.parent = this;
    _children.insert(index, node);
    this.element.nodes.insert(index, node._element);
  }

  List<SvgNode> get children => _children;
}