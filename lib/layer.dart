part of smartcanvas;

class Layer extends Group {
  Stage _stage;
  LayerImpl _impl;
  String _type;

  Layer(this._type, Map<String, dynamic> config) : super(config) {
    _layer = this;
    _impl = createImpl(_type);
  }

  NodeImpl _createSvgImpl() {
    return  new SvgLayer(this);
  }

  NodeImpl _createCanvasImpl() {
    throw ExpNotImplemented;
  }

  Layer _clone() {
     return new Layer(_type, _attrs);
  }

  void suspend() {
    if (_impl != null) {
      _impl.suspend();
    }
  }

  void resume() {
    if (_impl != null) {
      _impl.resume();
    }
  }

  void add(Node child) {
    super.add(child);
    if (child.fill is SCPattern) {
      this.addPattern(child.fill);
    } else if (child.stroke is SCPattern) {
      this.addPattern(child.stroke);
    }
  }

  void insert(int index, Node node) {
    super.insert(index, node);
    if (node.fill is SCPattern) {
      this.addPattern(node.fill);
    } else if (node.stroke is SCPattern) {
      this.addPattern(node.stroke);
    }
  }

  void addPattern(SCPattern pattern) {
    if (pattern._impl == null) {
      pattern._impl = pattern.createImpl(type);
    }
    _impl.addPattern(pattern.impl as SvgPattern);
  }

  void _handleStageDragMove(e) {
    _transformMatrix.tx = _stage._transformMatrix.tx;
    _transformMatrix.ty = _stage._transformMatrix.ty;
    fire('translateChanged');
  }

  Layer get layer => this;

  String get type => _type;

  void set stage(Stage value) {
    _stage = value;
    _transformMatrix = _stage._transformMatrix;
    _stage
    .on('widthChanged', (oldValue, newValue) { width = newValue; })
    .on('heightChanged', (oldValue, newValue) { height = newValue; })
//    .on('scaleXChanged', (oldValue, newValue) { scaleX = newValue; })
//    .on('scaleYChanged', (oldValue, newValue) { scaleY = newValue; })
//    .on(DRAGMOVE, _handleStageDragMove);
    ;
    fire('stageSet');
  }
  Stage get stage => _stage;

  num get width => getAttribute(WIDTH);
  num get height => getAttribute(HEIGHT);
}