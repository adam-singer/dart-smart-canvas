part of smartcanvas.svg;

class SvgCanvas extends SvgNode implements CanvasImpl{
  DOM.Element _container;
  static int i = 0;
  List<SvgNode> _children = new List<SvgNode>();
//  SvgLayer _defaultLayer = new SvgLayer(new Layer({'id': 'default'}));
  Position _pointerPosition;

  SvgCanvas(this._container, Canvas shell)
      : super(shell) {
    if (this._container == null) {
      throw "container doesn't exit";
    }
    var div = new DOM.DivElement();
    div.id = 'layer' + i.toString();
    div.style.position = 'absolute';
    div.style.left = '0';
    div.style.top = '0';
    div.style.zIndex = (i++).toString();
    var root = div.createShadowRoot();
    root.nodes.add(this._element);
    _container.nodes.add(div);

    this._element.onMouseDown.listen(setPointerPosition);
    this._element.onMouseMove.listen(setPointerPosition);
    this._element.onMouseUp.listen(setPointerPosition);
    this._element.onMouseEnter.listen(setPointerPosition);
    this._element.onMouseLeave.listen(setPointerPosition);
  }

  String get type => svg;

  DOM.Element _createElement() {
    return new SVG.SvgSvgElement();
  }

  Set<String> _getElementAttributeNames() {
    return new Set<String>.from(['id', 'class', 'width', 'height']);
  }

  void remove() {
    element.remove();
    parent = null;
  }

//  void setPointerPosition(e) {
//    SVG.SvgSvgElement canvas = this.element;
//    num x = (e.client.x - canvas.currentTranslate.x) / canvas.currentScale;
//    num y = (e.client.y - canvas.currentTranslate.y) / canvas.currentScale;
//    this._pointerPosition = new Position(x, y);
//  }
//
//  Position getPointerPosition() {
//    return this._pointerPosition;
//  }

  void add(SvgNode child) {
    _children.add(child);
    child.parent = this;
    this.element.append(child._element);
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