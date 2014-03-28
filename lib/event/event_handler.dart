part of smartcanvas;

class EventHandler {
  String id;
  Function handler;

  EventHandler(this.id, this.handler);

  call([dynamic arg0, arg1, arg2, arg3, arg4, arg5]) {
    if (arg5 != null) {
      handler(arg0, arg1, arg2, arg3, arg4, arg5);
    } else if (arg4 != null) {
      handler(arg0, arg1, arg2, arg3, arg4);
    } else if (arg3 != null) {
      handler(arg0, arg1, arg2, arg3);
    } else if (arg2 != null) {
      handler(arg0, arg1, arg2);
    } else if (arg1 != null) {
      handler(arg0, arg1);
    } else if (arg0 != null) {
      handler(arg0);
    } else {
      handler();
    }
  }
}

class EventHandlers {
  List<EventHandler> _handlers = new List<EventHandler>();

  void add(EventHandler handler) {
    _handlers.add(handler);
  }

  void remove(EventHandler handler) {
    _handlers.remove(handler);
  }

  void removeAt(int index) {
    _handlers.removeAt(index);
  }

  operator[](int index) {
    return _handlers[index];
  }

  num get length => _handlers.length;

  bool get isEmpty => _handlers.isEmpty;

  call([dynamic arg0, arg1, arg2, arg3, arg4, arg5]) {
    _handlers.forEach((handler) {
      handler(arg0, arg1, arg2, arg3, arg4, arg5);
    });
  }
}