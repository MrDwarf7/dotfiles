# Tips & Tricks for (Open)SSH on Windows

# Passwordless Entry

Requires edits to the file in either:

> C:\windows\system32\openssh\sshd_config
> or

> $env:USERPROFILE\scoop\apps\openssh\current\sshd_config_default

There is a key at the bottom that will need to be uncommented:

```sshconfig
Match Group administrators
       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```

This should allow for administrators to login via authorized keys.

# Ensure the service is started

```powershell
# Script coming soon
```

Both `OpenSSH SSH Server` and `OpenSSH Authentication Agent` in services.msc
and ensuring via Task Manager the blow are running:

Both

- ssh-agent.exe
- sshd.exe

# Configuring the default shell

There are two ways to do this depending on various things
( Access levels - though admin is likely required for both), preference &
(Open)SSH install method(s).

## One:

Via the registry & addition of a registry key.

This requires the **_FULL_** absoloute path to the binary you wish to use.

```powershell
# You could probably do some fancy Env variable expansion stuff here
New-ItemPropery -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\absoloute\path\to\your\shell.exe"
```
