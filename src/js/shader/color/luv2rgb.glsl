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

#pragma glslify: tristimulus = require('./tristimulus')
#pragma glslify: xyz2rgb = require('./xyz2rgb', matrix=matrix)

vec2 xyz2ucs(vec3 value) {
  return vec2(
    4.0 * value.x / (value.x + 15.0 * value.y + 3.0 * value.z),
    9.0 * value.x / (value.x + 15.0 * value.y + 3.0 * value.z));
}

vec3 luv2xyz(vec3 luv, vec3 illuminant) {
  vec3 w = tristimulus(illuminant, 1.0);
  vec2 ucsN = xyz2ucs(w);
  float u = luv.y / (13.0 * luv.x) + ucsN.x;
  float v = luv.z / (13.0 * luv.x) + ucsN.y;
  float y;
  if (luv.x > 8.0) {
    y = w.y * pow((luv.x + 16.0) / 116.0, 3.0);
  } else {
    y = w.y * luv.x * (27.0 / 24389.0);
  }
  float x = y * 9.0 * u / (4.0 * v);
  float z = y * (12.0 - 3.0 * u - 20.0 * v) / (4.0 * v);
  return vec3(x, y, z);
}

vec3 luv2rgb(vec3 luv, vec3 illuminant) {
  return xyz2rgb(luv2xyz(luv, illuminant));
}

#pragma glslify: export(luv2rgb)
