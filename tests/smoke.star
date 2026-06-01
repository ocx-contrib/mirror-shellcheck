# tests/smoke.star — stable across upstream releases.
# ShellCheck is a pure analysis CLI (PATH-only env); Tiers 1-3 are its full contract.
TOOL = "shellcheck.exe" if ocx.target_platform.os == ocx.os.Windows else "shellcheck"

# Tier 1 + 2: liveness on the composed PATH + version shape (never the vendor banner).
r = ocx.run(TOOL, "--version")
expect.ok(r)
expect.matches(r.stdout, r"\d+\.\d+\.\d+")

# Tier 3: functional behavior on hermetic input. A clean script lints with exit 0.
ocx.write_file("clean.sh", "#!/usr/bin/env bash\necho hello\n")
expect.ok(ocx.run(TOOL, "clean.sh"))

# Tier 3: a script with an unassigned variable trips a STABLE rule ID, not prose.
# shellcheck exits 1 on findings; assert the contractual SC code, not the message.
ocx.write_file("broken.sh", "#!/usr/bin/env bash\nfoo=bar\necho $bar\n")
r = ocx.run(TOOL, "broken.sh")
expect.eq(r.exit_code, 1)
expect.contains(r.stdout, "SC2154")
