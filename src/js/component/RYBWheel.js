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
import Three from 'three'

import fragmentShader from '../shader/ryb_wheel_frag.glsl'
import vertexShader from '../shader/ryb_wheel_vert.glsl'

export default class RYBWheel extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidMount() {
    this.init()
    this.draw()
  }

  init() {
		this.camera = new Three.Camera()
		this.camera.position.z = 1
		this.scene = new Three.Scene()
		this.geometry = new Three.PlaneBufferGeometry(2, 2)
		this.material = new Three.ShaderMaterial({
			vertexShader,
			fragmentShader,
		})
		this.mesh = new Three.Mesh(this.geometry, this.material)
		this.scene.add(this.mesh)
		this.renderer = new Three.WebGLRenderer({
      canvas: this.canvas,
    })
		// this.renderer.setPixelRatio(window.devicePixelRatio)
  }

  draw() {
    this.renderer.render(this.scene, this.camera)
  }

  render() {
    return (
      <canvas
        width="500"
        height="500"
        ref={canvas => this.canvas = canvas}>
      </canvas>
    )
  }
}
