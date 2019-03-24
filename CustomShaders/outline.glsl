uniform vec4 outlineColor = vec4(0.0, 0.0, 0.0, 1.0);
uniform float lineTolerance = 0.4;

float dotProduct = dot(_surface.view, _surface.normal);

if ( lineTolerance > dotProduct && dotProduct >  - lineTolerance ) {
  _output.color.rgba = outlineColor;
}

