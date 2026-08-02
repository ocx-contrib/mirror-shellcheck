# NOTICE

This repository packages and redistributes upstream
[ShellCheck](https://github.com/koalaman/shellcheck). The Apache-2.0 license in
[`LICENSE`](LICENSE) covers the OCX pipeline files authored here. It does
**not** cover any upstream-derived asset — each package's redistributed bytes
carry their own license, recorded below.

Each package's logo is reproduced for catalog identification only, under
nominative fair use. The marks remain the property of their respective owners
and no endorsement is implied.

| Package | GHCR path | Upstream SPDX |
|---|---|---|
| `shellcheck` | `ghcr.io/ocx-contrib/shellcheck/shellcheck` | `GPL-3.0-or-later` |

---

## `shellcheck`

Upstream: <https://github.com/koalaman/shellcheck>
Published to `ghcr.io/ocx-contrib/shellcheck/shellcheck`.

| Component | SPDX | Holder |
|---|---|---|
| ShellCheck (`shellcheck`) | **GPL-3.0-or-later** | Vidar 'koala_man' Holen and contributors, 2012–2019 |

`gh api repos/koalaman/shellcheck/license` reports the deprecated umbrella id
`GPL-3.0`; the per-file headers disambiguate it — `shellcheck.hs` reads "either
version 3 of the License, or (at your option) any later version" — so the
precise expression is **GPL-3.0-or-later**.

Strong copyleft. Redistribution of the compiled binary is granted provided the
Corresponding Source is conveyed (below) and the license text accompanies the
binary — upstream ships `LICENSE.txt` inside every release archive, republished
unmodified inside the OCX bundle.

The ShellCheck name and logo are the property of the upstream project.

### Corresponding Source (GPLv3 §6)

The complete Corresponding Source — the exact source *and* build scripts — for
every mirrored version is the upstream tagged tree, offered from the same place
as the binaries under **GPLv3 §6(d)**:

- Version `X.Y.Z` → tag `vX.Y.Z` →
  <https://github.com/koalaman/shellcheck/releases/tag/vX.Y.Z>
- Or clone and check out the exact tag:

  ```bash
  git clone https://github.com/koalaman/shellcheck
  git -C shellcheck checkout vX.Y.Z   # X.Y.Z = the mirrored package version
  ```

Every version this mirror publishes is built by upstream from that tag and
republished byte-for-byte, so the tag *is* the Corresponding Source for the
mirrored binary. No additional restrictions are imposed beyond
GPL-3.0-or-later.

No modifications are made to any upstream artifact in this repository; they are
republished byte-for-byte inside an OCX bundle.
