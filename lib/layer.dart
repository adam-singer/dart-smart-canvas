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

  void _handleStageDragMove(e) {
    _transformMatrix.tx = _stage._transformMatrix.tx;
    _transformMatrix.ty = _stage._transformMatrix.ty;
    fire('translateChanged');
  }

  Layer get layer => this;

  String get type => _type;

  void set stage(Stage value) {
    _stage = value;
//    _transformMatrix = _stage._transformMatrix;
    _stage
    .on('widthChanged', (oldValue, newValue) { width = newValue; })
    .on('heightChanged', (oldValue, newValue) { height = newValue; })
    .on('scaleXChanged', (oldValue, newValue) { scaleX = newValue; })
    .on('scaleYChanged', (oldValue, newValue) { scaleY = newValue; })
//    .on(DRAGMOVE, _handleStageDragMove);
    ;
  }
  Stage get stage => _stage;

  num get width => getAttribute(WIDTH);
  num get height => getAttribute(HEIGHT);
}