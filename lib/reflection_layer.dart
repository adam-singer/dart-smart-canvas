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

  void insertNode(Node node) {
    if (!(node is _ReflectionNode)) {
      throw 'Reflection Layer can only add reflection node';
    }

    // find next reflectable node in the same layer
    Node realNode = node._node;
    Node nextReflectableNode = realNode.layer.firstReflectableNode(startIndex:realNode.layer._children.indexOf(realNode) + 1);
    if (nextReflectableNode != null) {
      //
      insert(_children.indexOf(nextReflectableNode._reflection.shell), node);
    } else {
      _stage._reflect(realNode);
    }
  }

  void reflectNode(Node node) {
    _ReflectionNode reflection;
    Node realNode = node;
    if (node is _ReflectionNode) {
      reflection = node;
      realNode = node._node;
    } else {
      reflection = new _ReflectionNode(node);
    }

    // find top layer
    var topLayerIndex = _stage._children.length - 1;

    // check if the node is on top layer
    if (topLayerIndex >= 0 && _stage._children.indexOf(realNode.layer) < topLayerIndex) {
      // the node isn't on top layer
      // insert the node before the first node of the top layer

      // get top layer
      var topLayer = _stage._children[topLayerIndex];

      // find the reflection index of the first node in top layer
      var firstReflectableNode = topLayer.firstReflectableNode(excludeChild: true);
      var index = firstReflectableNode == null ? -1 : this._children.indexOf(firstReflectableNode._reflection.shell);

      if (index != -1) {
        insert(index, reflection);
      } else {
        // top layer doesn't have any reflectable node yet, just add the node
        add(reflection);
      }
    } else {
      add(reflection);
    }
  }
}