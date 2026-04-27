# Exercise 02 – Ping and Connectivity

## Scenario

A student says the internet is down. Test connectivity step by step.

## Goal

Use `ping` and `ip route` to isolate where connectivity breaks—local stack, LAN, internet, or DNS.

## Commands to use

- `ping 127.0.0.1`
- `ping 8.8.8.8`
- `ping google.com`
- `ip route`

## Tasks

- Ping localhost
- Find the default gateway
- Ping the gateway
- Ping 8.8.8.8
- Ping google.com
- Explain where the problem might be (in your notes)

## What to write down

- Which pings succeeded and which failed
- Your default gateway IP, if any
- Whether failure looks like “no LAN,” “no internet,” or “DNS only”

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

- `ping`: https://man7.org/linux/man-pages/man8/ping.8.html
- `ip`: https://man7.org/linux/man-pages/man8/ip.8.html
