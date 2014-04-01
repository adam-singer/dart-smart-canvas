part of smartcanvas;

class TransformMatrix {
  List<num> matrix = [1, 0, 0, 0, 1, 0, 0, 0,  1];
  TransformMatrix({num sx: 1, num sy: 1, num rx: 0, num ry: 0, num tx: 0, num ty: 0}) {
    matrix[0] = sx;
    matrix[4] = sy;
    matrix[3] = rx;
    matrix[1] = ry;
    matrix[2] = tx;
    matrix[5] = ty;
  }

  void set sx(num value) { matrix[0] = value; }
  num get sx => matrix[0];

  void set sy(num value) { matrix[4] = value; }
  num get sy => matrix[4];

  void set rx(num value) { matrix[3] = value; }
  num get rx => matrix[3];

  void set ry(num value) { matrix[1] = value; }
  num get ry => matrix[1];

  void set tx(num value) { matrix[2] = value; }
  num get tx => matrix[2];

  void set ty(num value) { matrix[5] = value; }
  num get ty => matrix[5];
}