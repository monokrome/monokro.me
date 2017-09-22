import React from "react";

import Blocks from "components/blocks";

const draw = (x, y) => {
  const time = +new Date();
  if (Math.sin(time * x / 200) > 0.5) return { fillStyle: "steelblue" };
  return { fillStyle: "#FF9900" };
};

export default props => <Blocks draw={draw} />;
