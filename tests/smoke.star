r_version = ocx.run("shellcheck", "--version")
expect.ok(r_version)
expect.eq(r_version.exit_code, 0)
expect.contains(r_version.stdout, "ShellCheck")

ocx.write_file("clean.sh", "#!/usr/bin/env bash\necho hello\n")
r_clean = ocx.run("shellcheck", "clean.sh")
expect.ok(r_clean)
expect.eq(r_clean.exit_code, 0)

ocx.write_file("broken.sh", "#!/usr/bin/env bash\nfoo=bar\necho $bar\n")
r_broken = ocx.run("shellcheck", "broken.sh")
expect.eq(r_broken.exit_code, 1)
expect.contains(r_broken.stdout, "SC2154")
