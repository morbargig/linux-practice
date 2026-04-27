# Exercise 07 – Network Troubleshooting

## Scenario

The server can ping 8.8.8.8 but cannot ping google.com.

## Goal

Run a structured, read-only report that checks IP, routing, connectivity, and DNS, then state a likely cause.

## Commands to use (via the script)

Safe read-only checks such as `ip`, `ping`, and DNS tools—**no** configuration changes.

## Tasks

- Check IP information
- Check default gateway
- Ping 127.0.0.1
- Ping the gateway (if known)
- Ping 8.8.8.8
- Ping google.com
- Check DNS configuration
- Write the likely root cause (in your notes)

## What to write down

- Which layer failed (if any): localhost, gateway, internet IP, DNS name
- Your best one-sentence hypothesis

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
- `ping`: https://man7.org/linux/man-pages/man8/ping.8.html
- `nslookup`: https://manpages.debian.org/bookworm/dnsutils/nslookup.1.en.html
- `dig`: https://manpages.debian.org/bookworm/dnsutils/dig.1.en.html
- `resolv.conf`: https://man7.org/linux/man-pages/man5/resolv.conf.5.html
- `tracepath`: https://man7.org/linux/man-pages/man8/tracepath.8.html
