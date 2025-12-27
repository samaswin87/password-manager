// Refer: https://github.com/olawanlejoel/Password-Generator/blob/master/script.js
// Converted to vanilla JS

const randomFunc = {
  upper: getRandomUpperCase,
  lower: getRandomLowerCase,
  number: getRandomNumber,
  symbol: getRandomSymbol
};

window.generatePassword = function(upper, lower, number, symbol, length) {
  var generatedPassword = "";

  const typesCount = upper + lower + number + symbol;

  const typesArr = [{upper}, {lower}, {number}, {symbol}].filter(item => Object.values(item)[0]);

  if(typesCount === 0) {
    return '';
  }

  for(var i=0; i<length; i+=typesCount) {
    typesArr.forEach(type => {
      const funcName = Object.keys(type)[0];
      generatedPassword += randomFunc[funcName]();
    });
  }

  const finalPassword = generatedPassword.slice(0, length);

  return finalPassword;
};

// Generating random values

function getRandomUpperCase() {
  return String.fromCharCode(Math.floor(Math.random()*26)+65);
}

function getRandomLowerCase() {
  return String.fromCharCode(Math.floor(Math.random()*26)+97);
}

function getRandomNumber() {
  return String.fromCharCode(Math.floor(Math.random()*10)+48);
}

function getRandomSymbol() {
  var symbol = "!@#$%^&*(){}[]=<>/,.|~?";
  return symbol[Math.floor(Math.random()*symbol.length)];
}
