# Lesson 03 – Users & Environment

## What You Should Know Before Starting
- Basic bash scripting (from Lessons 01 and 02)
- Understanding of Linux file system
- Comfortable with command line
- Basic understanding of permissions (helpful but not required)

## What You Will Learn
This lesson covers Linux user management, groups, permissions, and environment configuration:
- Identifying users and understanding UIDs/GIDs
- Reading system user and group files (`/etc/passwd`, `/etc/group`)
- Creating and managing users (`useradd`, `passwd`, `su`)
- Managing groups (`groupadd`, `usermod`)
- Understanding `sudo` and root access
- Safely configuring sudo permissions (`visudo`)
- Working with environment variables (`env`, `printenv`, `export`)
- Understanding PATH and command location (`which`, `command -v`)
- Handling environment differences (cron vs terminal)

## Exercises (10 exercises, ~2.5 hours)

1. **[01-whoami-id](01-whoami-id/)** - Identify yourself (~15 min)
   - Use `whoami` and `id` commands
   - Understand UID, GID, and groups
   - Run: `./identity.sh`

2. **[02-passwd-group-files](02-passwd-group-files/)** - Understand system users (~20 min)
   - Read `/etc/passwd` and `/etc/group`
   - Understand user/group file formats
   - Run: `./read_files.sh`

3. **[03-create-user](03-create-user/)** - Create a new user (~25 min)
   - Use `useradd` to create users
   - Set passwords with `passwd`
   - Switch users with `su`
   - **Requires sudo** - Run: `./create_user.sh`

4. **[04-groups-membership](04-groups-membership/)** - Manage groups (~25 min)
   - Create groups with `groupadd`
   - Add users to groups with `usermod -aG`
   - Verify group membership
   - **Requires sudo** - Run: `./manage_groups.sh`

5. **[05-sudo-basics](05-sudo-basics/)** - Sudo basics (~20 min)
   - Understand sudo vs root access
   - Run commands with elevated privileges
   - Check sudo logs
   - Run: `./sudo_demo.sh`

6. **[06-sudoers-safe](06-sudoers-safe/)** - Safe sudo configuration (~15 min)
   - Use `visudo` safely
   - Understand sudoers file structure
   - Learn why syntax matters
   - **Reading/understanding task** (no script)

7. **[07-env-basics](07-env-basics/)** - Environment variables (~20 min)
   - View environment variables (`env`, `printenv`)
   - Understand `USER`, `HOME`, `SHELL`, `PATH`
   - Compare environments between users
   - Run: `./env_vars.sh`

8. **[08-path-and-which](08-path-and-which/)** - PATH debugging (~25 min)
   - Use `which` and `command -v`
   - Understand how Linux finds commands
   - Modify PATH temporarily
   - Run: `./path_debug.sh`

9. **[09-env-in-scripts](09-env-in-scripts/)** - Environment in scripts (~20 min)
   - Understand `export` vs local variables
   - Make variables available to child processes
   - Run: `./showenv.sh`

10. **[10-cron-env-gap](10-cron-env-gap/)** - Cron environment gap (~25 min)
    - Understand why scripts fail in cron
    - Fix PATH issues in cron jobs
    - Use full paths and set environment safely
    - Run: `./cron_test.sh`

## Estimated Total Time
~2.5 hours for all exercises

## Important Notes
- Exercises 3 and 4 require sudo privileges
- Some exercises involve creating users - use a test environment
- Exercise 6 is a reading/understanding task (no script to run)

## Next Steps
After completing this lesson, you'll understand Linux user management, permissions, and environment configuration - essential skills for Linux system administration and scripting.
