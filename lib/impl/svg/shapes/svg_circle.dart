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

  dynamic getAttribute(attr) {
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