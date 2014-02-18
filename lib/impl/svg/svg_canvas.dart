part of smartcanvas;

class SvgCanvas extends _ICanvasImpl {

  SvgCanvas(containerId, Map<String, dynamic> attrs)
      : super(containerId, attrs) {
  }

  String get type => 'svg';

  _createElement() {
    var svg = new SVG.SvgSvgElement();
    svg.attributes = {
      'width': _getAttributeString('width'),
      'height': _getAttributeString('height')
    };
    return svg;
  }

  void appendChild(_SvgNode node) {
    this._element.nodes.add(node.element);
  }

  void _setPointerPosition(e) {
    SVG.SvgSvgElement canvas = this._element;
    num x = (e.client.x - canvas.currentTranslate.x) / canvas.currentScale;
    num y = (e.client.y - canvas.currentTranslate.y) / canvas.currentScale;
    this._pointerPositioin = new Position(x, y);
  }

  Position getPointerPosition() {
    return this._pointerPositioin;
  }
}