part of smartcanvas;

abstract class _INodeImpl extends NodeBase {
  _INodeImpl _parent = null;

  _INodeImpl(Map<String, dynamic> attrs): super() {
    this._attrs = attrs;
  }

  String get type;
}