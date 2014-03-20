part of smartcanvas.svg;

class SvgText extends SvgNode{
  SvgText(Text shell): super(shell) {}

  SVG.SvgElement _createElement() {
    SVG.SvgElement text = new SVG.TextElement();
    text.text = getAttribute('text');
    return text;
  }

  Set<String> _getElementAttributeNames() {
      var attrs = super._getElementAttributeNames();
      attrs.addAll(['font-size']);
      return attrs;
    }
}