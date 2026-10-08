from langchain_core.tools import tool
from pathlib import Path

@tool
def search_logs(file_path: str, pattern: str) -> str:
    """Search a log file for lines containing a pattern."""
    path = Path(file_path)

    if not path.exists():
        return f"File not found: {file_path}"

    matches = []
    with open(path, "r") as f:
        for line_number, line in enumerate(f, 1):
            if pattern.lower() in line.lower():
                matches.append(f"Line {line_number}: {line.strip()}")

    return "\n".join(matches) if matches else "No matches found."

if __name__ == "__main__":
    print(search_logs.invoke({
        "file_path": "sample.log",
        "pattern": "ERROR"
    }))
