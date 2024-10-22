import { app } from './firebase-config.js';

console.log("Firebase inicializado com sucesso!", app);

import { onRequest } from 'firebase-functions/v2/https';

export const helloWorld = onRequest((req, res) => {
  res.send("Hello from Firebase!");
});