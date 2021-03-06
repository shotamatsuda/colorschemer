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

vec3 rgb2hsl(vec3 rgb) {
  float r = rgb.x;
  float g = rgb.y;
  float b = rgb.z;
  float max = max(r, max(g, b));
  float min = min(r, min(g, b));
  float h;
  float s;
  float l = (max + min) / 2.0;
  if (max == min) {
    h = 0.0;
    s = 0.0;
  } else {
    float d = max - min;
    s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min);
    if (max == r) {
      h = ((g - b) / d + (g < b ? 6.0 : 0.0)) / 6.0;
    } else if (max == g) {
      h = ((b - r) / d + 2.0) / 6.0;
    } else {
      h = ((r - g) / d + 4.0) / 6.0;
    }
  }
  return vec3(h, s, l);
}

vec4 rgb2hsl(vec4 rgb) {
  return vec4(rgb2hsl(rgb.xyz), rgb.w);
}

#pragma glslify: export(rgb2hsl)
