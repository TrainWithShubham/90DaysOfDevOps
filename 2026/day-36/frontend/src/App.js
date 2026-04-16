import { useState, useEffect } from "react";
const API = "http://localhost:5000";
export default function App() {
  const [todos, setTodos] = useState([]);
  const [input, setInput] = useState("");
  const fetchTodos = () =>
    fetch(`${API}/todos`).then((r) => r.json()).then(setTodos);
  useEffect(() => { fetchTodos(); }, []);
  const addTodo = () => {
    if (!input.trim()) return;
    fetch(`${API}/todos`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title: input }),
    }).then(() => { setInput(""); fetchTodos(); });
  };
  const toggleTodo = (id) =>
    fetch(`${API}/todos/${id}`, { method: "PUT" }).then(fetchTodos);
  const deleteTodo = (id) =>
    fetch(`${API}/todos/${id}`, { method: "DELETE" }).then(fetchTodos);
  return (
    <div style={{ maxWidth: 600, margin: "60px auto", fontFamily: "Arial, sans-serif", padding: "0 20px" }}>
      <h1 style={{ textAlign: "center", color: "#333" }}>📝 Todo App</h1>
      <p style={{ textAlign: "center", color: "#888", fontSize: 13 }}>Dockerized with React + Node.js + MySQL</p>
      <div style={{ display: "flex", gap: 10, marginBottom: 30 }}>
        <input value={input} onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && addTodo()}
          placeholder="Add a new task..."
          style={{ flex: 1, padding: "10px 14px", borderRadius: 8, border: "1px solid #ddd", fontSize: 15 }}
        />
        <button onClick={addTodo}
          style={{ padding: "10px 20px", background: "#4CAF50", color: "#fff", border: "none", borderRadius: 8, cursor: "pointer", fontSize: 15 }}>
          Add
        </button>
      </div>
      {todos.length === 0 && <p style={{ textAlign: "center", color: "#aaa" }}>No todos yet. Add one above!</p>}
      {todos.map((todo) => (
        <div key={todo.id} style={{ display: "flex", alignItems: "center", justifyContent: "space-between",
          padding: "12px 16px", marginBottom: 10, background: "#f9f9f9", borderRadius: 8, border: "1px solid #eee" }}>
          <span onClick={() => toggleTodo(todo.id)}
            style={{ cursor: "pointer", textDecoration: todo.completed ? "line-through" : "none", color: todo.completed ? "#aaa" : "#333", flex: 1 }}>
            {todo.completed ? "✅" : "⬜"} {todo.title}
          </span>
          <button onClick={() => deleteTodo(todo.id)}
            style={{ background: "#ff4d4d", color: "#fff", border: "none", borderRadius: 6, padding: "5px 12px", cursor: "pointer" }}>
            Delete
          </button>
        </div>
      ))}
    </div>
  );
}
