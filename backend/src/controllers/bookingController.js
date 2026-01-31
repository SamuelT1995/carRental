const db = require("../config/db");

exports.createBooking = async (req, res) => {
  // If Flutter sends nulls, we force them to 1 so the DB doesn't crash
  const user_id = req.body.user_id || 1;
  const car_id = req.body.car_id || 1;
  const { start_date, end_date, total_price } = req.body;

  try {
    console.log("Saving Booking for User:", user_id);

    const newBooking = await db.query(
      "INSERT INTO bookings (user_id, car_id, start_date, end_date, total_price) VALUES ($1, $2, $3, $4, $5) RETURNING *",
      [user_id, car_id, start_date, end_date, total_price],
    );

    res.status(201).json(newBooking.rows[0]);
  } catch (err) {
    console.error("DATABASE ERROR:", err.message);
    res.status(500).json({ error: err.message });
  }
};
