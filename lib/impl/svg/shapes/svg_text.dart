part of smartcanvas.svg;

class SvgText extends SvgNode{
  SvgText(Text shell): super(shell) {}

  SVG.SvgElement _createElement() {
    SVG.SvgElement text = new SVG.TextElement();
    text.text = getAttribute(TEXT);
    return text;
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll([X, Y]);
    return attrs;
  }

  Map<String, dynamic> _getStyles() {
    var styles = super._getStyles();
    styles.addAll({
      FONT_SIZE: (shell as Text).fontSize,
      FONT_FAMILY: (shell as Text).fontFamily
    });
    return styles;
  }

  bool _isStyle(String attr) {
    if (attr == FONT_SIZE ||
        attr == FONT_FAMILY) {
      return true;
    }
    return super._isStyle(attr);
  }

  String get _nodeName => SC_TEXT;
}