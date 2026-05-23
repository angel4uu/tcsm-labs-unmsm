from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import json
from pathlib import Path

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

DATA_DIR = Path(__file__).parent / "data"


def load_json(name: str):
    path = DATA_DIR / name
    with path.open(encoding="utf-8") as f:
        return json.load(f)


@app.on_event("startup")
def startup_event():
    global USUARIOS, PERSONAS
    USUARIOS = load_json("usuario.json")
    PERSONAS = load_json("persona.json")


class LoginRequest(BaseModel):
    usuario: str
    contrasena: str


@app.post("/usuarios")
def login(req: LoginRequest):
    for u in USUARIOS:
        if u.get("usuario") == req.usuario and u.get("contrasena") == req.contrasena:
            return {"success": True, "usuario": u}
    raise HTTPException(status_code=401, detail="Credenciales inválidas")


@app.get("/usuarios")
def list_usuarios():
    return USUARIOS


@app.get("/personas")
def get_personas(q: Optional[str] = None):
    if not q:
        return PERSONAS
    ql = q.lower()
    filtered = [p for p in PERSONAS if ql in p.get("nombre", "").lower() or ql in p.get("apellido", "").lower()]
    return filtered


@app.get("/")
def root():
    return {"message": "FastAPI backend for lab09"}
