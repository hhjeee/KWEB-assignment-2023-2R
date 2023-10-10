const express = require("express");

const app = express();
const port = 3000;

app.use(express.urlencoded({ extended: true }));
const stringifyObject = (obj) =>
  Object.keys(obj)
    .map((k) => `${k}: ${obj[k]}`)
    .join("\n");

//Get -> query
//post, put, delete -> body 데이터 문자열 형태로
app.get("/", (req, res) => res.send(stringifyObject(req.query)));
app.post("/", (req, res) => res.send(stringifyObject(req.body)));
app.put("/", (req, res) => res.send(stringifyObject(req.body)));
app.delete("/", (req, res) => res.send(stringifyObject(req.body)));

app.listen(port, () => console.log(`Server listening on port ${port}!`));
