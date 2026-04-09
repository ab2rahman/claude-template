# Documentation

This directory stores documentation for all projects.

## Structure

```
docs/
├── shared/                # Standards across all projects
│   ├── coding-standards.md
│   └── deployment-guide.md
├── client-a/              # First client/company docs
│   ├── workflow.md
│   └── team-structure.md
├── client-b/              # Second client/company docs
│   └── workflow.md
└── projects/              # Per-project detailed docs
    ├── client-a/
    │   ├── project-a/
    │   │   ├── architecture.md
    │   │   ├── api-endpoints.md
    │   │   └── features.md
    │   └── project-b/
    │       └── architecture.md
    └── client-b/
        └── project-a/
            └── requirements.md
```

## Usage

**Rename to match your setup:**
- `client-a`, `client-b` → Your actual client/company names
- `project-a`, `project-b` → Your actual project names

**Always check documentation before exploring code.** Docs contain complete flows with examples.

## File Types

- `architecture.md` — System architecture, tech stack
- `api-endpoints.md` — API documentation
- `features.md` — Feature list and roadmap
- `requirements.md` — Client requirements
- `workflow.md` — Team workflows, processes
- `deployment-guide.md` — How to deploy
