const fs = require("fs");
const db = require("./db");

const loadSQLFile = async (filePath) => {
	try {
		const sql = fs.readFileSync(filePath, "utf8");
		await db.query(sql);
		console.log(`Successfully executed ${filePath}`);
	} catch (error) {
		console.error(`Error executing ${filePath}:`, error);
	}
};

const loadSQLFiles = async () => {
  const currentDir = process.cwd() + '\\database\\';
    try {
      await loadSQLFile(`${currentDir}TABLE.sql`);
      await loadSQLFile(`${currentDir}PROCEDURE.sql`);
      await loadSQLFile(`${currentDir}TRIGGER.sql`);
      await loadSQLFile(`${currentDir}FUNCTION.sql`);
      await loadSQLFile(`${currentDir}DATA.sql`);
      console.log('All SQL files executed successfully.');
    } catch (error) {
      console.error('Error loading SQL files:', error);
    } finally {
      db.end(); // Close the connection
    }
  };
loadSQLFiles();