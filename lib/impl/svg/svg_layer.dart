part of smartcanvas.svg;

class SvgLayer extends SvgGroup implements LayerImpl {
  SvgLayer(shell): super(shell) {
    shell
      .on('widthChanged', _onWidthChanged)
      .on('heightChanged', _onHeightChanged)
      .on('opacityChanged', _onOpacityChanged)
      .on('scaleChanged', _onScaleChanged);
  }

  DOM.Element _createElement() {
    return new SVG.SvgSvgElement();
  }

  Set<String> _getElementAttributeNames() {
    return new Set<String>.from(['id', 'class']);
  }

  void _setElementAttributes() {
    super._setElementAttributes();
    _setElementStyle({
      'position': 'absolute',
      'top': 0,
      'left': 0,
      'margin': 0,
      'padding': 0,
      'opacity': shell.opacity,
      'width': getAttribute("width"),
      'height': getAttribute("height"),
    });
  }

  void resume() {}
  void suspend() {}

  void _onWidthChanged(oldValue, newValue) {
    _element.style.width = '$newValue';
  }

  void _onHeightChanged(oldValue, newValue) {
    _element.style.height = '$newValue';
  }

  void _onOpacityChanged(int oldValue, int newValue) {
    _element.style.opacity = '$newValue';
  }

  void _onScaleChanged(int oldValue, int newValue) {

  }
}