const express = require("express");
const router = express.Router();
const db = require("../database/db");

router.get("/available", async (req, res) => {
	try {
		const [rows] = await db.query("CALL UNIVERSITY_MANAGEMENT.GetMentor()");
		res.json(rows[0]);
	} catch (error) {
		console.error("Error calling stored procedure:", error);
		res.status(400).send("An error occurred");
	}
});

router.get("/", async (req, res) => {
	try {
		const [rows] = await db.query("CALL UNIVERSITY_MANAGEMENT.SelectMentoring()");
		res.json(rows[0]);
	} catch (error) {
		console.error("Error calling stored procedure:", error);
		res.status(400).send("An error occurred");
	}
});

router.post("/", async (req, res) => {
  try {
    const { mentorID, menteeID, courseID, sectionID, number, salary } = req.body;
    const [rows] = await db.query(
      "CALL UNIVERSITY_MANAGEMENT.InsertMentoring(?, ?, ?, ?, ?, ?)", // Use placeholders for arguments
      [mentorID, menteeID, courseID, sectionID, number, salary] // Provide the arguments as an array
    );
    res.status(201).json({ message: "Mentoring entry added successfully", data: rows });
  } catch (error) {
    console.error("Error calling stored procedure:", error);
		res.status(400).send(error);
  }
})

router.put("/", async (req, res) => {
  try{
    const { mentorID, menteeID, courseID, sectionID, number, salary } = req.body;
    const [row] = await db.query(
      "CALL UNIVERSITY_MANAGEMENT.UpdateMentoring(?, ?, ?, ?, ?, ?)", // Use placeholders for the arguments
      [mentorID, menteeID, courseID, sectionID, number, salary] // Provide values in an array
    );
    res.json({data: row})
  }catch (error){
    console.error("Error calling stored procedure:", error);
		res.status(400).send(error);
  }
})

router.delete("/:mentorID/mentee/:menteeID/course/:courseID/section/:sectionID", async (req, res) => {
  try{
    const { mentorID, menteeID, courseID, sectionID } = req.params;
    const [row] = await db.query("CALL UNIVERSITY_MANAGEMENT.DeleteMentoring(?, ?, ?, ?)", [mentorID, menteeID, courseID, sectionID]);
    res.json(row[0])
  }catch (error){
    console.error("Error calling stored procedure:", error);
		res.status(400).send(error);
  }
});

module.exports = router;
