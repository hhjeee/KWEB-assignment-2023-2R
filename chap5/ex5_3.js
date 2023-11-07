const express = require("express");
const { runQuery } = require("./database");

const app = express();
const port = 3000;

//사용자의 ID인 uid를 받아 해당 사용자가 지불해야 하는 총 요금을 응답하는 라우트
app.get("/fare", async (req, res, next) => {
  try {
    const { uid } = req.query;
    const sql =
      "SELECT users.name, " +
      "Sum(Round((types.fare_rate/100) * (trains.distance/10) , -2)) AS totalFare " +
      "FROM tickets " +
      "INNER JOIN users ON tickets.user = users.id AND users.id = ? " +
      "INNER JOIN trains ON tickets.train = trains.id " +
      "INNER JOIN types ON trains.type = types.id";
    const { name, totalFare } = (await runQuery(sql, [uid]))[0];
    return res.send(`Total fare of ${name} is ${totalFare} KRW.`);
  } catch (err) {
    console.error(err);
    return res.sendStatus(500);
  }
});

//Query로 열차의 ID인 tid를 받아 해당 열차가 매진되었는지 판단하여 응답하는 라우트
app.get("/train/status", async (req, res, next) => {
  try {
    const { tid } = req.query;
    const sql =
      "SELECT Count(*) AS occupied, max_seats AS maximum FROM tickets " +
      "INNER JOIN trains ON trains.id = tickets.train AND trains.id = ? " +
      "INNER JOIN types ON trains.type = types.id";
    const { occupied, maximum } = (await runQuery(sql, [tid]))[0];
    const isSeatsLeft = occupied < maximum;
    return res.send(`Train ${tid} is ${isSeatsLeft ? "not " : ""}sold out`);
  } catch (err) {
    console.error(err);
    return res.sendStatus(500);
  }
});
app.listen(port, () => console.log(`Server listening on port ${port}!`));
