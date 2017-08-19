const { document, window } = global;

class ColorChange {

  constructor() {

    this.el = document.querySelectorAll('.js-color-change');

    this.window = window;

    document.onmousemove = e => {
      this.mouseMove(e);
    };

  }

  mouseMove(e) {

    this.el.forEach(el => {
      this.changeGradient(el, e);
    });

  }

  changeGradient(el, e) {
    const element = el;
    const w = this.getWindowWidth();
    const p = e.clientX / w;
    const backgroundImage = `linear-gradient(135deg, #79F1A4 ${p * 40}%, #0E5CAD ${60 + (p * 40)}%)`;

    element.style.backgroundImage = backgroundImage;
  }

  getWindowWidth() {
    return this.window.innerWidth || document.documentElement.clientWidth || document.getElementsByTagName('body')[0].clientWidth;
  }

}

export default new ColorChange();
