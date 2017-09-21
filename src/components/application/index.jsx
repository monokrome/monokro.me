import React, { Component } from "react";
import PropTypes from "prop-types";
import { withState } from "recompose";
import styled from "styled-components";

@withState("context", "setContext", null)
class Application extends Component {
  static propTypes = {
    // Draw function
    draw: PropTypes.func.isRequired,
    gridSize: PropTypes.number.isRequired,

    // Classname from styled-components
    className: PropTypes.string.isRequired,

    // Canvas element state
    context: PropTypes.object,
    setContext: PropTypes.func.isRequired
  };

  static defaultProps = {
    gridSize: 15,

    draw: (x, y) => {
      // Example implementation for when one is not provided
      const timestamp = +new Date();
      if (((timestamp / 350) % x) % y === 0) return { fillStyle: "white" };
      if (x % 2 && y % 2) return { fillStyle: "white" };
      else if (x % 2 && y % 4) return { fillStyle: "orange" };
      else if (y % 2 && x % 4) return { fillStyle: "purple" };
      else if (y % 2) return { fillStyle: "rebeccapurple" };
      else if (x % 4 && y % 2) return { fillStyle: "yellow" };
      else return { fillStyle: "steelblue" };
    }
  };

  draw = canvas => {
    const { context, draw, gridSize } = this.props;

    for (let x = 0; x < gridSize; ++x) {
      for (let y = 0; y < gridSize; ++y) {
        const xDelta = context.canvas.width / gridSize;
        const yDelta = context.canvas.height / gridSize;

        const updates = draw(x, y, context.canvas.width, context.canvas.height);
        if (updates) Object.assign(context, updates);

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
    const { context, setContext } = this.props;
    const newContext = canvas.getContext("2d");

    if (context === newContext) return;

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

export default styled(Application)`
  height: 100vh;
  width: 100vw;
`;
