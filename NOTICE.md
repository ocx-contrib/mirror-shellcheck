# NOTICE

This repository packages and redistributes upstream [ShellCheck](https://github.com/koalaman/shellcheck).

The Apache-2.0 license covers the OCX pipeline files authored here. It does
**not** cover upstream-derived assets — the ShellCheck binaries published to
`ocx.sh/shellcheck` (GPL-3.0, Vidar Holen) and the ShellCheck logo
(upstream trademark, used for catalog identification under nominative-fair-use).

## Corresponding Source (GPL-3.0)

The ShellCheck binaries redistributed here are licensed GPL-3.0. The complete
Corresponding Source (including build scripts) for every mirrored version is the
upstream tagged tree, offered at the same place as the binaries under GPLv3
§6(d):

- Version `X.Y.Z` → tag `vX.Y.Z` →
  <https://github.com/koalaman/shellcheck/releases/tag/vX.Y.Z>
- Or clone and check out the exact tag:

  ```bash
  git clone https://github.com/koalaman/shellcheck
  git -C shellcheck checkout vX.Y.Z   # X.Y.Z = the ocx.sh/shellcheck version
  ```

No additional restrictions are imposed beyond GPL-3.0.
