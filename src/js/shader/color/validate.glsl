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

float validate(float value, float low, float high) {
  return step(low, value) * step(value, high);
}

float validate(vec2 value, vec2 low, vec2 high) {
  vec2 binary = step(low, value) * step(value, high);
  return binary.x * binary.y;
}

float validate(vec3 value, vec3 low, vec3 high) {
  vec3 binary = step(low, value) * step(value, high);
  return binary.x * binary.y * binary.z;
}

float validate(vec4 value, vec4 low, vec4 high) {
  vec4 binary = step(low, value) * step(value, high);
  return binary.x * binary.y * binary.z * binary.w;
}

#pragma glslify: export(validate)
