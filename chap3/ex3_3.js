const express = require("express");

const app = express();
const port = 3000;

const factorial = (number) => {
  return number ? number * factorial(number - 1) : 1;
};

app.get("/factorial", (req, res) => {
  const { number } = req.query;
  return res.redirect(`/factorial/${number}`);
});

app.get("/factorial/:number", (req, res) => {
  const { number } = req.params;
  const result = factorial(number);
  return res.send(`${number}! = ${result}`);
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));
