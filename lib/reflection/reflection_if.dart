part of smartcanvas;

class _I_Reflection {
  Node _node;
  Node _parent;
}

_I_Reflection _createReflection(Node node) {
  if (node._reflection != null) {
    return node._reflection;
  }
  return (node is Group) ? new _ReflectionGroup(node) : new _ReflectionNode(node);
}