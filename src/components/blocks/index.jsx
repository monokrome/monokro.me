import React, { Component } from "react";
import PropTypes from "prop-types";
import { withState } from "recompose";
import styled from "styled-components";

@withState("context", "setContext", null)
export default class Blocks extends Component {
  static propTypes = {
    // Draw function
    draw: PropTypes.func.isRequired,
    gridSize: PropTypes.number.isRequired,
    getContext: PropTypes.func.isRequired,

    // Canvas element state
    context: PropTypes.object,
    setContext: PropTypes.func.isRequired
  };

  static defaultProps = {
    getContext: canvas => canvas.getContext("2d"),
    gridSize: 15
  };

  draw = () => {
    const { context, draw, gridSize } = this.props;

    for (let x = 0; x < gridSize; ++x) {
      for (let y = 0; y < gridSize; ++y) {
        const xDelta = context.canvas.width / gridSize;
        const yDelta = context.canvas.height / gridSize;

        const drawResult = draw(
          1 / gridSize * x,
          1 / gridSize * y,
          xDelta,
          yDelta,
          context
        );
        const updates = Object.assign({ fillStyle: "white" }, drawResult);

        Object.assign(context, updates);

        context.fillRect(xDelta * x, yDelta * y, xDelta, yDelta);
      }
    }

    this.animationRequestId = null;
    this.requestAnimationFrame();
  };

  requestAnimationFrame = () => {
    this.cancelAnimationFrame();
    this.animationRequestId = requestAnimationFrame(this.draw);
  };

  cancelAnimationFrame = () => {
    if (!this.animationRequestId) return;
    cancelAnimationFrame(this.animationRequestId);
    this.animationRequestId = null;
  };

  setContext = canvas => {
    const { context, setContext, getContext } = this.props;
    const newContext = getContext(canvas);

    if (context === newContext) return;

    newContext.canvas.height = window.innerHeight;
    newContext.canvas.width = window.innerWidth;

    setContext(newContext);

    this.requestAnimationFrame(this.draw);
  };

  componentWillUnmount() {
    this.cancelAnimationFrame();
  }

  render() {
    const { className } = this.props;
    return <canvas className={className} ref={this.setContext} />;
  }
}
