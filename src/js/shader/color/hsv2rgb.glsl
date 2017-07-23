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

// TODO: Optimization

vec3 hsv2rgb(vec3 hsv) {
  float h = hsv.x;
  float s = hsv.y;
  float v = hsv.z;
  float i = floor(h * 6.0);
  float f = h * 6.0 - i;
  float p = v * (1.0 - s);
  float q = v * (1.0 - f * s);
  float t = v * (1.0 - (1.0 - f) * s);
  if (i == 0.0) {
    return vec3(v, t, p);
  } else if (i == 1.0) {
    return vec3(q, v, p);
  } else if (i == 2.0) {
    return vec3(p, v, t);
  } else if (i == 3.0) {
    return vec3(p, q, v);
  } else if (i == 4.0) {
    return vec3(t, p, v);
  } else if (i == 5.0) {
    return vec3(v, p, q);
  }
  return vec3(0, 0, 0);
}

#pragma glslify: export(hsv2rgb)
