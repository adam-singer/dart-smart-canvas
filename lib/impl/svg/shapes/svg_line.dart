part of smartcanvas.svg;

class SvgLine extends SvgNode {
  SvgLine(Line shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.LineElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll(['x1', 'y1', 'x2', 'y2']);
    return attrs;
  }
}