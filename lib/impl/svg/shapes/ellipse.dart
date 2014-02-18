part of smartcanvas;

class SvgEllipse extends SvgNode{
  double rx;
  double ry;

  SvgEllipse(_ICanvasImpl canvas, Map<String, dynamic> attrs): super(canvas, attrs) {}

  SVG.SvgElement _createElement() {
    return new SVG.EllipseElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll(['cx', 'cy', 'rx', 'ry']);
    return attrs;
  }

  dynamic _getAttribute(String attr) {
    switch (attr) {
      case 'cx':
        return super._getAttribute('x');
      case 'cy':
        return super._getAttribute('y');
      default:
        return super._getAttribute(attr);
    }
  }
}