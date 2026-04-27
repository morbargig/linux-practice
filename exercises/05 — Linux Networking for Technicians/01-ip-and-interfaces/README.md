# Exercise 01 – IP and Interfaces

## Scenario

A workstation cannot connect to the network. First, collect basic interface information.

## Goal

Learn to list host identity, addresses, interfaces, and the default route using read-only commands.

## Commands to use

- `ip a`
- `hostname -I`

## Tasks

- Find the loopback interface
- Find the main network interface
- Find IPv4 address
- Find MAC address
- Check if the interface is UP or DOWN

## What to write down

- Which interface carries your main IPv4 address
- The MAC address of that interface
- Whether the default route exists and which gateway it uses

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

- `ip`: https://man7.org/linux/man-pages/man8/ip.8.html
- `hostname`: https://man7.org/linux/man-pages/man1/hostname.1.html
