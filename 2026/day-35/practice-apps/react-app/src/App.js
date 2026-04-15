import { useState } from 'react';

const COLORS = ['#fef9c3', '#dbeafe', '#dcfce7', '#fce7f3', '#ede9fe'];

function App() {
  const [notes, setNotes] = useState([
    { id: 1, title: 'Docker Basics', body: 'Learn docker run, build, ps, images, rm commands.', color: COLORS[0], createdAt: new Date().toLocaleDateString() },
    { id: 2, title: 'React in Docker', body: 'Build with npm run build, serve with nginx or serve package.', color: COLORS[1], createdAt: new Date().toLocaleDateString() },
  ]);
  const [title, setTitle] = useState('');
  const [body, setBody] = useState('');
  const [search, setSearch] = useState('');
  const [nextId, setNextId] = useState(3);

  const addNote = () => {
    if (!title.trim() && !body.trim()) return;
    const color = COLORS[nextId % COLORS.length];
    setNotes([{ id: nextId, title, body, color, createdAt: new Date().toLocaleDateString() }, ...notes]);
    setNextId(nextId + 1);
    setTitle('');
    setBody('');
  };

  const deleteNote = (id) => setNotes(notes.filter(n => n.id !== id));

  const filtered = notes.filter(n =>
    n.title.toLowerCase().includes(search.toLowerCase()) ||
    n.body.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div style={styles.app}>
      <header style={styles.header}>
        <h1 style={styles.logo}>📝 Notes</h1>
        <input
          style={styles.search}
          placeholder="Search notes..."
          value={search}
          onChange={e => setSearch(e.target.value)}
        />
      </header>

      <div style={styles.form}>
        <input
          style={styles.input}
          placeholder="Title"
          value={title}
          onChange={e => setTitle(e.target.value)}
        />
        <textarea
          style={styles.textarea}
          placeholder="Write your note..."
          rows={3}
          value={body}
          onChange={e => setBody(e.target.value)}
        />
        <button style={styles.btn} onClick={addNote}>+ Add Note</button>
      </div>

      <p style={styles.count}>{filtered.length} note{filtered.length !== 1 ? 's' : ''}</p>

      <div style={styles.grid}>
        {filtered.map(note => (
          <div key={note.id} style={{ ...styles.card, background: note.color }}>
            <div style={styles.cardHeader}>
              <strong style={styles.cardTitle}>{note.title || 'Untitled'}</strong>
              <button style={styles.del} onClick={() => deleteNote(note.id)}>✕</button>
            </div>
            <p style={styles.cardBody}>{note.body}</p>
            <small style={styles.cardDate}>{note.createdAt}</small>
          </div>
        ))}
      </div>
    </div>
  );
}

const styles = {
  app: { minHeight: '100vh', background: '#f8fafc', fontFamily: 'system-ui, sans-serif', padding: '0 0 40px' },
  header: { background: '#1e293b', padding: '16px 24px', display: 'flex', alignItems: 'center', gap: '16px', flexWrap: 'wrap' },
  logo: { color: '#fff', margin: 0, fontSize: '1.5rem' },
  search: { flex: 1, minWidth: '200px', padding: '8px 14px', borderRadius: '8px', border: 'none', fontSize: '0.95rem', outline: 'none' },
  form: { maxWidth: '600px', margin: '24px auto', padding: '20px 24px', background: '#fff', borderRadius: '12px', boxShadow: '0 2px 8px rgba(0,0,0,0.08)', display: 'flex', flexDirection: 'column', gap: '10px' },
  input: { padding: '10px 14px', borderRadius: '8px', border: '1px solid #e2e8f0', fontSize: '1rem', outline: 'none' },
  textarea: { padding: '10px 14px', borderRadius: '8px', border: '1px solid #e2e8f0', fontSize: '0.95rem', resize: 'vertical', outline: 'none' },
  btn: { padding: '10px', background: '#3b82f6', color: '#fff', border: 'none', borderRadius: '8px', fontSize: '1rem', cursor: 'pointer', fontWeight: 600 },
  count: { textAlign: 'center', color: '#64748b', fontSize: '0.85rem', margin: '0 0 16px' },
  grid: { display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))', gap: '16px', padding: '0 24px', maxWidth: '1200px', margin: '0 auto' },
  card: { borderRadius: '12px', padding: '16px', boxShadow: '0 2px 6px rgba(0,0,0,0.06)' },
  cardHeader: { display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '8px' },
  cardTitle: { fontSize: '1rem', color: '#1e293b' },
  cardBody: { color: '#475569', fontSize: '0.9rem', margin: '0 0 10px', whiteSpace: 'pre-wrap' },
  cardDate: { color: '#94a3b8', fontSize: '0.75rem' },
  del: { background: 'none', border: 'none', cursor: 'pointer', color: '#94a3b8', fontSize: '1rem', lineHeight: 1 },
};

export default App;
