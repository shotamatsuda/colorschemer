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

vec3 ryb2rgb(vec3 ryb) {
  float r = ryb.x, y = ryb.y, b = ryb.z;
  float white = min(r, min(y, b));
  r -= white;
  y -= white;
  b -= white;
  float maxY = max(r, max(y, b));
  float g = min(y, b);
  y -= g;
  b -= g;
  if (b != 0.0 && g != 0.0) {
    b *= 2.0;
    g *= 2.0;
  }
  r += y;
  g += y;
  float maxG = max(r, max(g, b));
  if (maxG != 0.0) {
    float n = maxY / maxG;
    r *= n;
    g *= n;
    b *= n;
  }
  r += white;
  g += white;
  b += white;
  return vec3(r, g, b);
}

vec4 ryb2rgb(vec4 ryb) {
  return vec4(ryb2rgb(ryb.xyz), ryb.w);
}

#pragma glslify: export(ryb2rgb)
