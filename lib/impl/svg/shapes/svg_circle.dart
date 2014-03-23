part of smartcanvas.svg;

class SvgCircle extends SvgNode{
  double r;

  SvgCircle(Circle shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.CircleElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll(['cx', 'cy', 'r']);
    return attrs;
  }

  dynamic getAttribute(String attr, [dynamic defaultValue = null]) {
    switch (attr) {
      case 'cx':
        return super.getAttribute('x', defaultValue);
      case 'cy':
        return super.getAttribute('y', defaultValue);
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
      case 'x':
        return 'cx';
      case 'y':
        return 'cy';
      default:
        return super._mapToElementAttr(attr);
    }
  }
}