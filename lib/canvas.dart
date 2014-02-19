part of smartcanvas;

class Canvas extends Node implements Container<Node> {
  DOM.Element _container;
  CanvasImpl _impl;
  List<Node> _children = new List<Node>();

  Canvas(this._container, String type, Map<String, dynamic> config): super(config){
    _impl = createImpl(type);
  }

  void populateConfig(Map<String, dynamic> config) {
    setAttribute('width', config.containsKey('width') ? config['width'] : 0);
    setAttribute('height', config.containsKey('height') ? config['height'] : 0);
  }

  NodeImpl _createSvgImpl() {
    return new SvgCanvas(_container, this);
  }

  NodeImpl _createCanvasImpl() {
    throw'Not implemented';
  }

  void add(Node node) {
    node._canvas = _impl;
    node._parent = this;
    _children.add(node);
    node.createImpl(_impl.type);
    _impl.add(node._impl);
  }

  void removeChild(Node node) {
    _children.remove(node);
    _impl.removeChild(node._impl);
    node._parent = null;
  }

  void removeChildAt(int index) {
    Node child = _children.elementAt(index);
    removeChild(child);
  }

  void insert(int index, Node node) {
    node._canvas = _impl;
    node._parent = this;
    _children.insert(index, node);
    _impl.insert(index, node._impl);
  }

  List<Node> get children => _children;

  void set width(num value) => setAttribute('width', value);
  num get width => getAttribute('width');

  void set height(num value) => setAttribute('height', value);
  num get height => getAttribute('height');
}

