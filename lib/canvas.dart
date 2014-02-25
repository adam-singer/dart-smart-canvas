part of smartcanvas;

class Canvas extends Node implements Container<Node> {
  DOM.Element _container;
  CanvasImpl _impl;
  Layer _defaultLayer;
  List<Node> _children = new List<Node>();

  Canvas(this._container, String type, Map<String, dynamic> config): super(config){
    _impl = createImpl(type);
  }

  void populateConfig(Map<String, dynamic> config) {
    config.forEach(setAttribute);
  }

  NodeImpl _createSvgImpl() {
    return new SvgCanvas(_container, this);
  }

  NodeImpl _createCanvasImpl() {
    throw'Not implemented';
  }

  void add(Node node) {
    if (node is Layer) {
      node.canvas = _impl;
      node._parent = this;
      _children.add(node);
      _impl.add(node.createImpl(_impl.type));
    } else {
      defaultLayer.add(node);
    }
  }

  void removeChild(Node node) {
    if (node is Layer) {
      _children.remove(node);
      _impl.removeChild(node._impl);
      node._parent = null;
    } else {
      defaultLayer.removeChild(node);
    }
  }

  void insert(int index, Node node) {
    if (node is Layer) {
      node._canvas = _impl;
      node._parent = this;
      _children.insert(index, node);
      _impl.insert(index, node._impl);
    } else {
      defaultLayer.insert(index, node);
    }
  }

  List<Node> get children => _children;

  Layer get defaultLayer {
    if (_defaultLayer == null) {
      _defaultLayer = new Layer({
        'id': 'defaultLayer'
      });
      add(_defaultLayer);
    }
    return _defaultLayer;
  }

  void set width(num value) => setAttribute('width', value);
  num get width => getAttribute('width');

  void set height(num value) => setAttribute('height', value);
  num get height => getAttribute('height');
}

