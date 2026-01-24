const express = require("express");
const cors = require("cors");
const sequelize = require("./config/database");
require("dotenv").config();

// Import Routes
const authRoutes = require("./routes/authRoutes");
const carRoutes = require("./routes/carRoutes");

const app = express();

// 1. MIDDLEWARE
app.use(cors());
app.use(express.json()); // Essential for parsing POST bodies

// 2. LOGGER (Debug Tool)
app.use((req, res, next) => {
  console.log(`Incoming Request: ${req.method} ${req.url}`);
  next();
});

// 3. ROUTES
// These prefixes are CRITICAL.
// If you hit /api/auth/register, it goes to authRoutes
app.use("/api/auth", authRoutes);
app.use("/api/cars", carRoutes);

// 4. HEALTH CHECK
app.get("/", (req, res) => {
  res.send("✅ Rental App API is Online");
});

// 5. CATCH-ALL 404 (This will tell us if a route is missing)
app.use((req, res) => {
  res.status(404).json({
    message: `Route ${req.method} ${req.url} Not Found on this server.`,
  });
});

const PORT = process.env.PORT || 3000;

sequelize
  .sync({ alter: true })
  .then(() => {
    console.log("✅ Database connected");
    app.listen(PORT, () => console.log(`🚀 Server: http://localhost:${PORT}`));
  })
  .catch((err) => console.error("❌ DB Error:", err));
