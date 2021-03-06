async function putData(url = '', data = {}) {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const response = await fetch(url, {
    method: 'PUT',
    credentials: 'same-origin',
    mode: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrf
    },
    body: JSON.stringify(data)
  });
  return response.json();
}

async function putFiles(url = '', data) {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const response = await fetch(url, {
    method: 'PUT',
    credentials: 'same-origin',
    mode: 'same-origin',
    headers: {
      'X-CSRF-Token': csrf
    },
    body: data
  });
  return response.json();
}

async function postData(url = '', data = {}) {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const response = await fetch(url, {
    method: 'POST',
    credentials: 'same-origin',
    mode: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrf
    },
    body: JSON.stringify(data)
  });
  return response.json();
}

// need to fix params
async function getData(url = '', params = {}) {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const response = await fetch(url, {
    method: 'GET',
    credentials: 'same-origin',
    mode: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrf
    },
  });
  return response.json();
}
