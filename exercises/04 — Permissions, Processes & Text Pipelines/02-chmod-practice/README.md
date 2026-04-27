# Exercise 02 – Modify Permissions (chmod)

## Goal
Learn to change file permissions using `chmod` with numeric and symbolic modes.

## Tasks
1. Use numeric mode to set specific permissions
2. Use symbolic mode to modify permissions
3. Fix broken script permissions
4. Practice common permission scenarios

## Deliverable
Create `chmod_results.txt` with:
- Commands used
- Before and after permission changes
- Explanation of numeric vs symbolic modes

## Hints
- Numeric mode: `chmod 755 file` (owner: rwx, group: rx, others: rx)
- Symbolic mode: `chmod u+x file` (add execute for user)
- Common permissions: 755 (executable), 644 (readable), 600 (private)

## Docs
- `chmod` command: https://man7.org/linux/man-pages/man1/chmod.1.html
