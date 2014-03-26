part of smartcanvas;

class _ReflectionLayer extends Layer {
  _ReflectionLayer(Map<String, dynamic> config)
    :super(svg, merge(config, {
      ID: '__reflection_layer',
      OPACITY: 0
    }))
  {}



  void add(Node child) {
    if (!(child is _ReflectionNode)) {
      throw 'Reflection Layer can only add reflection node';
    }

    _children.add(child);
    child._parent = this;
    child._layer = this._layer;

    if (child._reflection == null) {
      child._reflection = child.reflect();
    }
    _impl.add(child._reflection);
  }

  void insert(int index, Node node) {
    if (!(Node is _ReflectionNode)) {
      throw 'Reflection Layer can only add reflection node';
    }

    node._parent = this;
    _children.insert(index, node);
    if (node._reflection == null) {
      node._reflection = node.reflect();
    }
    _impl.add(node._reflection);
  }
}