const { navigator } = global;

class RegisterServiceWorker {
  constructor() {
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker
        .register('service-worker.js')
        .then(() => {
          console.info('Service worker registered!');
        })
        .catch(error => {
          console.error('Error registering service worker: ', error);
        });
    }
    else {
      console.warn('Not supported by browser');
    }
  }
}

export default new RegisterServiceWorker();
