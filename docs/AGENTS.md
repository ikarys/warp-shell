# 🤖 Agents IA - Guide d'Utilisation

Les agents IA de Warp Shell utilisent Ollama localement pour fournir une assistance spécialisée sans dépendre de services cloud.

## Configuration

### Types de Machines

**Laptop** (modèles légers):
- `llama3.2:3b` - Tâches générales
- `codellama:7b` - Code review

**Desktop RTX** (modèles puissants):
- `qwen2.5-coder:32b` - Tâches générales  
- `deepseek-coder-v2:16b` - Code review
- `llama3.2:70b` - Traduction

La configuration est automatique lors de l'installation (`just install-ai`).

### Fichier de Configuration

`~/.config/warp-shell/machine.conf`:
```bash
MACHINE_TYPE=desktop
AI_MODEL_DEFAULT=qwen2.5-coder:32b
AI_MODEL_CODE=deepseek-coder-v2:16b
AI_MODEL_TRANSLATE=llama3.2:70b
```

## 📋 Agent Jira Draft

Aide à rédiger des tickets Jira professionnels et structurés.

### Usage

```bash
# Basique - français (défaut)
just jira-draft "Ajouter authentification OAuth2"

# En anglais
just jira-draft "Add OAuth2 authentication" --lang=en

# Mode interactif (poses des questions)
just jira-interactive
just jira-interactive --lang=en
```

### Exemple de Sortie

```markdown
# Ajouter l'authentification OAuth2

## Contexte
L'application nécessite une authentification plus sécurisée...

## Description
Implémenter OAuth2 pour l'authentification des utilisateurs...

## Critères d'acceptation
- [ ] OAuth2 flow implémenté
- [ ] Tests unitaires couvrant les cas nominaux
- [ ] Documentation API mise à jour

## Impact Technique
- Services: API Gateway, Auth Service
- Dépendances: oauth2-library v2.x
```

### Customisation

Édite les prompts système:
- `agents/config/prompts/jira_fr.txt`
- `agents/config/prompts/jira_en.txt`

## 🔍 Agent Code Review

Review automatique de tes changements Git.

### Usage

```bash
# Review des changements staged
just review
git add .
just review

# Review d'un commit spécifique
just review --commit=HEAD
just review --commit=abc123
```

### Exemple de Sortie

```markdown
📊 Changements: +45 -12 lignes
🤖 Review avec deepseek-coder-v2:16b...

## Résumé des Changements
Ajout d'une nouvelle API endpoint pour les utilisateurs...

## Points Positifs
✅ Bonne séparation des responsabilités
✅ Tests unitaires inclus
✅ Documentation claire

## Problèmes Potentiels
⚠️ Pas de validation des entrées
⚠️ Possible memory leak dans handleRequest()

## Suggestions d'Amélioration
💡 Ajouter rate limiting
💡 Extraire la logique de validation
```

### Tips

- Stage uniquement les fichiers à review: `git add fichier.py`
- Utilise avec pre-commit hooks
- Review avant chaque commit

## 🌍 Agent Traduction

Traduction rapide de texte ou fichiers entiers.

### Usage

```bash
# Texte simple
just translate "Hello world" --to=fr
# → "Bonjour le monde"

# Depuis stdin
echo "Good morning" | just translate --to=fr

# Fichier complet
just translate-file README.md --to=en

# Spécifier langue source
just translate "Hola" --from=es --to=en
```

### Langues Supportées

- `fr` - Français
- `en` - Anglais
- `es` - Espagnol
- `de` - Allemand
- `it` - Italien
- `pt` - Portugais
- `ru` - Russe
- `ja` - Japonais
- `zh` - Chinois

### Fonctionnalités

- Détection automatique de la langue source
- Préserve le markdown et code blocks
- Ne traduit pas les noms propres ni termes techniques
- Adaptation au contexte

## 🛠️ Développement d'Agents

### Créer un Nouvel Agent

1. **Créer le script Python**:
```python
#!/usr/bin/env python3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent / "core"))
from agent import BaseAgent
from ollama_client import OllamaClient

class MonAgent(BaseAgent):
    def __init__(self):
        super().__init__(agent_type="default")
        self.client = OllamaClient(self.model)
        self.system_prompt = self._load_prompt("mon_agent")
    
    def execute(self, input_text: str) -> str:
        return self.client.generate(
            prompt=input_text,
            system=self.system_prompt,
            stream=True
        )

if __name__ == "__main__":
    agent = MonAgent()
    result = agent.execute(sys.argv[1])
```

2. **Créer le prompt système**:
`agents/config/prompts/mon_agent.txt`

3. **Ajouter au Justfile**:
```just
mon-agent text:
    @python3 agents/mon_agent.py "{{text}}"
```

### Classes de Base

**BaseAgent** (`agents/core/agent.py`):
- `_load_config()` - Charge la config machine
- `_get_model()` - Récupère le modèle approprié
- `_load_prompt()` - Charge le prompt système
- `format_output()` - Formatage sortie
- `format_error()` - Formatage erreurs

**OllamaClient** (`agents/core/ollama_client.py`):
- `generate()` - Génération simple
- `chat()` - Conversation avec contexte

## 🔧 Troubleshooting

### Ollama ne démarre pas
```bash
# Vérifier le service
ollama serve

# Tester la connexion
ollama list
```

### Modèle manquant
```bash
# Lister les modèles
ollama list

# Télécharger un modèle
ollama pull llama3.2:3b
```

### Agent lent
- Utilise un modèle plus léger sur laptop
- Vérifie la charge CPU/GPU avec `btop`
- Configure `temperature` plus bas pour réponses plus rapides

### Erreur Python
```bash
# Réinstaller les dépendances
python3 -m pip install --user --upgrade ollama pyyaml
```

## 📊 Performance

### Temps de Réponse Typiques

**Laptop (3B-7B)**:
- Jira draft: 10-20s
- Code review (100 lignes): 30-60s
- Traduction courte: 5-10s

**Desktop RTX (16B-70B)**:
- Jira draft: 5-10s
- Code review (100 lignes): 15-30s
- Traduction courte: 3-5s

### Optimisation

- Réduis `temperature` pour réponses plus rapides
- Utilise des modèles plus petits pour tâches simples
- Stream les réponses (`stream=True`) pour feedback immédiat

## 🎯 Best Practices

1. **Review avant commit**: `just review` systématiquement
2. **Jira en interactif**: Meilleurs résultats avec `--interactive`
3. **Batch traductions**: Traduis plusieurs fichiers en une fois
4. **Prompts clairs**: Plus le contexte est précis, meilleur le résultat
5. **Itération**: N'hésite pas à relancer avec plus de détails

## 🔗 Ressources

- [Ollama Documentation](https://github.com/ollama/ollama)
- [Modèles disponibles](https://ollama.com/library)
- [Prompt Engineering](https://www.promptingguide.ai/)
