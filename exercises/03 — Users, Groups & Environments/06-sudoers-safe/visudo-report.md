# visudo report

Notes after reviewing the README and man pages (`visudo`, `sudoers`).

## Your notes

- **What `visudo` does:** Launches an editor with a validated copy of the sudoers rule file so dangerous syntax mistakes are rejected before sudo would load a broken policy.

- **Why sudoers syntax matters:** One malformed stanza line can revoke all privilege escalation—or accidentally grant unrestricted root—depending on parser behavior and sudo version.

- **What breaks if sudoers is edited badly (give one concrete symptom):** `sudo` rejects the file at startup with a syntax error and no user can escalate until an admin repairs it from rescue mode.
