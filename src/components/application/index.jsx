import React from "react";

import Blocks from "components/blocks";

const gridCount = 10;

const gridSize = () =>
  Math.min(window.innerHeight, window.innerWidth) / 10 * 0.9;

const sinAsRatio = value => (Math.sin(value) + 1) / 2;

class Rect {
  constructor(x, y, w, h, maxAge) {
    this.createdAt = +new Date();

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.attributes = {
      fillStyle: "steelblue",
      strokeStyle: "white"
    };
  }

  withAttributes(attributes) {
    Object.assign(this.attributes, attributes);
    return this;
  }

  draw(context) {
    const xPos = gridSize() * this.x;
    const yPos = gridSize() * this.y;
    const xSize = gridSize(context) * this.w;
    const ySize = gridSize(context) * this.h;

    Object.assign(context, this.attributes);
    context.fillRect(xPos, yPos, xSize, ySize);
  }
}

const clamp = (min, val, max) => Math.min(max, Math.max(min, val));
const getObjects = () => {
  const padding = 2;
  const range = -1 + gridCount - padding * 2;

  const yValue = parseInt(sinAsRatio(+new Date() / 600) * range, 10) + padding;
  const y = Math.max(padding, clamp(padding, yValue, gridCount - padding));

  return [
    new Rect(0, 0, 1, 1).withAttributes({ fillStyle: "white" }),
    new Rect(9, 0, 1, 1).withAttributes({ fillStyle: "white" }),
    new Rect(9, 9, 1, 1).withAttributes({ fillStyle: "white" }),
    new Rect(0, 9, 1, 1).withAttributes({ fillStyle: "white" }),

    new Rect(4, y, 4, 2).withAttributes({ fillStyle: "#FF9900" })
  ];
};

const draw = context => {
  context.canvas.width = gridSize() * gridCount;
  context.canvas.height = gridSize() * gridCount;

  context.canvas.style.marginLeft = parseInt(
    (window.innerWidth - context.canvas.width) / 2,
    10
  );

  context.canvas.style.marginTop = parseInt(
    (window.innerHeight - context.canvas.height) / 2,
    10
  );

  context.fillStyle = "steelblue";
  context.strokeStyle = "white";

  for (let x = 0; x < gridCount; ++x)
    for (let y = 0; y < gridCount; ++y) {
      new Rect(x, y, 1, 1).draw(context);

      context.strokeRect(
        gridSize() * x,
        gridSize() * y,
        gridSize(),
        gridSize()
      );
    }

  getObjects().map(obj => obj.draw(context));
};

export default props => <Blocks draw={draw} />;
