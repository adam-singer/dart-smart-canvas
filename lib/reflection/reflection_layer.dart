part of smartcanvas;

class _ReflectionLayer extends Layer implements _I_Reflection {

  Node _node;
  Container _parent;
  _ReflectionLayer _layer;
  SvgLayer _impl;

  _ReflectionLayer(Map<String, dynamic> config)
    :super(svg, merge(config, {
      ID: '__reflection_layer',
      OPACITY: 0
    }))
  {}

  void add(Node child) {
    if (!(child is _I_Reflection)) {
      throw 'Reflection Layer can only add reflection node';
    }

    super.add(child);

//    _children.add(child);
//    child._parent = this;
//    child._layer = this._layer;
//
//    if (child._impl == null) {
//      child._impl = child.createImpl(svg);
//    }
//    _impl.add(child._impl);
  }

  void insert(int index, Node node) {
    if (!(node is _I_Reflection)) {
      throw 'Reflection Layer can only add reflection node';
    }

    super.insert(index, node);
//    node._parent = this;
//    _children.insert(index, node);
//    if (node._impl == null) {
//      node._impl = node.createImpl(svg);
//    }
//    _impl.add(node._impl);
  }

  void insertNode(Node node) {
    if (!(node is _I_Reflection)) {
      throw 'Reflection Layer can only add reflection node';
    }

    // find next reflectable node in the same layer
    Node realNode = (node as _I_Reflection)._node;
    Node nextReflectableNode = realNode.layer.firstReflectableNode(startIndex:realNode.layer._children.indexOf(realNode) + 1);
    if (nextReflectableNode != null) {
      insert(_children.indexOf(nextReflectableNode._reflection), node);
    } else {
      reflectNode(realNode);
    }
  }

  void reflectNode(Node node) {
    if (node.layer == null) {
      return;
    }

    if (!node.reflectable) {
      // if group wasn't reflectable, reflect its children
      if (node is Container) {
        (node as Container).children.forEach((child){
          reflectNode(child);
        });
      }
      return;
    }

    var reflection = _createReflection(node);
//    Node realNode = node;
//    if (node is _ReflectionNode) {
//      reflection = node;
//      realNode = node._node;
//    } else {
//      reflection = (node is Group) ? new _ReflectionGroup(node) : new _ReflectionNode(node);
//    }

    // find top layer
    var topLayerIndex = _stage._children.length - 1;

    // check if the node is on top layer
    if (topLayerIndex >= 0 && _stage._children.indexOf(node.layer) < topLayerIndex) {
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