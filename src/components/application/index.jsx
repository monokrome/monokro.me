import React from "react";

import Blocks from "components/blocks";

const draw = (x, y, xGridSize, yGridSize, context) => {
  const xPos = context.canvas.width * x;
  const yPos = context.canvas.height * y;

  context.fillStyle = "#FF9900";
  context.strokeStyle = "steelblue";
  context.strokeWidth = 3;

  context.fillRect(
    xPos,
    yPos + Math.sin(+new Date() / 500),
    xGridSize,
    yGridSize
  );
};

export default props => <Blocks draw={draw} />;
