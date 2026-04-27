# Exercise 06 – Firewall Basics

## Scenario

A local service is running, but firewall rules may block access.

## Goal

Learn how to **inspect** UFW and which commands change rules—without letting a practice script modify your system automatically.

## Commands to use (you run these manually when appropriate)

- `sudo ufw status verbose`
- `sudo ufw allow 8080`
- `sudo ufw deny 8080`
- `sudo ufw delete allow 8080`
- `sudo ufw delete deny 8080`

## Tasks

- Check firewall status (with care and instructor guidance)
- Read existing rules
- In a lab only, allow port 8080, recheck, then delete the test rule
- Explain what changed (in your notes)

## What to write down

- Whether UFW is active
- Example rules you saw
- Why `sudo` is required

## How to run the script

```bash
chmod +x task.sh
./task.sh
```

This practice has **no** `test.sh` because firewall checks can require elevated privileges and should not be automated here.

## Docs

- `ufw`: https://manpages.ubuntu.com/manpages/jammy/en/man8/ufw.8.html
- `sudo`: https://man7.org/linux/man-pages/man8/sudo.8.html
