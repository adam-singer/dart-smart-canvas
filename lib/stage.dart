part of smartcanvas;

class Stage extends NodeBase implements Container<Node> {
  DOM.Element _container;
  DOM.Element _element;
  Layer _defaultLayer;
  Layer _reflectionLayer;
  String _defualtLayerType;
  List<Node> _children = new List<Node>();
  Position _pointerPosition;

  Stage(this._container, String this._defualtLayerType, Map<String, dynamic> config): super(){
    _populateConfig(config);
    _createElement();

    if (_container == null) {
      throw "container doesn't exit";
    }
    _container.createShadowRoot().append(this._element);
//    _container.nodes.add(this._element);

    _reflectionLayer = new Layer(svg, {
      'id': '__reflectionLayer',
      'opacity': 0,
      'visible': false,
      'width': this.width,
      'height': this.height
    });
    _reflectionLayer._stage = this;
    _children.add(_reflectionLayer);
    _element.nodes.add(_reflectionLayer._impl.element);

    _element.onMouseDown.listen(_setPointerPosition);
    _element.onMouseMove.listen(_setPointerPosition);
    _element.onMouseUp.listen(_setPointerPosition);
    _element.onMouseEnter.listen(_setPointerPosition);
    _element.onMouseLeave.listen(_setPointerPosition);
  }

  void _createElement() {
    String c = getAttribute('class');
    _element = new DOM.DivElement();
    if (id != null && !id.isEmpty) {
      _element.id = id;
    }
    _element.classes.add('smartcanvas-stage');
    if (c != null) {
      _element.classes.addAll(c.split(' '));
    }
    _element.setAttribute('role', 'presentation');
    _element.style
      ..position = 'relative'
      ..display = 'inline-block'
      ..width = '${getAttribute('width')}'
      ..height = '${getAttribute('height')}';
  }

  void _populateConfig(Map<String, dynamic> config) {
    _attrs.addAll(config);
    if (getAttribute('width') == null) {
      setAttribute('width', _container.clientWidth);
    }

    if (getAttribute('height') == null) {
      setAttribute('height', _container.clientHeight);
    }
  }

  void _setPointerPosition(e) {
    var scale = getAttribute('scale');
    if (scale == null) {
      scale = 1;
    }

    num x = (e.client.x /*- canvas.currentTranslate.x*/) / scale;
    num y = (e.client.y /*- canvas.currentTranslate.y*/) / scale;
    this._pointerPosition = new Position(x, y);
  }

  Position get pointerPosition => _pointerPosition;

  void add(Node node) {
    if (node is Layer) {
      node._stage = this;
      if (node.width == null) {
        node.width = this.width;
        node.height = this.height;
      }
//      node.createImpl(node.type);
      int index = _element.nodes.indexOf(_reflectionLayer._impl.element);
      _element.nodes.insert(index, node._impl.element);
      _children.add(node);
      _reflect(node);
    } else {
      if (_defaultLayer == null) {
        _defaultLayer = new Layer(this._defualtLayerType, {
          'id': '__default_layer',
        });
        add(_defaultLayer);
      }
      _defaultLayer.add(node);
    }
  }

  void _reflect(Node node) {
    if (node is Layer) {
      node.children.forEach((child) {
        __reflect(child);
      });
    } else {
      __reflect(node);
    }
  }

  void __reflect (Node node) {
    // only node which is draggable or listening
    if (!node.draggable && !node.isListening) {
      if (node is Container) {
        (node as Container).children.forEach((child){
          __reflect(child);
        });
      }
      return;
    }

    assert(node.layer != null);
    if (node.layer != null) {
      var topLayerIndex = _children.length - 1;
      if (topLayerIndex >= 0 && _children.indexOf(node.layer) < topLayerIndex) {
        // the node isn't on top layer
        // insert the node before the first node of
        // to layer

        // get top layer
        var topLayer = _children[topLayerIndex];

        // find the position of the first node
        var index = _reflectionLayer._children.indexOf(topLayer._children[0]._reflection);

        if (index != -1) {
          _reflectionLayer.insert(index, new _ReflectionNode(node));
        } else {
          // top layer doesn't have any node yet, just add the node
          _reflectionLayer.add(new _ReflectionNode(node));
        }
      } else {
        _reflectionLayer.add(new _ReflectionNode(node));
      }
    }
  }

  void removeChild(Node node) {
    if (node is Layer) {
      _children.remove(node);
      node._stage = null;
    } else {
      _defaultLayer.removeChild(node);
    }
  }

  void insert(int index, Node node) {
    if (node is Layer) {
      node._stage = this;
      _children.insert(index, node);
      if (node.width == null) {
        node.width = this.width;
        node.height = this.height;
      }
      node.createImpl(node.type);
      _element.nodes.add(node._impl.element);
    } else {
      _defaultLayer.insert(index, node);
    }
  }

  void _resizeLayers() {
    _children.forEach((layer) {
      layer.width = width;
      layer.height = height;
    });
  }

  List<Node> get children => _children;

  DOM.Element get element => _element;

  void set id(String value) => setAttribute('id', value);
  String get id => getAttribute('id');

  void set width(num value) {
    setAttribute('width', value);
    _resizeLayers();
  }
  num get width => getAttribute('width');

  void set height(num value) {
    setAttribute('height', value);
    _resizeLayers();
  }
  num get height => getAttribute('height');
}

