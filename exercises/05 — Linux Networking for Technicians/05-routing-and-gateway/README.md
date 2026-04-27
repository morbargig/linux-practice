# Exercise 05 – Routing and Gateway

## Scenario

The machine has an IP address but cannot reach the internet. Check the default route.

## Goal

Read the routing table and interpret the default gateway and outgoing interface.

## Commands to use

- `ip route`
- `ip route get 8.8.8.8`

## Tasks

- Find the default route
- Find the gateway IP
- Find the outgoing interface
- Explain why a gateway is needed (in your notes)

## What to write down

- The `default via ... dev ...` line
- Which interface would be used toward 8.8.8.8

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

- `ip-route`: https://man7.org/linux/man-pages/man8/ip-route.8.html
