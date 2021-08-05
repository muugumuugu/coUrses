// A2Z F17
// Daniel Shiffman
// https://github.com/shiffman/A2Z-F17
// http://shiffman.net/a2z

let clientID = '9XnrhLXdHu1Dg0TSrK6dImCv-7VzCyhNRKJcl86E';
let clientSecret = 'hIqUOlreTW0Zlm0rcPR-v9hkfu1oJo9dmbmR3fDK';
let baseUrl = 'https://api.clarifai.com/v1/';

let accessToken;

let img = 'https://www.petfinder.com/wp-content/uploads/2012/11/91615172-find-a-lump-on-cats-skin-632x475.jpg';

function setup() {
  noCanvas();

  let data = {
    'grant_type': 'client_credentials',
    'client_id': clientID,
    'client_secret': clientSecret
  }

  // Show the image
  createImg(img);

  // get authorization token and call askClarifai() on success
  httpPost(baseUrl + 'token', data, "json", success_token, error);

}

function askClarifai() {
  let data = {
    access_token : accessToken.access_token,
    url: img
  }

  httpGet(baseUrl + 'tag', data, "json", success_tag, error);
}

function success_token (response) {
  console.log("success_token");
  console.log(response);
  accessToken = response;
  askClarifai();
}

function success_tag (response) {
  console.log("success_tag");
  console.log(response);
  results = response["results"];
  tags = results["0"].result.tag.classes
  for (let i = 0; i < tags.length; i++) {
    createDiv(tags[i]);
  }
}

function error (response) {
  console.log("error");
  console.log(response);
}
