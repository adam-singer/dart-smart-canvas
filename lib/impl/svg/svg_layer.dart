part of smartcanvas.svg;

class SvgLayer extends SvgNode implements LayerImpl {
  List<SvgNode> _children = new List<SvgNode>();

  SvgLayer(shell): super(shell) {
    shell
      .on('widthChanged', _onWidthChanged)
      .on('heightChanged', _onHeightChanged)
      .on('opacityChanged', _onOpacityChanged)
      .on('stageSet', _onStageSet);
  }

  DOM.Element _createElement() {
    return new SVG.SvgSvgElement();
  }

  Set<String> _getElementAttributeNames() {
    return new Set<String>.from([ID, CLASS, WIDTH, HEIGHT, VIEWBOX]);
  }

  void _setElementAttribute(String attr) {
    if (attr == 'viewBox') {
      _setViewBox();
      _element.setAttribute('preserveAspectRatio', 'none');
    } else {
      super._setElementAttribute(attr);
    }
  }

  void _setViewBox() {
    (_element as SVG.SvgSvgElement).viewBox.baseVal
    ..x = getAttribute(X, 0)
    ..y = getAttribute(Y, 0)
    ..width = getAttribute(WIDTH, 0) / getAttribute(SCALE_X, 1)
    ..height = getAttribute(HEIGHT, 0) / getAttribute(SCALE_Y, 1);
  }

  void _setElementStyles() {
    super._setElementStyles();
    _element.style
    ..position = ABSOLUTE
    ..top = ZERO
    ..left = ZERO
    ..margin = ZERO
    ..padding = ZERO;
  }

  void add(SvgNode child) {
    _children.add(child);
    child.parent = this;
    this._element.append(child._element);
  }

  void removeChild(SvgNode node) {
    node.parent = null;
    node.remove();
  }

  void removeChildren() {
    _children.forEach((child) => child.remove());
  }

  void insert(int index, SvgNode node) {
    node.parent = this;
    _children.insert(index, node);
    this._element.nodes.insert(index, node._element);
  }

  void resume() {}
  void suspend() {}

  void _onStageSet() {
    shell.stage
      .on('scaleXChanged', _onScaleXChanged)
      .on('scaleYChanged', _onScaleYChanged)
      .on('translateXChanged', _onTranslateXChanged)
      .on('translateYChanged', _onTranslateYChanged);
  }

  void _onWidthChanged(oldValue, newValue) {
    _element.setAttribute(WIDTH, '$newValue');
    (_element as SVG.SvgSvgElement).viewBox.baseVal
    ..width = newValue / getAttribute(SCALE_Y, 1);
  }

  void _onHeightChanged(oldValue, newValue) {
    _element.setAttribute(HEIGHT, '$newValue');
    (_element as SVG.SvgSvgElement).viewBox.baseVal
    ..height = newValue / getAttribute(SCALE_Y, 1);
  }

  void _onOpacityChanged(num oldValue, num newValue) {
    _element.style.opacity = '$newValue';
  }

  void _onScaleXChanged(num oldValue, num newValue) {
    if (newValue == 0) {
      newValue = 0.0000001;
    }
    (_element as SVG.SvgSvgElement).viewBox.baseVal
    ..width = getAttribute(WIDTH, 0) / newValue;
  }

  void _onScaleYChanged(num oldValue, num newValue) {
    if (newValue == 0) {
      newValue = 0.0000001;
    }
    (_element as SVG.SvgSvgElement).viewBox.baseVal
    ..height = getAttribute(HEIGHT, 0) / newValue;
  }

  void _onTranslateXChanged(oldValue, newValue) {
    _elMatrix
    ..a = transformMatrix.sx
    ..b = transformMatrix.rx
    ..c = transformMatrix.ry
    ..d = transformMatrix.sy;

    SVG.Matrix m = _elMatrix.translate(transformMatrix.tx, transformMatrix.ty);
    (_element as SVG.SvgSvgElement).viewBox.baseVal.x = -m.e;
    print('--${(_element as SVG.SvgSvgElement).viewBox.baseVal.x}');
  }

  void _onTranslateYChanged(oldValue, newValue) {
    _elMatrix
    ..a = transformMatrix.sx
    ..b = transformMatrix.rx
    ..c = transformMatrix.ry
    ..d = transformMatrix.sy;

    SVG.Matrix m = _elMatrix.translate(transformMatrix.tx, transformMatrix.ty);
    (_element as SVG.SvgSvgElement).viewBox.baseVal.y = -m.f;
  }

  List<SvgNode> get children => _children;

  String get _nodeName => SC_LAYER;

  num get absolutePosition => 0;
}