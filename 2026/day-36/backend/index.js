const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();
app.use(cors());
app.use(express.json());
const db = mysql.createPool({
  host: process.env.DB_HOST || 'mysql',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'rootpassword',
  database: process.env.DB_NAME || 'tododb',
  waitForConnections: true,
  connectionLimit: 10,
});
app.get('/health', (req, res) => res.json({ status: 'ok' }));
app.get('/todos', (req, res) => {
  db.query('SELECT * FROM todos ORDER BY created_at DESC', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});
app.post('/todos', (req, res) => {
  const { title } = req.body;
  if (!title) return res.status(400).json({ error: 'Title is required' });
  db.query('INSERT INTO todos (title) VALUES (?)', [title], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(201).json({ id: result.insertId, title, completed: false });
  });
});
app.put('/todos/:id', (req, res) => {
  const { id } = req.params;
  db.query('UPDATE todos SET completed = NOT completed WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: 'Updated' });
  });
});
app.delete('/todos/:id', (req, res) => {
  const { id } = req.params;
  db.query('DELETE FROM todos WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: 'Deleted' });
  });
});
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log('Backend running on port ' + PORT));
