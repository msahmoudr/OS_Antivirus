# Simple Antivirus Daemon

This is my Lab 2 project. It's a simple antivirus written in Bash.
It watches a folder, finds files that look dangerous, and moves them
to a quarantine folder. There is also a small tool to review the
quarantined files.

---

## What it does

- Watches a folder over and over (every few seconds).
- Compares snapshots to see if anything changed.
- If something changed, it scans the folder.
- A file is "bad" if:
  - its extension is one of: `.exe`, `.bat`, `.vbs`, `.scr`, `.ps1`, OR
  - its content contains one of: `virus`, `trojan`, `malware`, `worm`, `ransomware`
    (uppercase or lowercase doesn't matter).
- Bad files are copied into a quarantine folder and removed from the original folder.
- A separate tool lets you pick a quarantined file and either:
  - restore it (it was a mistake), or
  - delete it forever (it really was bad), or
  - leave it alone.

---

## Files in this project
