<!--
Sources last checked: the EPEL docs (forge.fedoraproject.org/epel/docs
at e7f0bf8, 2026-10-19), the package maintainer docs (2026-08-24), the
Fedora Council docs, quick-docs, packit.dev (2026-11-16) and COPR's
doc/ (fedora-copr/copr at 3b57ec6e4, 2026-11-13).
-->

## Fedora and EPEL at a glance

- Fedora is the upstream of CentOS Stream, which is the upstream of
  RHEL. EPEL (Extra
  Packages for Enterprise Linux) is Fedora's add-on repository of
  packages for RHEL and CentOS Stream (EPEL 8, 9 and 10), built from
  the same package sources and maintained by Fedora packagers
- Package sources live in Fedora dist-git,
  https://src.fedoraproject.org/rpms/<source package>: one git repo
  per source package, one branch per release (`rawhide`, `f43`,
  `epel9`, `epel10`, ...)
- Bugs against packages are filed in Red Hat Bugzilla, product
  `Fedora` or `Fedora EPEL`. Fedora's own projects (docs, infra,
  release engineering) use Fedora Forge,
  https://forge.fedoraproject.org
- Builds go through Koji and updates through Bodhi
  (https://bodhi.fedoraproject.org), where they wait in a testing
  repository before going stable
- Everything here needs a Fedora account:
  https://accounts.fedoraproject.org
- Start page: https://docs.fedoraproject.org/en-US/epel/ and
  https://docs.fedoraproject.org/en-US/package-maintainers/

## Reporting a problem

- A bug in a package (crash, missing feature, build error): file it
  in Bugzilla against the source package (find the source package
  name on https://packages.fedoraproject.org). How to:
  https://docs.fedoraproject.org/en-US/quick-docs/bugzilla-file-a-bug/
- A problem with Fedora infrastructure (build system down, failing
  services): https://forge.fedoraproject.org/infra/tickets/issues
- Questions about policy or process: the devel mailing list,
  https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/,
  or epel-devel for EPEL
- If the bug is in the software itself rather than in how Fedora
  packages it, report it to the upstream project too, and link the
  two reports
- Details: https://docs.fedoraproject.org/en-US/package-maintainers/Reporting_Issues/

## Fixing a package yourself: dist-git pull requests

- Anyone with a Fedora account can fork a package's dist-git repo and
  open a pull request: a version bump, a backported fix, a missing
  build option. No packager status is needed; the package's
  maintainers review and merge it
- Typical flow: `fedpkg clone --anonymous <package>`, `fedpkg fork`,
  change the spec, test with `fedpkg --release rawhide mockbuild`,
  push to the fork, open the PR on src.fedoraproject.org. Each PR
  gets a Koji scratch build and an installability test
- Only packagers can upload a new source tarball. For a version
  bump, run `fedpkg new-sources --offline <tarball>`, which only
  updates the checksum, and make sure the spec's `Source` URL points
  at the tarball; the maintainer uploads it when merging
- After merging, the maintainer builds and ships the update. Ask in
  the PR if you need it in other branches (a Fedora release, EPEL).
  Many maintainers are volunteers, so a review can take days or
  weeks; the guide links the process for unresponsive maintainers
- Guide: https://docs.fedoraproject.org/en-US/package-maintainers/Pull_Request_Guide/

## Getting a package into EPEL

- The package should be in Fedora first. If it isn't, it has to be
  packaged and reviewed there (see "Becoming a packager")
- EPEL-only packages are rare exceptions. **Ask on epel-devel before
  starting one.** The two usual cases:
  - Subpackages RHEL builds but doesn't ship (often `-devel`), or
    doesn't build at all, provided by a separate `<package>-epel`
    source package. No formal package review is required, but the
    policy recommends having someone look over the spec, and adding
    epel-packagers-sig as co-maintainer. Such a package has to be
    maintained as long as RHEL lacks the subpackage, kept in sync
    with the RHEL package by hand, which makes it costly to
    maintain, and is retired once RHEL ships the subpackage:
    https://docs.fedoraproject.org/en-US/epel/epel-policy-missing-sub-packages/
  - Alternate versions of a package (called compat packages; the
    Fedora naming guidelines cover them under "Multiple packages with
    the same base name"): a newer (sometimes older) version than RHEL
    ships, under its own name. They are new packages, so they go
    through package review. Normally they install alongside RHEL's
    packages; a conflict is allowed only between `-devel` packages,
    and only when it can't be avoided:
    https://docs.fedoraproject.org/en-US/epel/epel-policy/#conflicts_in_compat_packages
  - Such cases sometimes go to [Hyperscale](#hyperscale) instead,
    even where EPEL's policy would permit them
- Ask the Fedora maintainer to branch and build it for EPEL by
  filing a Bugzilla request: product `Fedora EPEL`, version `epel10`
  (or `epel9`, `epel8`), summary "Please branch and build <package>
  in epel10". One bug per EPEL major version. Offer to co-maintain
  it if you can
- No answer after a week: ask again in the bug. After two more
  weeks: write to epel-devel, or, if you are a packager offering to
  maintain it, follow the stalled-request process to get access
- Steps and templates:
  https://docs.fedoraproject.org/en-US/epel/epel-package-request/
- sandogasa's `ebranch` lists the missing dependencies and files the
  branch requests; see [Tools](#tools)
- EPEL 10 has a repository per RHEL 10 minor version: `epel10`
  builds target the leading minor version (built against CentOS
  Stream 10), `epel10.x` branches target released RHEL 10.x. For
  EPEL 10, say in the request which minor versions you need:
  https://docs.fedoraproject.org/en-US/epel/branches/
- EPEL Next (`epel9-next`) holds rebuilds of EPEL packages against
  CentOS Stream, for when Stream already has a rebase that RHEL
  doesn't yet. It is rarely needed:
  https://docs.fedoraproject.org/en-US/epel/epel-about-next/

## Testing updates: updates-testing, epel-testing, karma

- New builds wait in a testing repository (`updates-testing` for
  Fedora, `epel-testing` for EPEL) before going stable. An EPEL
  update goes stable after one week in testing or once it gets +3
  karma (positive feedback) in Bodhi
- A fleet can help most cheaply by enabling the testing repository
  on a few canary hosts (`dnf config-manager --set-enabled
  epel-testing`, or `dnf --enablerepo epel-testing upgrade` for one
  transaction) and giving feedback on the Bodhi update: +1 if it
  works, -1 with details and a bug link if it breaks something,
  which keeps the update from being pushed to stable on karma
- How to: https://docs.fedoraproject.org/en-US/epel/epel-testing/
- sandogasa's `ebranch check-update` checks an update against what
  depends on it and can give the karma; see [Tools](#tools)

## Building your own packages: COPR

- COPR (https://copr.fedorainfracloud.org) builds RPMs from a spec,
  an SRPM or a git repo into a personal repository, for Fedora, EPEL
  and CentOS Stream targets, without packager status or review.
  Useful for testing a fix or a newer version before proposing it in
  dist-git, or for software that won't meet Fedora's packaging
  guidelines
- The packaging guidelines don't apply, but the legal limits do: only
  software Fedora could distribute. No proprietary software or other
  licenses outside Fedora's allowed list, and nothing that infringes
  patents or other intellectual property, which rules out
  patent-encumbered codecs and the like. Packages that download
  proprietary content at build time are not allowed either. COPR
  repositories are public, so this covers internal-only software
  too: https://docs.copr.fedorainfracloud.org/user_documentation.html#what-i-can-build-in-copr
- COPR repositories are not part of Fedora or EPEL and come with no
  review or support promise; treat them like any third-party repo
- Docs: https://docs.copr.fedorainfracloud.org/user_documentation.html

## Teams that own an upstream project: Packit

- Packit (https://packit.dev) connects an upstream repo to Fedora:
  it can build every upstream PR in COPR, and turn each upstream
  release into dist-git PRs, Koji builds and Bodhi updates for Fedora
  and EPEL branches. A team that owns a project packaged in Fedora
  can keep the package current with little manual work. GitHub is
  the supported forge; Packit calls its GitLab support experimental
- Release automation is set up either upstream (`propose_downstream`)
  or by the package's maintainers in dist-git (`pull_from_upstream`);
  either way they have to agree, since it acts on their repo
- Docs: https://packit.dev/docs/guide and, for releases,
  https://packit.dev/docs/fedora-releases-guide

## Becoming a packager

- To maintain packages yourself (rather than file requests and PRs),
  join the `packager` group. A sponsor (an experienced packager)
  vouches for you after seeing your work: dist-git PRs to existing
  packages, reviews of other people's package submissions, or a new
  package submitted for review
- New packages go through a review in Bugzilla (the "Fedora Review
  Request" form), where a packager checks them against the packaging
  guidelines
- Guides:
  https://docs.fedoraproject.org/en-US/package-maintainers/How_to_Get_Sponsored_into_the_Packager_Group/
  and
  https://docs.fedoraproject.org/en-US/package-maintainers/New_Package_Process_for_New_Contributors/
- Packaging guidelines:
  https://docs.fedoraproject.org/en-US/packaging-guidelines/

## AI-assisted contributions

- Fedora allows AI-assisted contributions under its AI-Assisted
  Contributions Policy (v1.0, 2025-10-24): the contributor is
  accountable for the whole contribution, must disclose AI use when a
  significant part comes from a tool unchanged (an `Assisted-by:`
  commit trailer for git), and should disclose other uses where
  useful. AI must not be the sole or final judge when reviewing
  others' contributions
- Policy:
  https://docs.fedoraproject.org/en-US/council/policy/ai-contribution-policy/
- Upstream projects have their own policies, and some don't accept
  AI-assisted contributions at all; check before sending them
  anything
