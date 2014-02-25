part of smartcanvas;

class Layer extends Group {
  LayerImpl _impl;

  Layer(Map<String, dynamic> config) : super(config) {}

  NodeImpl _createSvgImpl() {
    return  new SvgLayer(this);
  }

  NodeImpl _createCanvasImpl() {
    throw 'Not implemented';
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
}