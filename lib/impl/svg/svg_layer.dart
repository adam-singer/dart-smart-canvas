part of smartcanvas.svg;

class SvgLayer extends SvgGroup implements LayerImpl {
  SvgLayer(shell): super(shell) {}

  DOM.Element _createElement() {
    return new SVG.GElement();
  }

  Set<String> _getElementAttributeNames() {
    return new Set<String>.from(['id', 'class']);
  }

  void resume() {}
  void suspend() {}
}