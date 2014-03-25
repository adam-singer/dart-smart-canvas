part of smartcanvas.svg;

class SvgEllipse extends SvgNode{
  double rx;
  double ry;

  SvgEllipse(Ellipse shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.EllipseElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll(['cx', 'cy', 'rx', 'ry']);
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

  String get _nodeName => '__sc_ellipse';
}