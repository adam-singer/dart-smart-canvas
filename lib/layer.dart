part of smartcanvas;

class Layer extends Group {
  Stage _stage;
  LayerImpl _impl;

  Layer(String type, Map<String, dynamic> config) : super(config) {
    _layer = this;
    _impl = createImpl(type);
  }

  NodeImpl _createSvgImpl() {
    return  new SvgLayer(this);
  }

  NodeImpl _createCanvasImpl() {
    throw ExpNotImplemented;
  }

  Layer _clone() {
     return new Layer(_impl.type, _attrs);
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

  Layer get layer => this;

  String get type => _impl.type;

  void set stage(Stage value) {
    _stage = value;
    _stage
    .on('widthChanged', (oldValue, newValue) { width = newValue; })
    .on('heightChanged', (oldValue, newValue) { height = newValue; })
    .on('scaleXChanged', (oldValue, newValue) { scaleX = newValue; })
    .on('scaleYChanged', (oldValue, newValue) { scaleY = newValue; });
  }
  Stage get stage => _stage;

  void set width(num value) => setAttribute(WIDTH, value);
  num get width => getAttribute(WIDTH);

  void set height(num value) => setAttribute(HEIGHT, value);
  num get height => getAttribute(HEIGHT);

  void set scaleX(num value) => setAttribute(SCALE_X, value);
  num get scaleX => getAttribute(SCALE_X, 1);

  void set scaleY(num value) => setAttribute(SCALE_Y, value);
  num get scaleY => getAttribute(SCALE_Y, 1);
}