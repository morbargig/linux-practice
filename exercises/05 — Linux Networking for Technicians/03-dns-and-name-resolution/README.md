# Exercise 03 – DNS and Name Resolution

## Scenario

The machine can reach IP addresses but websites by name do not work.

## Goal

Inspect resolver configuration and run safe DNS lookups with `nslookup` or `dig`.

## Commands to use

- `cat /etc/resolv.conf`
- `nslookup google.com`
- `dig google.com`

## Tasks

- Show DNS servers from resolver config
- Test `google.com` with `nslookup` or `dig`
- Explain what DNS does (in your notes)

## What to write down

- Nameserver lines from `/etc/resolv.conf`
- Whether lookup succeeded and which tool you used

## How to run the script

```bash
chmod +x task.sh
./task.sh
```

## How to run the test

```bash
chmod +x test.sh
./test.sh
```

## Docs

- `nslookup`: https://manpages.debian.org/bookworm/dnsutils/nslookup.1.en.html
- `dig`: https://manpages.debian.org/bookworm/dnsutils/dig.1.en.html
- `resolv.conf`: https://man7.org/linux/man-pages/man5/resolv.conf.5.html
