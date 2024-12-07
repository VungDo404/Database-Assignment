const express = require("express");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());
const PORT = 3000;
const mentorRoutes = require("./routes/mentor");
app.use("/mentors", mentorRoutes);


app.listen(PORT, () => {
	console.log(`Server is running on http://localhost:${PORT}`);
});