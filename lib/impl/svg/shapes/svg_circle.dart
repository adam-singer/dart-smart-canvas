part of smartcanvas.svg;

class SvgCircle extends SvgNode{
  double r;

  SvgCircle(Circle shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.CircleElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll([CX, CY, R]);
    return attrs;
  }

  dynamic getAttribute(String attr, [dynamic defaultValue = null]) {
    switch (attr) {
      case CX:
        return super.getAttribute(X, defaultValue);
      case CY:
        return super.getAttribute(Y, defaultValue);
      default:
        return super.getAttribute(attr, defaultValue);
    }
  }

//  void _internalApplyOffset() {
//    setAttribute('x', getAttribute('x', 0) - getAttribute('offsetX', 0));
//    setAttribute('y', getAttribute('y', 0) - getAttribute('offsetY', 0));
//  }

  String _mapToElementAttr(String attr) {
    switch (attr) {
      case X:
        return CX;
      case Y:
        return CY;
      default:
        return super._mapToElementAttr(attr);
    }
  }

  String get _nodeName => SC_CIRCLE;
}