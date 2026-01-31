const db = require("../config/db");

// Get all cars
exports.getCars = async (req, res) => {
  try {
    const result = await db.query("SELECT * FROM cars ORDER BY brand ASC");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Get single car details
exports.getCarById = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await db.query("SELECT * FROM cars WHERE id = $1", [id]);
    if (result.rows.length === 0)
      return res.status(404).json({ message: "Car not found" });
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
