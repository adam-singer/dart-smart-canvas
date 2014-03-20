part of smartcanvas.svg;

class SvgPath extends SvgNode {
  SvgPath(Path shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.PathElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll(['d']);
    return attrs;
  }
}