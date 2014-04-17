part of smartcanvas;

class Layer extends Group {
  Stage _parent;
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

  void removePattern(SCPattern pattern) {
    if (pattern.impl != null) {
      _impl.removePattern(pattern.impl);
    }
  }

  void _handleStageDragMove(e) {
    _transformMatrix.tx = _parent._transformMatrix.tx;
    _transformMatrix.ty = _parent._transformMatrix.ty;
    fire('translateChanged');
  }

  void remove() {
    if (_parent != null) {
      if (layer != null) {
        if (fill is SCPattern) {
          layer.removePattern(fill);
        } else if (stroke is SCPattern) {
          layer.removePattern(stroke);
        }
      }

      if (_impl != null) {
        _impl.remove();
      }

      if (_reflection != null) {
        _children.forEach((child) {
          if (child._reflection != null) {
            (child._reflection as Node).remove();
          }
        });
      }

      _parent.children.remove(this);
      _parent = null;
    }
  }

  Layer get layer => this;

  String get type => _type;

  void set stage(Stage value) {
    _parent = value;
    _transformMatrix = _parent._transformMatrix;
    _parent
    .on('widthChanged', (oldValue, newValue) { width = newValue; })
    .on('heightChanged', (oldValue, newValue) { height = newValue; })
    ;
    fire('stageSet');
  }
  Stage get stage => _parent;

  num get width => getAttribute(WIDTH);
  num get height => getAttribute(HEIGHT);
}