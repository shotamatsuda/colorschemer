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

varying vec2 vUv;

const float pi = 3.14159265358979323846264338327950288419;
const float twoPi = 2.0 * pi;

#pragma glslify: ryb2rgb = require('./color/ryb2rgb')
#pragma glslify: rgb2hsv = require('./color/rgb2hsv')
#pragma glslify: hsv2rgb = require('./color/hsv2rgb')

void main()	{
  vec2 uv = (vUv - 0.5) * 2.0;
  float r = mod((atan(uv.y, uv.x) + twoPi), twoPi) / twoPi;
  float s = clamp(length(uv), 0.0, 1.0);
  float h = rgb2hsv(ryb2rgb(hsv2rgb(vec3(r, 1.0, 1.0)))).x;
  vec3 color = hsv2rgb(vec3(h, s, 1.0));
  gl_FragColor = vec4(color.x, color.y, color.z, 1.0);
}
