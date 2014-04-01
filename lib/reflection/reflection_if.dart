part of smartcanvas;

abstract class _I_Reflection {
  Node _node;
}

abstract class _I_Container_Reflection extends _I_Reflection {
  void insertNode(_I_Reflection node);
}

_I_Reflection _createReflection(Node node) {
  if (node._reflection != null) {
    return node._reflection;
  }
  return (node is Group ? new _ReflectionGroup(node): new _ReflectionNode(node)) as _I_Reflection;
}