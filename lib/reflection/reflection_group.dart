part of smartcanvas;

class _ReflectionGroup extends Group implements _I_Reflection {
  Group _node;

  _ReflectionGroup(Node node): super(node._attrs) {
    _node = node;
    _node._reflection = this;
    _eventListeners.addAll(_node._eventListeners);
    _buildReflectionGroup(_node._children);
  }

  void _buildReflectionGroup(List<Node> children) {
    children.forEach((child) {
      if (!child.reflectable) {
        if (child is Container) {
          _buildReflectionGroup(child._children);
        }
        return;
      }

      _I_Reflection _reflectionChild = (child is Group) ? new _ReflectionGroup(child) : new _ReflectionNode(child);
      add(_reflectionChild);
    });
  }

  NodeImpl _createSvgImpl() {
    assert(_node._impl != null);
    SvgGroup rt = super._createSvgImpl();
    rt.on(DRAGMOVE, _onDragMove);
    return rt;
  }


  NodeImpl _createCanvasImpl() {
    throw 'Reflection Node should alwyas on svg canvas';
  }

  void _onDragMove(DOM.MouseEvent e) {
    (_node._impl as SvgNode).element.setAttribute(TRANSFORM,
        (_impl as SvgNode).element.attributes[TRANSFORM]);
  }

  void add(Node child) {
    if (!(child is _I_Reflection)) {
      throw 'Reflection Layer can only add reflection node';
    }
    super.add(child);
  }

  void insert(int index, _I_Reflection node) {
    if (!(node is _I_Reflection)) {
      throw 'Reflection Layer can only add reflection node';
    }
    super.insert(index, node);
  }

  void insertNode(Node node) {
    if (!(node is _I_Reflection)) {
      throw 'Reflection Layer can only add reflection node';
    }

    // find next reflectable node in the same group
    Node realNode = (node as _I_Reflection)._node;
    Node nextReflectableNode = _node.firstReflectableNode(startIndex:_node._children.indexOf(realNode) + 1);
    if (nextReflectableNode != null) {
      insert(_children.indexOf(nextReflectableNode._reflection), node);
    } else {
      add(node);
    }
  }

}