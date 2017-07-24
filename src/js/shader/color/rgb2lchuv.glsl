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

#pragma glslify: rgb2luv = require('./rgb2luv', matrix=matrix)

vec3 luc2lchuv(vec3 luv) {
  return vec3(luv.x, length(vec2(luv.yz)), atan(luv.z, luv.y));
}

vec4 luc2lchuv(vec4 luv) {
  return vec4(luc2lchuv(luv.xyz), luv.w);
}

vec3 rgb2lchuv(vec3 rgb, vec3 illuminant) {
  return luc2lchuv(rgb2luv(rgb, illuminant));
}

vec4 rgb2lchuv(vec4 rgb, vec3 illuminant) {
  return luc2lchuv(rgb2luv(rgb, illuminant));
}

#pragma glslify: export(rgb2lchuv)
