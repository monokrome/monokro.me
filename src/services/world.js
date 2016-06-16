import {Injectable} from "angular2/core";


@Injectable()
export class World {
  create(context) {
    this.draw(context);
  }

  draw(context) {
    context.fillStyle = 'rgb(0,0,0)';
    context.fillRect(0, 0, context.canvas.width, context.canvas.height);

    requestAnimationFrame(this.draw.bind(this, context));
  }
}
