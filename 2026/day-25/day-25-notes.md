## Git Revert

git revert creates a new commit that undoes a previous commit.

Example:

git revert cd8500f

This does not remove the original commit from history.
Instead Git adds a new commit that reverses the changes.

This makes revert safe for shared branches.
| Feature | git reset | git revert |
|------|------|------|
| What it does | Moves branch pointer backward | Creates new commit that undoes changes |
| Removes commit from history | Yes | No |
| Safe for shared branches | No | Yes |
| Used when | Local mistakes | Fixing commits in shared repositories |



