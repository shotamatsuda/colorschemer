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

import { Component } from 'react'
import PropTypes from 'prop-types'
import Three from 'three'

import { Illuminant, Primaries, XYZ } from '@shotamatsuda/color'

import fragmentShader from '../shader/lchab_lightness_spectrum_frag.glsl'
import vertexShader from '../shader/lchab_lightness_spectrum_vert.glsl'

export default class LCHabLightnessSpectrum extends Component {
  constructor(props) {
    super(props)
    this.state = {
      lightness: 0,
    }
    this.handleChange = this.handleChange.bind(this)
  }

  componentDidMount() {
    this.init()
    this.draw()
  }

  componentDidUpdate() {
    this.material.uniforms.resolution.value.x = this.props.width
    this.material.uniforms.resolution.value.y = this.props.height
    this.material.uniforms.lightness.value = this.state.lightness
    this.draw()
  }

  handleChange(event) {
    this.setState({
      [event.target.name]: event.target.value,
    })
  }

  init() {
    this.renderer = new Three.WebGLRenderer({
      canvas: this.canvas,
    })
    this.renderer.setPixelRatio(window.devicePixelRatio)
    this.renderer.setSize(this.props.width, this.props.height)
    this.camera = new Three.Camera()
    this.camera.position.z = 1
    this.scene = new Three.Scene()
    this.geometry = new Three.PlaneBufferGeometry(2, 2)
    const illuminant = new Three.Vector3(...Illuminant.D50.toArray())
    const matrix = new Three.Matrix3()
    matrix.set(...XYZ.XYZToRGBMatrix(Primaries.sRGB))
    const uniforms = {
      resolution: {
        value: new Three.Vector2(this.props.width, this.props.height)
      },
      illuminant: { value: illuminant },
      matrix: { value: matrix },
      lightness: { value: this.state.lightness },
    }
    this.material = new Three.ShaderMaterial({
      uniforms,
      vertexShader,
      fragmentShader,
    })
    this.mesh = new Three.Mesh(this.geometry, this.material)
    this.scene.add(this.mesh)
  }

  draw() {
    this.renderer.render(this.scene, this.camera)
  }

  render() {
    return (
      <div>
        <canvas
          ref={canvas => this.canvas = canvas}
        />
        <br />
        <input
          name="lightness"
          type="range"
          min="0"
          max="100"
          step="any"
          style={{ width: '100%' }}
          value={this.state.lightness}
          onChange={this.handleChange}
        />
      </div>
    )
  }
}

LCHabLightnessSpectrum.defaultProps = {
  width: 1000,
  height: 500,
}

LCHabLightnessSpectrum.propTypes = {
  width: PropTypes.number,
  height: PropTypes.number,
}
