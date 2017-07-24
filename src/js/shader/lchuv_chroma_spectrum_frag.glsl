//
//  The MIT License
//
//  Copyright (C) 2016-Present Shota Matsuda
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

uniform vec2 resolution;
uniform vec3 illuminant;
uniform mat3 matrix;
uniform float chroma;

varying vec2 vUv;

const float pi = 3.14159265358979323846264338327950288419;

#pragma glslify: lchuv2rgb = require('./color/lchuv2rgb', matrix=matrix)
#pragma glslify: checkerboard = require('./checkerboard')

void main()  {
  vec2 uv = vUv;
  vec2 coord = uv * resolution;
  float l = uv.y * 100.0;
  float h = uv.x * pi * 2.0;
  vec4 color = lchuv2rgb(vec4(l, chroma, h, 1.0), illuminant);
  vec4 transparent = checkerboard(coord, 8.0);
  gl_FragColor = vec4(mix(transparent.rgb, color.rgb, color.a), 1.0);
}
