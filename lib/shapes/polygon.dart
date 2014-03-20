part of smartcanvas;

class Polygon extends Node{
  Polygon(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgPolygon(this);
  }

  NodeImpl _createCanvasImpl() {
    throw 'Not implemented';
  }


  void set points(String value) => setAttribute('points', value);
  List<num> getPsoints() {
    List<num> toReturn = [];
    String ps = getAttribute('points');
    ps.split(',').forEach((sNumber) {
      num p = double.parse(sNumber);
      toReturn.add(p);
    });
    return toReturn;
  }
}
