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
  float i = floor(hsv.x * 6.0);
  float f = hsv.x * 6.0 - i;
  float p = hsv.z * (1.0 - hsv.y);
  float q = hsv.z * (1.0 - f * hsv.y);
  float t = hsv.z * (1.0 - (1.0 - f) * hsv.y);
  if (i == 0.0) {
    return vec3(hsv.z, t, p);
  } else if (i == 1.0) {
    return vec3(q, hsv.z, p);
  } else if (i == 2.0) {
    return vec3(p, hsv.z, t);
  } else if (i == 3.0) {
    return vec3(p, q, hsv.z);
  } else if (i == 4.0) {
    return vec3(t, p, hsv.z);
  } else if (i == 5.0) {
    return vec3(hsv.z, p, q);
  }
  return vec3(0.0, 0.0, 0.0);
}

vec4 hsv2rgb(vec4 hsv) {
  return vec4(hsv2rgb(hsv.xyz), hsv.w);
}

#pragma glslify: export(hsv2rgb)
