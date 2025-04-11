const express = require('express');
const app = express();
const port = 9009;

app.get('/', (req, res) => {
  res.send('¡Espero que os haya gustado!');
});

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});