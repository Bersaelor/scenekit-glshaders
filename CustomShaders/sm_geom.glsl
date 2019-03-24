uniform float geomIntensity = 1.0;
uniform float factor = 1.0;

float eval(vec3 p, float time) {
    float freq = 1.8;
    float power = 4.0;

    return pow(0.5 + 0.5 * cos(freq * p.x + 1.5 * time) *
						   sin(freq * p.y + 2.5 * time) *
						   sin(freq * p.z + 1.0 * time), power);
}

vec3 computeNormal(vec3 p, vec3 n, float geomIntensity, float time) {
	vec3 e = vec3(0.1, 0.0, 0.0);
	return normalize(n - geomIntensity * vec3(eval(p + e.xyy, time) - eval(p - e.xyy, time),
						  		              eval(p + e.yxy, time) - eval(p - e.yxy, time),
                                              eval(p + e.yyx, time) - eval(p - e.yyx, time)));
}

#pragma body

vec3 p = _geometry.position.xyz;
float disp = factor * geomIntensity * eval(p, u_time);
_geometry.position.xyz += _geometry.normal * disp;
_geometry.normal.xyz = computeNormal(p, _geometry.normal, geomIntensity, u_time);
