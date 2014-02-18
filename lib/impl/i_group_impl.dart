part of smartcanvas;

abstract class _IGroupImpl extends _INodeImpl {
  Set<_INodeImpl> _children = new Set<_INodeImpl>();
  _IGroupImpl(Map<String, dynamic> attrs): super(attrs) {}

  void add(_INodeImpl child);
}