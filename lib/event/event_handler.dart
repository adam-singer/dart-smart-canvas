part of smartcanvas;

typedef FnWith0Args();
typedef FnWith1Args(a0);
typedef FnWith2Args(a0, a1);
typedef FnWith3Args(a0, a1, a2);
typedef FnWith4Args(a0, a1, a2, a3);
typedef FnWith5Args(a0, a1, a2, a3, a4);
typedef FnWith6Args(a0, a1, a2, a3, a4, a5);

class EventHandler {
  String id;
  Function handler;
  Function _relaxHandler;

  EventHandler(this.id, this.handler) {
    _relaxHandler = _relaxFn(handler);
  }

  Function _relaxFn(Function fn) {
    if (fn is FnWith6Args) {
      return ([a0, a1, a2, a3, a4, a5]) => fn(a0, a1, a2, a3, a4, a5);
    } else if (fn is FnWith5Args) {
      return ([a0, a1, a2, a3, a4, a5]) => fn(a0, a1, a2, a3, a4);
    } else if (fn is FnWith4Args) {
      return ([a0, a1, a2, a3, a4, a5]) => fn(a0, a1, a2, a3);
    } else if (fn is FnWith3Args) {
      return ([a0, a1, a2, a3, a4, a5]) => fn(a0, a1, a2);
    } else if (fn is FnWith2Args) {
      return ([a0, a1, a2, a3, a4, a5]) => fn(a0, a1);
    } else if (fn is FnWith1Args) {
      return ([a0, a1, a2, a3, a4, a5]) => fn(a0);
    } else if (fn is FnWith0Args) {
      return ([a0, a1, a2, a3, a4, a5]) => fn();
    } else {
      return ([a0, a1, a2, a3, a4]) {
        throw "Unknown function type, expecting 0 to 6 args.";
      };
    }
  }

  call([dynamic arg0, arg1, arg2, arg3, arg4, arg5]) {
    _relaxHandler(arg0, arg1, arg2, arg3, arg4, arg5);
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