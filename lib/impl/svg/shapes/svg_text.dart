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
    attrs.addAll(['x', 'y']);
    return attrs;
  }

  Map<String, dynamic> _getStyles() {
    var styles = super._getStyles();
    styles.addAll({
      'font-size': shell.fontSize,
      'font-family': shell.fontFamily
    });
    return styles;
  }
}