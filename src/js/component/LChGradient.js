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

import React from 'react'

import { LChuv } from '@shotamatsuda/color'

export default class LChGradient extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidMount() {
    this.draw()
  }

  draw() {
    const context = this.canvas.getContext('2d')
    const { width, height } = this.canvas
    context.clearRect(0, 0, width, height)
    for (let y = 0; y < height; ++y) {
      for (let x = 0; x < width; ++x) {
        const u = x / width
        const v = y / height
        const l = (1.0 - v) * 100
        const c = (0.5 - Math.abs(0.5 - v)) * 100
        const h = u * Math.PI * 2
        const rgb = new LChuv(l, c, h).toRGB()
        context.fillStyle = `rgb(${Math.round(rgb.r * 255)},${Math.round(rgb.g * 255)},${Math.round(rgb.b * 255)})`
        context.fillRect(x, y, 1, 1)
      }
    }
  }

  render() {
    return (
      <canvas
        width="1000"
        height="500"
        ref={canvas => this.canvas = canvas}>
      </canvas>
    )
  }
}
