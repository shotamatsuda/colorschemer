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

#pragma glslify: rgb2xyz = require('./rgb2xyz', matrix=matrix)
#pragma glslify: tristimulus = require('./tristimulus')
#pragma glslify: validate = require('./validate')

float compand(float value) {
  if (value > 216.0 / 24389.0) {
    return pow(value, 1.0 / 3.0);
  }
  return (841.0 / 108.0) * value + 4.0 / 29.0;
}

vec3 xyz2lab(vec3 xyz, vec3 illuminant) {
  vec3 w = tristimulus(illuminant, 1.0);
  float t = compand(xyz.y / w.y);
  return vec3(
    116.0 * t - 16.0,
    500.0 * (compand(xyz.x / w.x) - t),
    200.0 * (t - compand(xyz.z / w.z)));
}

vec4 xyz2lab(vec4 xyz, vec3 illuminant) {
  return vec4(xyz2lab(xyz.xyz), xyz.w);
}

vec3 rgb2lab(vec3 rgb, vec3 illuminant) {
  return xyz2lab(rgb2xyz(rgb), illuminant);
}

vec4 rgb2lab(vec4 rgb, vec3 illuminant) {
  return xyz2lab(rgb2xyz(rgb), illuminant);
}

#pragma glslify: export(rgb2lab)
