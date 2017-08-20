const { document } = global;
const animationDelay = 2500;
const typeLettersDelay = 100;
const selectionDuration = 500;
const typeAnimationDelay = selectionDuration + 800;

const getNextWord = word => {
  let nextWord = null;
  if (typeof word.nextElementSibling === 'undefined' || word.nextElementSibling == null) {
    nextWord = word.parentNode.firstElementChild;
  }
  else {
    nextWord = word.nextElementSibling;
  }
  return nextWord;
};

class TypeEffect {

  constructor() {

    this.el = {
      description: document.querySelectorAll('.js-description')[0],
      phrases: document.querySelectorAll('.js-phrase')
    };

    this.wrapLetters();
    this.animateText();

  }

  wrapLetters() {
    this.el.phrases.forEach(phrase => {
      const span = phrase;
      const letters = phrase.textContent.split('');
      const selected = phrase.classList.contains('is-visible');
      let innerHTML = '';

      letters.forEach(letter => {
        innerHTML += `<span ${selected ? 'class="c-description-letter is-on"' : 'class="c-description-letter"'}>${letter}</span>`;
      });

      span.innerHTML = innerHTML;

    });
  }

  animateText() {
    setTimeout(() => {
      this.hideWord(this.el.description.querySelectorAll('.is-visible')[0]);
    }, animationDelay);
  }

  hideWord(word) {
    const nextWord = getNextWord(word);
    const parent = word.parentNode;

    parent.classList.add('is-visible');
    parent.classList.remove('.is-waiting');

    setTimeout(() => {
      parent.classList.remove('selected');
      word.classList.remove('is-visible');
      word.classList.add('is-hidden');
      word.querySelectorAll('.c-description-letter').forEach(letter => {
        letter.classList.remove('is-on');
      });
    }, selectionDuration);

    setTimeout(() => {
      this.showWord(nextWord, typeLettersDelay);
    }, typeAnimationDelay);

  }

  showWord(word, duration) {
    this.showLetter(word.querySelectorAll('.c-description-letter')[0], word, false, duration);
    word.classList.add('is-visible');
    word.classList.remove('is-hidden');
  }

  showLetter(letter, word, bool, duration) {
    letter.classList.add('is-on');
    if (typeof letter.nextElementSibling === 'undefined' || letter.nextElementSibling == null) {
      setTimeout(() => {
        word.parentNode.classList.add('waiting');
      }, 200);
      if (!bool) {
        setTimeout(() => {
          this.hideWord(word);
        }, animationDelay);
      }
    }
    else {
      setTimeout(() => {
        this.showLetter(letter.nextElementSibling, word, bool, duration);
      }, duration);
    }
  }

}

export default new TypeEffect();
