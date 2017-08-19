const { document } = global;

class ButtonClick {

  constructor() {

    this.buttons = document.querySelectorAll('.js-button');

    this.buttons.forEach(button => {
      button.addEventListener('click', e => {
        e.target.classList.add('o-link--icon--clicked');
      });
      button.addEventListener('animationend', e => {
        e.target.classList.remove('o-link--icon--clicked');
      });
    });

  }

}

export default new ButtonClick();
