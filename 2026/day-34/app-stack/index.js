const express = require('express');
const { Pool } = require('pg');
const { createClient } = require('redis');

const app = express();

// Database connection
const pool = new Pool({ 
  host: 'db', 
  user: 'postgres', 
  password: 'password', 
  database: 'testdb' 
});

// Redis connection
const redisClient = createClient({ 
  url: 'redis://cache:6379' 
});

app.get('/', async (req, res) => {
  try {
    if (!redisClient.isOpen) await redisClient.connect();
    let visits = await redisClient.get('visits') || 0;
    visits = parseInt(visits) + 1;
    await redisClient.set('visits', visits);

    const dbRes = await pool.query('SELECT NOW()');
    res.send(`<h1>Day 34: App Updated Successfully!</h1><p>Visits (from Redis): ${visits}</p><p>Database Time (from Postgres): ${dbRes.rows[0].now}</p>`);
  } catch (err) {
    res.status(500).send(`Error: ${err.message}`);
  }
});

app.listen(3000, () => console.log('App running on port 3000'));
