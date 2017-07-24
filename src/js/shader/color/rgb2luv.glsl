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

vec2 xyz2ucs(vec3 value) {
  return vec2(
    4.0 * value.x / (value.x + 15.0 * value.y + 3.0 * value.z),
    9.0 * value.y / (value.x + 15.0 * value.y + 3.0 * value.z));
}

vec3 xyz2luv(vec3 xyz, vec3 illuminant) {
  vec3 w = tristimulus(illuminant, 1.0);
  float l = xyz.y / w.y;
  if (l > 216.0 / 24389.0) {
    l = 116.0 * pow(l, 1.0 / 3.0) - 16.0;
  } else {
    l = (24389.0 / 27.0) * l;
  }
  vec2 ucs = xyz2ucs(xyz);
  vec2 ucsN = xyz2ucs(w);
  return vec3(
    l,
    13.0 * l * (ucs.x - ucsN.x),
    13.0 * l * (ucs.y - ucsN.y));
}

vec4 xyz2luv(vec4 xyz, vec3 illuminant) {
  return vec4(xyz2luv(xyz.xyz), xyz.w);
}

vec3 rgb2luv(vec3 rgb, vec3 illuminant) {
  return xyz2luv(rgb2xyz(rgb), illuminant);
}

vec4 rgb2luv(vec4 rgb, vec3 illuminant) {
  return xyz2luv(rgb2xyz(rgb), illuminant);
}

#pragma glslify: export(rgb2luv)
