# Project Directory Structure

Recommended structure for organizing your actual projects on Windows.

## Drive Location

**Use `D:/` drive** (separate from OS drive `C:/`):

```
D:/
└── workspace/              # or "code", "projects", your-choice
    ├── client-a/           # First client/company
    │   ├── project-a/
    │   │   ├── .claude/    # Project-specific CLAUDE.md
    │   │   ├── docs/       # Project docs (if large)
    │   │   └── src/
    │   └── project-b/
    │       └── ...
    ├── client-b/           # Second client/company
    │   └── project-a/
    └── personal/           # Personal projects
        └── experiments/
```

## Why This Structure?

| Benefit | Explanation |
|---------|-------------|
| **Separate from OS** | D: drive won't affect Windows if issues occur |
| **Easy backup** | Backup entire workspace folder |
| **Organized** | Clear separation between clients/projects |
| **Scalable** | Easy to add new clients or projects |

## Env Variables Example

Update your `.env` to match:

```bash
WORKSPACE_ROOT=D:/workspace
CLIENT_A_ROOT=D:/workspace/client-a
CLIENT_B_ROOT=D:/workspace/client-b
```

## Alternative: Single Projects Root

```
D:/workspace/
├── project-a/           # Flat structure
├── project-b/
└── project-c/
```

Choose grouped (by client) or flat based on your preference.
