const { document, window } = global;

class ResizeDescription {

  constructor() {

    this.el = {
      hero: document.querySelectorAll('.js-hero')[0],
      description: document.querySelectorAll('.js-description')[0]
    };

    this.window = window;

    this.adjustHeight();
    window.addEventListener('resize', () => {
      this.adjustHeight();
    });

    // this.adjustHeight();

  }

  adjustHeight() {

    const descriptionHeight = this.getWindowHeight() - this.el.hero.clientHeight;

    if (descriptionHeight <= 180) {
      this.el.description.style.minHeight = '180px';
    }
    else {
      this.el.description.style.minHeight = `${descriptionHeight}px`;
    }

  }

  getWindowHeight() {
    return this.window.innerHeight || document.documentElement.clientHeight || document.getElementsByTagName('body')[0].clientHeight;
  }

}

export default new ResizeDescription();
