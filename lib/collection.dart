part of smartcanvas;

class Collection<T> {
  Set<T> _children = new Set<T>();
  Collection() {}

  void add(Node node) {
    _children.add(node);
  }

  void removeAt(int index) {
    T child = _children.elementAt(index);
    _children.remove(child);
  }

  void remove(T child) {
    _children.remove(child);
  }
}