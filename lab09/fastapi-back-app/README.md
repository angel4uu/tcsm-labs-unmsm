# FastAPI backend for Lab09

Endpoints:

- `POST /usuarios` — validate credentials. JSON body: `{ "usuario": "user1", "contrasena": "pass1" }`
- `GET /personas` — returns all personas; optional `q` query param to search by nombre/apellido.

Run locally:

```bash
python -m pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```
