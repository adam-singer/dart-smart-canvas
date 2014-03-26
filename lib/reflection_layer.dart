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

    if (child._impl == null) {
      child._impl = child.createImpl(svg);
    }
    _impl.add(child._impl);
  }

  void insert(int index, Node node) {
    if (!(node is _ReflectionNode)) {
      throw 'Reflection Layer can only add reflection node';
    }

    node._parent = this;
    _children.insert(index, node);
    if (node._impl == null) {
      node._impl = node.createImpl(svg);
    }
    _impl.add(node._impl);
  }
}