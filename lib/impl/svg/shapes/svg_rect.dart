part of smartcanvas.svg;

class SvgRect extends SvgNode {
  SvgRect(Rect shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.RectElement();
  }

  Set<String> _getElementAttributeNames() {
      var attrs = super._getElementAttributeNames();
      attrs.addAll(['x', 'y', 'width', 'height']);
      return attrs;
    }
}