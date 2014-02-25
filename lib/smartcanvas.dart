library smartcanvas;

// external dependencies
import 'dart:html' as DOM;
//import 'dart:svg' as SVG;
//import 'package:html5_dnd/html5_dnd.dart';

import 'impl/svg/svg.dart';
import 'impl/canvas/canvas.dart';

part 'nodebase.dart';
part 'node.dart';
part 'container.dart';
part 'canvas.dart';
part 'group.dart';
part 'layer.dart';

part 'utils/position.dart';
part 'utils/constants.dart';

part 'shape/circle.dart';
part 'shape/ellipse.dart';
part 'shape/rect.dart';
part 'shape/line.dart';

part 'impl/canvas_impl.dart';
part 'impl/node_impl.dart';
part 'impl/layer_impl.dart';