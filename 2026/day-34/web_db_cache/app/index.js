const express = require("express");
const { Client } = require("pg");
const { createClient } = require("redis");
const os = require("os");

const app = express();
const port = 3000;

const DATABASE_URL = process.env.DATABASE_URL;
const REDIS_HOST = process.env.REDIS_HOST;

// Initialize DB table
async function initDb() {
  const client = new Client({ connectionString: DATABASE_URL });
  await client.connect();

  await client.query(`
    CREATE TABLE IF NOT EXISTS visits (
      id SERIAL PRIMARY KEY,
      count INTEGER NOT NULL
    );
  `);

  await client.end();
}

app.get("/", async (req, res) => {
  const db = new Client({ connectionString: DATABASE_URL });
  const redis = createClient({ url: `redis://${REDIS_HOST}:6379` });

  try {
    await db.connect();
    if (!redis.isOpen) await redis.connect();

    const result = await db.query("SELECT count FROM visits WHERE id=1");

    let count;
    if (result.rows.length > 0) {
      count = result.rows[0].count + 1;
      await db.query("UPDATE visits SET count=$1 WHERE id=1", [count]);
    } else {
      count = 1;
      await db.query("INSERT INTO visits (id, count) VALUES (1, $1)", [count]);
    }

    await redis.set("last_visit", count);
    const cached = await redis.get("last_visit");

    // Test Redis connection status
    const redisStatus = redis.isOpen ? "green" : "red";

    await db.end();
    await redis.quit();

    const hostname = os.hostname(); // Container hostname

    res.send(`
<!DOCTYPE html>
<html>
<head>
<title>Docker 3-Tier Demo</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
:root {
  --bg-gradient: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
  --card-bg: rgba(255,255,255,0.08);
  --text-color: #fff;
}
body {
  margin:0; font-family:'Segoe UI',sans-serif;
  height:100vh; overflow:hidden;
  background: var(--bg-gradient);
  display:flex; justify-content:center; align-items:center;
  color:var(--text-color);
  transition: all 0.5s ease;
}

.light-mode {
  --bg-gradient: linear-gradient(135deg, #f5f7fa, #c3cfe2);
  --card-bg: rgba(255,255,255,0.8);
  --text-color: #111;
}

#particles {
  position: absolute;
  top:0; left:0;
  width:100%; height:100%;
  z-index:0;
}

.card {
  background: var(--card-bg);
  backdrop-filter: blur(15px);
  padding:50px;
  border-radius:20px;
  text-align:center;
  width:500px;
  z-index:1;
  box-shadow:0 20px 50px rgba(0,0,0,0.4);
  animation: fadeIn 1s ease-in-out;
  position:relative;
}

h1 { margin-bottom:15px; }

.counter { font-size:70px; font-weight:bold; margin:20px 0; color:#00ffc3; }

.badges { margin-top:15px; }
.badge { display:inline-block; padding:8px 14px; border-radius:20px; margin:5px; font-size:14px; font-weight:500; }
.db { background:#4CAF50; }
.cache { background:#FF9800; }

.tech-icons { margin-top:20px; font-size:28px; }
.tech-icons i { margin:10px; transition: transform 0.3s ease; }
.tech-icons i:hover { transform: scale(1.2); }

.status {
  display:inline-block;
  width:14px; height:14px;
  border-radius:50%;
  margin-left:6px;
  vertical-align:middle;
}

.toggle-btn {
  position:absolute;
  top:20px; right:20px;
  cursor:pointer;
  font-size:22px;
  z-index:2;
}

.footer { margin-top:20px;font-size:13px;opacity:0.8; }

@keyframes fadeIn {
  from { opacity:0; transform: translateY(20px);}
  to { opacity:1; transform: translateY(0);}
}
</style>
</head>
<body>

<canvas id="particles"></canvas>

<div class="toggle-btn" onclick="toggleTheme()">
  <i class="fas fa-adjust"></i>
</div>

<div class="card">
  <h1>🚀 Docker 3-Tier Demo</h1>

  <div class="counter" id="counter">0</div>
  <div>Page Visits</div>

  <div class="badges">
    <span class="badge db">PostgreSQL Connected</span>
    <span class="badge cache">Redis Active <span class="status" style="background:${redisStatus};"></span></span>
  </div>

  <div style="margin-top:15px;">
    Cached Value: <strong>${cached}</strong>
  </div>

  <div class="tech-icons">
    <i class="fab fa-node-js"></i>
    <i class="fas fa-database"></i>
    <i class="fas fa-memory"></i>
    <i class="fab fa-docker"></i>
  </div>

  <div style="margin-top:10px;">
    Container: <strong>${hostname}</strong>
  </div>

  <div class="footer">
    Express.js + PostgreSQL + Redis <br>
    Running with Docker Compose
  </div>
</div>

<script>
// Animated counter
let finalValue = ${count};
let current = 0;
let speed = 15;
function animateCounter() {
  if(current < finalValue){
    current++;
    document.getElementById("counter").innerText = current;
    setTimeout(animateCounter,speed);
  }
}
animateCounter();

// Dark/light auto-detect
if(window.matchMedia && window.matchMedia('(prefers-color-scheme: light)').matches){
  document.body.classList.add('light-mode');
}

function toggleTheme(){
  document.body.classList.toggle('light-mode');
}

// Particles effect
const canvas = document.getElementById('particles');
const ctx = canvas.getContext('2d');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;
let particles = [];
for(let i=0;i<100;i++){
  particles.push({x:Math.random()*canvas.width, y:Math.random()*canvas.height, r:Math.random()*3+1, dx:(Math.random()-0.5)*1, dy:(Math.random()-0.5)*1});
}
function draw(){
  ctx.clearRect(0,0,canvas.width,canvas.height);
  particles.forEach(p=>{
    ctx.beginPath();
    ctx.arc(p.x,p.y,p.r,0,Math.PI*2);
    ctx.fillStyle = 'rgba(255,255,255,0.4)';
    ctx.fill();
    p.x += p.dx; p.y += p.dy;
    if(p.x>canvas.width)p.x=0;
    if(p.x<0)p.x=canvas.width;
    if(p.y>canvas.height)p.y=0;
    if(p.y<0)p.y=canvas.height;
  });
  requestAnimationFrame(draw);
}
draw();

// Adjust canvas on resize
window.addEventListener('resize',()=>{canvas.width=window.innerWidth;canvas.height=window.innerHeight;});
</script>

</body>
</html>
    `);

  } catch(err){
    res.status(500).send("Error: "+err.message);
  }
});

app.listen(port,"0.0.0.0",async()=>{
  console.log("Starting app...");
  await initDb();
  console.log(`Server running on port ${port}`);
});