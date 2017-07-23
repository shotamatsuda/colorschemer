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

uniform vec3 illuminant;
uniform mat3 matrix;

varying vec2 vUv;

const float pi = 3.14159265358979323846264338327950288419;
const float twoPi = 2.0 * pi;

#pragma glslify: lchab2rgb = require('./color/lchab2rgb', matrix=matrix)

void main()	{
  vec2 uv = vUv;
  float l = uv.y * 100.0;
  float c = (0.5 - abs(0.5 - uv.y)) * 128.0;
  float h = uv.x * pi * 2.0;
  vec3 color = lchab2rgb(vec3(l, c, h), illuminant);
  gl_FragColor = vec4(color.x, color.y, color.z, 1.0);
}
