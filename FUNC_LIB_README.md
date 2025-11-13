# funcLib.sh - Function Library Reference

This document lists the functions available in `funcLib.sh`, with brief descriptions and usage examples. The file was generated from the current `funcLib.sh` content in this repository.

---

## ENV / Helpers

- print_scriptdir
  - Description: Print the directory portion of the script path (where the script lives).
  - Usage: `print_scriptdir`
  - Example: `DIR=$(print_scriptdir)`

---

## Check functions

- check_var_set
  - Description: Returns success (0) if the provided value is non-empty.
  - Usage: `if check_var_set "$VAR"; then echo "set"; fi`

- check_var_not_set
  - Description: Returns success (0) if the provided value is empty.
  - Usage: `if check_var_not_set "$VAR"; then echo "not set"; fi`

- check_file_exists
  - Description: Returns success if the argument is a regular file.
  - Usage: `if check_file_exists "/etc/passwd"; then echo "exists"; fi`

- check_dir_exists
  - Description: Returns success if the argument is a directory.
  - Usage: `if check_dir_exists "/tmp"; then echo "dir exists"; fi`

- check_readable
  - Description: Returns success if the file is readable by the current user.
  - Usage: `if check_readable "./file.txt"; then cat ./file.txt; fi`

- check_writable
  - Description: Returns success if the file is writable by the current user.
  - Usage: `if check_writable "./file.txt"; then echo hi > ./file.txt; fi`

- check_command_exists
  - Description: Verify a command exists in PATH. If missing, prints a warning via `echoc`.
  - Usage: `check_command_exists git`
  - Example: `check_command_exists curl || echo "curl not found"`

- check_alias_exists
  - Description: Returns success if the given name is an alias.
  - Usage: `if check_alias_exists ll; then echo "alias exists"; fi`

- check_function_exists
  - Description: Returns success if the given name is a shell function.
  - Usage: `if check_function_exists myfunc; then echo "function exists"; fi`

- check_file_contains_string
  - Description: Return success if a file contains the provided string.
  - Usage: `if check_file_contains_string /etc/hosts example.com; then echo present; fi`

---

## ECHOC & PRINT functions

- echoc
  - Description: Print colored output according to a color code and text.
  - Usage: `echoc grn "All good"`

- print_error
  - Description: Print a bold red error message.
  - Usage: `print_error "Failed to do X"`

- print_warning
  - Description: Print a bold yellow warning message.
  - Usage: `print_warning "Be careful"`

- print_info
  - Description: Print a bold cyan info message.
  - Usage: `print_info "Starting..."`

- print_success
  - Description: Print a bold green success message.
  - Usage: `print_success "Done"`

- print_yorn
  - Description: Prompt a yes/no question and execute given callbacks for Y or N.
  - Usage: `print_yorn "Continue?" "echo yes" "echo no"`

- print_question_response
  - Description: Prompt for a question with optional default; prints the result.
  - Usage: `VAR=$(print_question_response "Directory name" defaultDir)`

- print_continue
  - Description: Pause and wait for the user to press Enter (or cancel with Ctrl+C).
  - Usage: `print_continue`

- print_break
  - Description: Emit a visual break (blank lines).
  - Usage: `print_break`

- print_process
  - Description: Run a callback and print the label, then show OK/FAIL status.
  - Usage: `print_process "Running Update" "sudo apt update"`

- __print_process_ok
  - Description: Internal helper to print OK status.

- __print_process_fail
  - Description: Internal helper to print FAIL status.

- print_thin_line
  - Description: Print a thin separator line.
  - Usage: `print_thin_line`

- print_med_line
  - Description: Print a medium separator line.
  - Usage: `print_med_line`

- print_header
  - Description: Print a decorated header block with provided text.
  - Usage: `print_header "My Title"`

- print_string_if_missing
  - Description: Append a string to a file if missing (note: uses FILE2CHECK variable in original code — double-check before using).
  - Usage: `print_string_if_missing "export PATH=..." /etc/profile`

---

## LOG / DEBUG functions

- log
  - Description: Append a timestamped message to a logfile.
  - Usage: `log "message" /var/log/myscript.log`

- log_info
  - Description: Write an informational log line to stderr with script name and timestamp.
  - Usage: `log_info "step" "detail"`

- debug
  - Description: Print debug markers and run a provided command (used for development).
  - Usage: `debug "ls -l"`

- killme
  - Description: Print error decorations and exit the script.
  - Usage: `killme "Fatal error message"`

---

## APT functions

- _apt_get_install
  - Description: Internal helper to install packages quietly using apt-get and show spinner.
  - Usage: `_apt_get_install package_name`

- apt_install
  - Description: Install packages and print progress/success messages.
  - Usage: `apt_install git curl`

- apt_install_list
  - Description: Install a list of packages one-by-one and print each name.
  - Usage: `apt_install_list pkg1 pkg2 pkg3`

---

## PATH / ENV functions

- path_file_name
  - Description: Return the filename (with extension) from a path.
  - Usage: `name=$(path_file_name /path/to/file.txt)`

- path_file_basename
  - Description: Return the filename without extension.
  - Usage: `base=$(path_file_basename /path/to/file.txt)`

- path_file_ext
  - Description: Return the file extension.
  - Usage: `ext=$(path_file_ext /path/to/file.txt)`

- path_dirname
  - Description: Return the directory portion of a path (POSIX-like).
  - Usage: `dir=$(path_dirname /path/to/file.txt)`

- path_full
  - Description: Return the absolute path for a file or directory.
  - Usage: `abs=$(path_full ./../dir2/file.ext)`

---

## File / Dir functions

- file_tmp_file
  - Description: Create a tmp filename (not guaranteed to be created) and register trap to remove it on exit.
  - Usage: `tmp=$(file_tmp_file)`

- file_tmp_dir
  - Description: Create a temporary directory; optional trap to clean it up.
  - Usage: `tmpdir=$(file_tmp_dir tmpPrefix yes)`

- file_backup
  - Description: Copy a file to a timestamped backup if it exists.
  - Usage: `file_backup /etc/myconf`

---

## User config functions

- user_run_as_user
  - Description: Execute a command as a different user (root or other) using sudo.
  - Usage: `user_run_as_user someuser "whoami; pwd"`

- run_as_user
  - Description: Run provided commands as a specific user (login shell).
  - Usage: `run_as_user someuser "echo $HOME; whoami"`

- config_sudo_no_passwd
  - Description: Create a sudoers.d entry allowing the user to sudo without password.
  - Usage: `config_sudo_no_passwd username`

- user_add_user
  - Description: Add a system user, set password, add to sudo and copy ssh keys.
  - Usage: `user_add_user newuser mypassword`

---

## /etc helpers

- etc_sshd_conf
  - Description: Append permissive SSH settings to system sshd and import GitHub keys via ssh-import-id-gh.
  - Usage: `etc_sshd_conf`

---

## Decorative utils

- print_center
  - Description: Center a string using current terminal width.
  - Usage: `print_center "Title"`

- spinner
  - Description: Show a spinner while a background process (pid) runs.
  - Usage:
    - `longcmd &`
    - `spinner $!`

---

Notes:

- This README was generated from the existing `funcLib.sh`. Some functions reference variables or other helper functions (for example, `file::dirname` in `path_full` and `FILE2CHECK` in `print_string_if_missing`) that are not defined in this single file; review interactions before using in isolation.

---
