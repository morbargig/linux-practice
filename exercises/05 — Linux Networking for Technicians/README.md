# Lesson 05 – Linux Networking for Technicians

In this lesson, you will practice how a Linux technician checks IP addresses, tests connectivity, checks DNS, finds open ports, reviews routing, and performs basic firewall troubleshooting.

## Exercises

| # | Exercise | What you learn |
|---|----------|----------------|
| 01 | IP and Interfaces | Find IP, MAC, and interface state |
| 02 | Ping and Connectivity | Test localhost, gateway, internet, and DNS connectivity |
| 03 | DNS and Name Resolution | Check DNS servers and name lookup |
| 04 | Ports and Services | Check if a service is listening on a port |
| 05 | Routing and Gateway | Find the default route and gateway |
| 06 | Firewall Basics | Check UFW safely |
| 07 | Network Troubleshooting | Follow a full troubleshooting flow |

## Command reference

| Command | Used for | Learn more |
|---------|----------|------------|
| ip | Show IP addresses, interfaces, and routes | https://man7.org/linux/man-pages/man8/ip.8.html |
| hostname | Show system name and IP addresses | https://man7.org/linux/man-pages/man1/hostname.1.html |
| ping | Test network connectivity | https://man7.org/linux/man-pages/man8/ping.8.html |
| curl | Test HTTP services from terminal | https://curl.se/docs/manpage.html |
| nslookup | Test DNS lookup | https://manpages.debian.org/bookworm/dnsutils/nslookup.1.en.html |
| dig | Advanced DNS lookup | https://manpages.debian.org/bookworm/dnsutils/dig.1.en.html |
| ss | Show listening ports and sockets | https://man7.org/linux/man-pages/man8/ss.8.html |
| ufw | Manage Ubuntu firewall | https://manpages.ubuntu.com/manpages/jammy/en/man8/ufw.8.html |
| resolv.conf | DNS resolver configuration | https://man7.org/linux/man-pages/man5/resolv.conf.5.html |
| tracepath | Trace network path | https://man7.org/linux/man-pages/man8/tracepath.8.html |

## Troubleshooting checklist

1. Do I have an IP address?
2. Is the interface UP?
3. Can I ping 127.0.0.1?
4. Can I ping the default gateway?
5. Can I ping 8.8.8.8?
6. Can I resolve google.com?
7. Is the needed port listening?
8. Is the firewall blocking traffic?

## How to run each exercise

```bash
cd /path/to/the/practice-folder
chmod +x task.sh test.sh   # firewall still uses test.sh only to enforce completed stubs
./task.sh
./test.sh                  # 06-firewall-basics: checks placeholders; UFW itself stays manual
```

Some tests may show **WARN** if the internet is blocked or a tool is not installed. That is normal in restricted lab environments.

## Prerequisites

- Lessons 01–04 completed (recommended)
- Comfort running commands in a terminal

## What you will learn

- Read interface and address information with `ip` and `hostname`
- Step through connectivity checks with `ping`
- Inspect DNS configuration and lookups
- See listening ports with `ss` and probe HTTP with `curl`
- Interpret default routes and gateways
- Discuss UFW without changing rules automatically
- Combine checks into a simple troubleshooting report
