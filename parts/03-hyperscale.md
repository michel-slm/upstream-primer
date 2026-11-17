## Hyperscale

**TL;DR:** the CentOS Hyperscale SIG builds faster-moving versions of
core packages (systemd, selinux-policy, kpatch and others) and policy
alternatives for CentOS Stream, on public CentOS infrastructure. Its
packages are drop-in replacements for the stock ones. Anyone can
contribute through merge requests.

- **Docs:** <https://sigs.centos.org/hyperscale/>
- **What's in scope:** the
  [charter](https://sigs.centos.org/hyperscale/sig/charter/). In short,
  what can't go into CentOS Stream, Fedora or EPEL directly. New
  packages go to Fedora and EPEL instead, and bug fixes to the
  package's upstream.
- **Using it:** `dnf install centos-release-hyperscale` (pulls in EPEL;
  enable CRB too). See
  [Repositories](https://sigs.centos.org/hyperscale/content/repositories/main/)
  for what's in `main` and the other repositories.
- **Reporting a problem:** open an issue on the
  [SIG tracker](https://gitlab.com/CentOS/Hyperscale/tracker/-/issues),
  or on the package's project under
  [CentOS/Hyperscale/rpms](https://gitlab.com/CentOS/Hyperscale/rpms).
- **Changing a package:** fork it under
  [CentOS/Hyperscale/rpms](https://gitlab.com/CentOS/Hyperscale/rpms)
  and open a merge request against its SIG branch (`c<N>s-hs` for the
  main repository). See
  [Contributing packages](https://sigs.centos.org/hyperscale/contributing/packaging/)
  and the [branch names](https://sigs.centos.org/hyperscale/policies/branches/).
- **Adding a package:** file an issue on the
  [tracker](https://gitlab.com/CentOS/Hyperscale/tracker/-/issues)
  saying why it belongs in Hyperscale rather than in Fedora or EPEL.
  sandogasa's `hs-intake` shows how a Fedora package differs from the
  one it would replace; see [Tools](#tools).
- **Talking to the SIG:** the Matrix room
  [#centos-hyperscale:fedoraproject.org](https://matrix.to/#/#centos-hyperscale:fedoraproject.org)
  and the [meetings](https://sigs.centos.org/hyperscale/communication/meetings/),
  which are open to anyone.
- **Joining:** regular contributors can become SIG members, which lets
  them build in CBS; see
  [Membership](https://sigs.centos.org/hyperscale/sig/membership/).
