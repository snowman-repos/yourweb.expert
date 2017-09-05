import Promise from 'promise-polyfill';

/* eslint-disable max-len */
/** This is how you use the environments variables passed by the webpack.DefinePlugin **/

/**
 * The linter can be disabled via LINTER=false env var - show a message in console to inform if it's on or off
 * Won't show in production
 */
if (process.env.NODE_ENV !== 'production') {
  if (!process.env.LINTER) {
    console.warn('Linter disabled, make sure to run your code against the linter, otherwise, if it fails, your commit will be rejected.');
  }
  else {
    console.info('Linter active, if you meet some problems, you can still run without linter, just set the env var LINTER=false.');
  }
}
else if (process.env.DEVTOOLS) {
  console.info('Turn on the "Sources" tab of your devtools to inspect original source code - thanks to sourcemaps!');
}

/**
 * You could setup some mocks for tests
 * Won't show in production
 */
if (process.env.NODE_ENV === 'mock') {
  console.info('MOCK mode');
}

if (process.env.DEVTOOLS && process.env.NODE_ENV !== 'production') {
  console.info(`You're on DEVTOOLS mode, you may have access to tools enhancing developer experience - off to you to choose to disable them in production ...`);
}

/** This is where the "real code" start */

const main = () => {

  console.log('%c Welcome to YourWeb.Expert ', 'background: #0E5CAD; color: #FFFFFF; font-size: 18px; font-family: "Helvetica Neue"; font-weight: 300; line-height: 30px; height: 30px; padding: 5px');
  console.log('%c darryl@yourweb.expert ', 'background: #0E5CAD; color: #FFFFFF; font-size: 13px; font-family: "Helvetica Neue"; font-weight: 300; line-height: 14px; height: 30px; padding: 5px 55px;');

  const { document, window } = global;
  if (document && document.querySelector) {

    // To add to window
    if (!window.Promise) {
      window.Promise = Promise;
    }

    import('./scripts/button-click.js')
      .then(() => {})
      .catch(error => console.error('Chunk loading failed', error));

    import('./scripts/color-change.js')
      .then(() => {})
      .catch(error => console.error('Chunk loading failed', error));

    import('./scripts/get-blog-posts.js')
      .then(() => {})
      .catch(error => console.error('Chunk loading failed', error));

    import('./scripts/register-service-worker.js')
      .then(() => {})
      .catch(error => console.error('Chunk loading failed', error));

    import('./scripts/resize-description.js')
      .then(() => {})
      .catch(error => console.error('Chunk loading failed', error));

    import('./scripts/type-effect.js')
      .then(() => {})
      .catch(error => console.error('Chunk loading failed', error));

  }
};

main();
