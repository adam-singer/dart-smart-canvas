part of smartcanvas;

abstract class _SvgNode extends _INodeImpl {
  _ICanvasImpl _canvas;
  SVG.SvgElement _element;

  bool _dragging;
  num _dragOffsetX;
  num _dragOffsetY;

  _SvgNode(this._canvas, Map<String, dynamic> attrs) : super(attrs) {
    _element = _createElement();
    _setElementAttributes();
//    _setStyles();

    if (_getAttribute('draggable') == true) {
      _element.onMouseDown.listen(_onMouseDown);
    }
  }

  String get type => 'svg';

  SVG.SvgElement get element => _element;

  SVG.SvgElement _createElement();

  Set<String> _getElementAttributeNames() {
    return new Set<String>.from(['id', 'name', 'x', 'y', 'width', 'height', 'stroke',
            'stroke-width', 'stroke-opacity', 'fill', 'opacity']);
  }

  void _setElementAttributes() {
    var attrs = _getElementAttributeNames();
    attrs.forEach(_setElementAttribute);
  }

  void _setElementAttribute(String attr) {
    var value = _getAttribute(attr);
    if (value != null) {
      if (!(value is String) || !value.isEmpty) {
        _element.attributes[attr] = '$value';
      }
    }
  }

//  void _setStyles() {
//    String style = 'stroke:' + this.stroke
//        + ';stroke-width:' + '$this.strokeWidth'
//        + ';stroke-opacity:' + '$this.strokeOpacity'
//        + ';fill:' + this.fill;
//    _element.setAttribute('style', style);
//  }

  void _onMouseDown(DOM.MouseEvent e) {
    e.preventDefault();
    this._dragging = true;

    var pointerPosition = this._canvas.getPointerPosition();
    this._dragOffsetX = pointerPosition.x - (this._element as SVG.GraphicsElement).getCtm().e;
    this._dragOffsetY = pointerPosition.y - (this._element as SVG.GraphicsElement).getCtm().f;

    this._canvas._element.onMouseMove.listen(dragStart).resume();
    this._canvas._element.onMouseUp.listen(dragEnd).resume();
  }

  void dragStart(DOM.MouseEvent e) {
    e.preventDefault();
    if (this._dragging) {
      var pointerPosition = this._canvas.getPointerPosition();
      num x = pointerPosition.x - this._dragOffsetX;
      num y = pointerPosition.y - this._dragOffsetY;
      this._element.setAttribute('transform', 'translate($x, $y)');
    }
  }

  void dragEnd(DOM.MouseEvent e) {
    e.preventDefault();
    this._dragging = false;
    this._canvas._element.onMouseDown.listen(dragStart).cancel();
    this._canvas._element.onMouseUp.listen(dragEnd).cancel();
  }
}