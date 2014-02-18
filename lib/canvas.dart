part of smartcanvas;

class Canvas extends Node {
  String _containerId;
  _ICanvasImpl _impl;

  Canvas(this._containerId, String type, Map<String, dynamic> config): super(config){
    _impl = _createImpl(type);
  }

  void populateConfig(Map<String, dynamic> config) {
    _setAttribute('width', config.containsKey('width') ? config['width'] : 0);
    _setAttribute('height', config.containsKey('height') ? config['height'] : 0);
  }

  _INodeImpl _createSvgImpl(type) {
    return new SvgCanvas(_containerId, _attrs);
  }

  _INodeImpl _createCanvasImpl(type) {
    throw'Not implemented';
  }

  void add(Node node) {
    node._parent = this;
    node.addToCanvas(this);
  }

  void set width(num value) => _setAttribute('width', value);
  num get width => _getAttribute('width');

  void set height(num value) => _setAttribute('height', value);
  num get height => _getAttribute('height');
}

