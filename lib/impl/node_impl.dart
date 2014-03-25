part of smartcanvas;

abstract class NodeImpl extends NodeBase {
//  Stage _stage;
  NodeImpl parent;
  Node _shell;

  NodeImpl(this._shell): super() {
//    this._stage = _shell._stage;
    this._attrs = _shell._attrs;
  }

  String get type;

  void remove();

  NodeImpl clone() {
    ClassMirror cm = reflectClass(this.runtimeType);
    NodeImpl clone = cm.newInstance(const Symbol(EMPTY), [_attrs]).reflectee;
    return clone;
  }

//  void set stage(Stage stage) { _stage = stage; }
//  Stage get stage => _stage;

  Node get shell => _shell;

  LayerImpl get layer {
    NodeImpl parent = this.parent;
    while(parent.parent != null) {
      parent = parent.parent;
    }
    return (parent is LayerImpl) ? parent : null;
  }

  Stage get stage {
    LayerImpl layer = this.layer;
    if (layer != null) {
      return layer.shell._stage;
    }
    return null;
  }

  num get width => getAttribute(WIDTH);
  num get height => getAttribute(HEIGHT);
}