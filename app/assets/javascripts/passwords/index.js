// Password Cards View - Now handled by Stimulus controller: passwords_controller.js
// Keeping minimal compatibility layer

let params;
let url;

function initCards(paramsArg, urlArg) {
  params = paramsArg;
  url = urlArg;
  // The Stimulus controller handles this now
  console.log('Password cards initialized with params:', paramsArg);
}

window.password_cards = {
  init: initCards,
  loadPasswords: function(page) {
    // Handled by Stimulus controller now
    console.log('loadPasswords called with page:', page);
  }
};
