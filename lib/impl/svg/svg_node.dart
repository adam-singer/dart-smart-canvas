part of smartcanvas;

abstract class _SvgNode extends _INodeImpl {
  _ICanvasImpl _canvas;
  SVG.SvgElement _element;

  _SvgNode(this._canvas, Map<String, dynamic> attrs) : super(attrs) {
    _element = _createElement();
    _setElementAttributes();
//    _setStyles();
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
}