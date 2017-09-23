import React from "react";

import Blocks from "components/blocks";

const gridCount = 10;

const gridXSize = context => context.canvas.width / gridCount;
const gridYSize = context => context.canvas.height / gridCount;

const gridX = (context, x) => gridXSize(context) * x;
const gridY = (context, y) => gridYSize(context) * y;

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
    const xPos = gridX(context, this.x);
    const yPos = gridY(context, this.y);
    const xSize = gridXSize(context) * this.w;
    const ySize = gridYSize(context) * this.h;

    Object.assign(context, this.attributes);
    context.fillRect(xPos, yPos, xSize, ySize);
  }
}

const OBJECTS = [
  new Rect(0, 0, 1, 1).withAttributes({ fillStyle: "white" }),
  new Rect(9, 0, 1, 1).withAttributes({ fillStyle: "white" }),
  new Rect(9, 9, 1, 1).withAttributes({ fillStyle: "white" }),
  new Rect(0, 9, 1, 1).withAttributes({ fillStyle: "white" }),

  new Rect(4, 6, 4, 2).withAttributes({ fillStyle: "#FF9900" })
];

const draw = context => {
  context.fillStyle = "steelblue";
  context.strokeStyle = "white";

  for (let x = 0; x < gridCount; ++x)
    for (let y = 0; y < gridCount; ++y) {
      new Rect(x, y, 1, 1).draw(context);

      context.strokeRect(
        gridX(context, x),
        gridY(context, y),
        gridXSize(context),
        gridYSize(context)
      );
    }

  OBJECTS.map(obj => obj.draw(context));
};

export default props => <Blocks draw={draw} />;
