importScripts("https://www.gstatic.com/firebasejs/10.13.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.13.2/firebase-messaging-compat.js");

console.log("SW LOADED");


firebase.initializeApp({
  apiKey: "AIzaSyDUWR5_uLD3rYSeglGYOvE-KJ6nmxSehUY",
  authDomain: "dentallink-5440a.firebaseapp.com",
  projectId: "dentallink-5440a",
  storageBucket: "dentallink-5440a.firebasestorage.app",
  messagingSenderId: "22318488604",
  appId: "1:22318488604:web:2fa070a615bec1b5bf93d9",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(async function(payload) {

  console.log("BACKGROUND");
  console.log(payload);

    //await incrementBadge();

   

});