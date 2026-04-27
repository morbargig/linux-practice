# Exercise 04 – Ports and Services

## Scenario

You started a local web server, but you need to verify if port 8080 is listening.

## Goal

Use `ss` to see listeners and `curl` to probe HTTP on localhost when available.

## Commands to use

- `python3 -m http.server 8080` (in a separate terminal)
- `ss -tulpen`
- `curl localhost:8080`

## Tasks

- Start the server in one terminal
- Run `task.sh` in another terminal
- Check if port 8080 is listening
- Test with `curl` when possible

## What to write down

- Whether `ss` shows `8080` in a LISTEN state
- What `curl` returned (status or error)

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

- `ss`: https://man7.org/linux/man-pages/man8/ss.8.html
- `curl`: https://curl.se/docs/manpage.html
- Python `http.server`: https://docs.python.org/3/library/http.server.html
