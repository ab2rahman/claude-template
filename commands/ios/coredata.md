---
name: "ios:coredata"
description: "Set up Core Data stack and create a new entity"
category: "ios"
---

# /ios:coredata

Scaffold Core Data stack configuration and create a new managed object entity.

## Usage

```
/ios:coredata [entity-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[entity-name]` | Yes | Name of the Core Data entity (PascalCase, e.g. `User`, `Product`) |

## Examples

```bash
/ios:coredata User
/ios:coredata Product
/ios:coredata OrderItem
```

## What It Does

1. Creates or updates the `.xcdatamodeld` model file
2. Sets up `PersistenceController` for Core Data stack initialization
3. Defines the entity with common attribute types (String, Int, Date, etc.)
4. Generates `NSManagedObject` subclass or uses Codegen
5. Creates a repository pattern for CRUD operations on the entity
6. Injects the managed object context into the SwiftUI environment

## Connected Components

- **Agent:** `agent:ios-dev-agent`

## Notes

- Uses `@AppStorage` and `@Environment(\.managedObjectContext)` in views
- Supports CloudKit sync if iCloud capability is enabled
- Prefer SwiftData for iOS 17+ projects
