# Project Directory Structure

Recommended structure for organizing your actual projects.

## Workspace Location

Choose a dedicated workspace directory separate from your OS drive:

```
~/workspace/                # or "code", "projects", your-choice
├── client-a/               # First client/company
│   ├── project-a/
│   │   ├── .claude/        # Project-specific CLAUDE.md
│   │   ├── docs/           # Project docs (if large)
│   │   └── src/
│   └── project-b/
│       └── ...
├── client-b/               # Second client/company
│   └── project-a/
└── personal/               # Personal projects
    └── experiments/
```

**Windows:** Use `D:/workspace/` (separate from OS drive `C:/`)
**macOS/Linux:** Use `~/workspace/` or `~/projects/`

## Why This Structure?

| Benefit | Explanation |
|---------|-------------|
| **Separate from OS** | Workspace won't affect OS if issues occur |
| **Easy backup** | Backup entire workspace folder |
| **Organized** | Clear separation between clients/projects |
| **Scalable** | Easy to add new clients or projects |

## Env Variables Example

Update your `.env` to match:

```bash
WORKSPACE_ROOT=~/workspace
CLIENT_A_ROOT=~/workspace/client-a
CLIENT_B_ROOT=~/workspace/client-b
```

## Alternative: Single Projects Root

```
~/workspace/
├── project-a/           # Flat structure
├── project-b/
└── project-c/
```

Choose grouped (by client) or flat based on your preference.
