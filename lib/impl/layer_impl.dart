part of smartcanvas;

abstract class LayerImpl extends NodeImpl implements Container<NodeImpl> {
  LayerImpl(Layer shell): super(shell) {}

  void suspend();
  void resume();
}