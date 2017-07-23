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

float decompand(float value) {
  if (value > 6.0 / 29.0) {
    return pow(value, 3.0);
  }
  return (108.0 / 841.0) * (value - 4.0 / 29.0);
}

vec3 lab2xyz(vec3 lab, vec3 illuminant) {
  float l = lab.x;
  float a = lab.y;
  float b = lab.z;
  vec3 w = tristimulus(illuminant, 1.0);
  float t = (l + 16.0) / 116.0;
  return vec3(
    decompand(t + a / 500.0) * w.x,
    decompand(t) * w.y,
    decompand(t - b / 200.0) * w.z);
}

vec3 lab2rgb(vec3 lab, vec3 illuminant) {
  return xyz2rgb(lab2xyz(lab, illuminant));
}

#pragma glslify: export(lab2rgb)
