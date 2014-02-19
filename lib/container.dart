part of smartcanvas;

abstract class Container<T> {
  List<T> _children = new List<T>();
  Container() {}

  void add(T node);

  void removeChild(T node);

  void removeChildAt(int index);

  void insert(int index, T node);

  List<T> get children;
}