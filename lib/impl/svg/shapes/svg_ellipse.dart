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

  dynamic getAttribute(String attr) {
    switch (attr) {
      case 'cx':
        return super.getAttribute('x');
      case 'cy':
        return super.getAttribute('y');
      default:
        return super.getAttribute(attr);
    }
  }
}