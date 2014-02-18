part of smartcanvas;

class _SvgCircle extends _SvgNode{
  double r;

  _SvgCircle(SvgCanvas canvas, Map<String, dynamic> attrs): super(canvas, attrs) {}

  SVG.SvgElement _createElement() {
    return new SVG.CircleElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll(['cx', 'cy', 'r']);
    return attrs;
  }

  dynamic _getAttribute(attr) {
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