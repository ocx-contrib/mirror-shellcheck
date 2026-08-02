# mirror-shellcheck

OCX mirror for [ShellCheck](https://github.com/koalaman/shellcheck). One
repository, one spec directory per package.

| Package | Spec | Publishes to | Announced as | Upstream SPDX |
|---|---|---|---|---|
| [ShellCheck](https://github.com/koalaman/shellcheck) | [`shellcheck/mirror.yml`](shellcheck/mirror.yml) | `ghcr.io/ocx-contrib/shellcheck/shellcheck` | `ocx.sh/shellcheck/shellcheck` | `GPL-3.0-or-later` |

Each upstream release is discovered, re-bundled, smoke-tested per
`(version, platform)` and only then pushed with cascade tags, after which the
result is announced into the OCX index.

> This repository previously published the same upstream to the flat coordinate
> `ocx.sh/shellcheck`. `shellcheck/shellcheck` is the grouped successor —
> `koalaman` is a personal handle, so the tool names itself.

## Layout

```
mirror-base.yml         repo-wide policy every spec inherits via `extends:`
shellcheck/
├── mirror.yml          the spec — never at the repo root
├── metadata.json       bundle interface
├── CATALOG.md          → ocx package describe
├── logo.png            describe asset (upstream ships no vector mark)
└── tests/smoke.star    Starlark smoke test
```

`LICENSE` and `NOTICE.md` are shared at the root. Logos are **not** — each
package carries its own, because a repo-root `logo.*` sits in no workflow's
`paths:` filter, so replacing it would publish nothing until some unrelated
edit happened to fire.

⚠️ `extends:` is a **shallow** merge of top-level keys. A spec that restates
`platforms:` to change one runner drops every `containers:` entry with it, and
nothing reds — the legs simply stop existing, and every `os.features` claim
goes back to being asserted rather than verified. Restate a block in full or
not at all.

## Platforms

`shellcheck` publishes five platform entries: both Linux arches, both macOS
arches, and `windows/amd64`. Upstream ships **one Linux build per arch** — the
`.tar.gz`/`.tar.xz` pair is a compression split of the same binary, not a
gnu/musl split — and both are **fully static**: no `PT_INTERP`, no `DT_NEEDED`.
`os.features` states what an artifact requires *of the host*, so both Linux
keys are **bare**: tagging them `+libc.musl` would be a false requirement that
hid them from every glibc host. The `alpine:3.20` container leg in
`mirror-base.yml` is what turns that claim into evidence; the measurement
itself is recorded above the `assets:` block in `shellcheck/mirror.yml`.

There is **no `windows/arm64`**: upstream publishes a single, arch-less
`shellcheck-vX.Y.Z.zip` whose payload is `PE32+ … x86-64`. `linux.armv6hf` and
`linux.riscv64` are published upstream but have no GitHub Actions runner.

## Editing

| File | Edit | Regenerate after |
|------|------|------------------|
| `mirror-base.yml`, `shellcheck/mirror.yml` | hand | yes — see below |
| `shellcheck/{metadata.json,CATALOG.md,logo.png}` | hand | — |
| `shellcheck/tests/smoke.star` | hand | — |
| `.github/workflows/*.yml` | **generated — never hand-edit** | re-run when a spec changes |

```bash
ocx-mirror package pipeline generate ci --spec shellcheck/mirror.yml
```

**Name every spec.** `--spec` *appends* rather than replaces, so a command
naming a subset silently stops rendering the rest while staying green — and the
drift guard reds on a generated workflow the current spec set no longer
produces.

`verify-generated.yml` exits 65 on drift. If a generated workflow is wrong, the
spec or the renderer template is wrong — fix it there and regenerate.

Run `direnv allow` once to put the pinned toolchain on `PATH`, and invoke
`ocx-mirror` directly — never `ocx run -- ocx-mirror`, which pins
`OCX_BINARY_PIN` to the bootstrap `ocx` and false-reds the nested push.

## The binaries claim

`shellcheck/metadata.json` declares `"binaries": ["shellcheck"]` — the single
executable on every platform, `shellcheck.exe` on Windows.

`mirror-base.yml` sets `bin_scan: off`, and that is forced rather than
preferred. The scan needs a PATH entry pointing at a `${installPath}/<subdir>`;
ShellCheck's archives put the executable at the **content root**, so PATH is a
bare `${installPath}`. `bin_scan: verify` fails spec load on that (exit 65 —
"the verification would inspect no file and pass green whatever the archive
contains") and `auto` validates while scanning nothing, which is worse. The
list is therefore frozen by hand. A future package here that ships a `bin/`
subdirectory should override `bin_scan: verify` in its own spec.

## Required secrets

| Secret | Use |
|--------|-----|
| `OCX_ANNOUNCE_TOKEN` | opens the index pull request from the `ocx-contrib/index` fork |
| `OCX_MIRROR_DISCORD_HOOK` | notify-stage Discord webhook URL |

(Inherited from the `ocx-contrib` org with visibility ALL. GHCR pushes use the
run's own `GITHUB_TOKEN` — no registry secret needed.)

## License

Apache-2.0 — see [`LICENSE`](LICENSE). The mirrored ShellCheck binaries are
**GPL-3.0-or-later**; [`NOTICE.md`](NOTICE.md) records the Corresponding Source
conveyance that licence requires.
