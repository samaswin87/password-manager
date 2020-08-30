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
  return response;
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
