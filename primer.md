# Working with Fedora, EPEL and the CentOS SIGs

*A primer for teams that run fleets on CentOS Stream. Current as of
2026-11.*

## TL;DR

Most of what a CentOS Stream fleet runs comes from public projects:
Fedora, EPEL, CentOS Stream, and CentOS Special Interest Groups (SIGs)
such as Hyperscale and Proposed Updates. You can work with all of them
directly, as anyone can. Please do: report bugs, open pull or merge
requests, and request packages yourself, then tell your organization's
distribution team what you did. That keeps them informed and able to
help when needed, without making them a step you wait on.

Each section below is a short summary with links. The linked public
docs are the reference; if they are wrong or missing something, that's
a bug in those docs, and fixing it there helps everyone.

## Where to go

| You want to… | Go to |
|---|---|
| Report a bug in a CentOS Stream package | Red Hat Jira, project RHEL (see [Proposed Updates](#proposed-updates)) |
| Get a fix into CentOS Stream | A merge request against the package in [CentOS Stream's GitLab](https://gitlab.com/redhat/centos-stream/rpms), with a RHEL Jira issue, one per Stream branch (c9s, c10s) |
| Use a CentOS Stream fix before Stream ships it | [Proposed Updates](#proposed-updates) |
| Report a bug in a Fedora or EPEL package | Fedora Bugzilla (see [Reporting a problem](#reporting-a-problem)) |
| Get a package that isn't in CentOS Stream | Fedora first, then EPEL, with rare EPEL-only exceptions (see [Becoming a packager](#becoming-a-packager) and [Getting a package into EPEL](#getting-a-package-into-epel)) |
| Get a package that is in Fedora but not in EPEL | Ask its Fedora maintainer, then file an EPEL package request (see [Getting a package into EPEL](#getting-a-package-into-epel)) |
| Get a newer version of a core package (e.g. systemd) than Stream ships | [Hyperscale](#hyperscale) |
| Build and test your own packages without becoming a packager | COPR (see [Building your own packages](#building-your-own-packages-copr)) |
| Report a bug in a Hyperscale or Proposed Updates package | That SIG's tracker (see its section) |

Fix bugs upstream first: in the software's own project, then in the
distribution that ships it. The SIGs are for what can't go into Fedora,
EPEL or CentOS Stream directly, or can't go there in time.

## Working with your distribution team

Many organizations have a team that maintains their Linux
distribution: which packages hosts get, from where, and how updates
roll out. These sections assume yours does.

### Why go upstream yourself

Distribution teams are usually small compared with the fleets they
serve. If every package request, bug and fix goes through them, it
waits in their queue behind everyone else's, and the team that hit
the problem waits with it. Going upstream directly is usually faster:

- Fedora, EPEL and CentOS Stream are open to anyone. Filing a bug,
  opening a merge request or asking a maintainer for an EPEL branch
  needs no special rights.
- Maintainers respond best to the person who hit the problem: you can
  reproduce it, test a fix on real hosts and answer their questions
  directly. Passed through another team, each of those becomes a
  round trip.
- Work done in public stays useful after the person who did it moves
  on, and anyone can pick it up where it was left.

So don't wait for your distribution team before starting. Only a few
steps need someone with packager or SIG rights (see the sections
below), and even for those, having the bug or merge request ready
makes them quick.

### Why still keep them informed

Telling them is not asking permission. It lets them:

- **Prioritize.** With limited time, they spend it where the fleet
  impact is largest, which they can only judge if they know what is
  in flight and what it affects.
- **Avoid duplicate work.** Two teams often hit the same bug. They can
  connect them, or point you at an existing fix or SIG build.
- **Get the fix to the fleet.** A fix merged upstream still has to
  reach your hosts: through a Stream or EPEL update, a SIG build, or a
  change to your own repositories. They track that part, and can't
  track what they don't know about.
- **Unblock you when you're stuck.** If a maintainer hasn't answered,
  they often know who else to ask or which route (EPEL, a SIG, a
  temporary build) gets you there sooner.

### What to send

Once you've filed something, send your distribution team:

- **The link:** bug, issue, pull or merge request, or package request.
- **The impact:** which services or how many hosts it affects, and
  what happens to them (crash, data loss, security exposure, slower
  rollout, an inconvenience).
- **The urgency:** a deadline, whether there is a workaround, and
  whether it is a security issue.
- **What you need from them:** a review, a nudge to a maintainer, an
  EPEL or SIG build, or nothing (just keeping them informed).

The impact and urgency are what let them decide what to work on first,
so be concrete: "blocks next week's rollout to a whole service, no
workaround" gets picked up before "would be nice to have". A few
sentences is enough; the details belong in the public bug or merge
request, where the maintainers can see them, and that is where the
follow-up happens.

When the request needs someone with packager or SIG rights (a review,
an EPEL or SIG build), say so. When it doesn't, carry on: you don't
need to wait for them.

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

## Proposed Updates

**TL;DR:** the CentOS Proposed Updates SIG (CPU SIG) builds fixes for
CentOS Stream packages that are on their way into Stream (an open merge
request, usually with a RHEL Jira issue) but haven't shipped yet. Each
build is temporary: once Stream ships the fix, the SIG retires it and
systems go back to the stock package. This is the route for an urgent
fix, often a security one, that can't wait for Stream's own schedule.

- **Docs:** <https://sigs.centos.org/proposed_updates/>
- **What's available:** the
  [updates list](https://sigs.centos.org/proposed_updates/content/updates/),
  updates in testing first. Each links to its tracking issue, merge
  request and Jira issue.
- **Using it:** `dnf install centos-release-proposed_updates` for
  released updates. Add `centos-release-proposed_updates-testing`
  (release 9-2 / 10-2 or later) for updates still in testing. See
  [Repositories](https://sigs.centos.org/proposed_updates/content/repositories/),
  including how to try one update without taking all of them.
- **Testing an update:** the most useful thing a fleet can do. Install
  it on some hosts from the testing repository, then react 👍 or 👎 to
  the build's "ready for testing" comment on its tracking issue, with a
  comment if something broke. Tested updates are released sooner.
- **Getting a fix in:**
  1. File (or find) the RHEL Jira issue, and open a merge request
     against the package in
     [CentOS Stream's GitLab](https://gitlab.com/redhat/centos-stream/rpms),
     one per Stream branch.
  2. Ask the SIG to pick it up, with the merge request's URL.
  3. The SIG builds and tracks it from there. See
     [Proposing an update](https://sigs.centos.org/proposed_updates/contributing/proposing/).
     sandogasa's `cpu-sig-tracker` drafts the Jira issue and opens the
     merge request; the SIG builds with `cbspkg`. See [Tools](#tools).
- **Talking to the SIG:** the Matrix room
  [#centos-proposed-updates:fedoraproject.org](https://matrix.to/#/#centos-proposed-updates:fedoraproject.org)
  and the
  [SIG tracker](https://gitlab.com/CentOS/proposed_updates/sig/-/issues).
  Meetings are shared with Hyperscale.

## Tools

**TL;DR:** the `sandogasa` package (in Fedora and EPEL:
`dnf install sandogasa`) collects command-line tools for this work.
Most need only a Fedora account, a Red Hat Jira account or a GitLab
account; the ones that build or tag need packager or SIG rights and are
what the SIGs run once you hand something over. Each tool has a README
with examples, and `man <tool>` once installed:
<https://github.com/michel-slm/sandogasa>

| Task | Tool | What it does |
|---|---|---|
| Which releases and repositories ship a package, SIG repositories included | `fedrq`, with sandogasa's `fedrq-config-centos-hyperscale` and `fedrq-config-centos-proposed-updates` | fedrq queries Fedora, EPEL and CentOS Stream repositories without local setup; the two config packages add the Hyperscale (`hs.el10`) and Proposed Updates (`cpu.el10`) repositories. [fedrq](https://forge.fedoraproject.org/packaging/fedrq), [config files](https://github.com/michel-slm/sandogasa/tree/main/configs/fedrq) |
| How a package's version compares across upstream, Fedora, CentOS Stream and Hyperscale | `hs-relmon check-latest` | Lists the version each distribution ships, to show whether one is behind. [README](https://github.com/michel-slm/sandogasa/tree/main/tools/hs-relmon) |
| What it takes to get a package into EPEL | `ebranch resolve` (`ebranch check-crate` for Rust crates) | Lists the package's dependencies missing from the EPEL branch, in the order they would have to be built. [README](https://github.com/michel-slm/sandogasa/tree/main/tools/ebranch) |
| Asking for EPEL branches, and following up | `ebranch file-request` | Files the Bugzilla branch requests the EPEL docs describe, and chases unanswered ones. Needs a Bugzilla API key. Same README |
| Testing a Fedora or EPEL update | `ebranch check-update` | Checks whether a Bodhi update breaks packages that depend on it, and can give the karma with the result. Same README |
| Getting a fix into Proposed Updates | `cpu-sig-tracker jira`, `cpu-sig-tracker mr` | `jira` finds or drafts the RHEL Jira issue a CentOS Stream merge request needs (one per branch), and shows the full issue and asks before filing it, since a filed issue can only be commented on; `mr` opens the merge request from your dist-git checkout. [README](https://github.com/michel-slm/sandogasa/tree/main/tools/cpu-sig-tracker) |
| Where a Proposed Update stands | `cpu-sig-tracker status` | Shows each update's build, testing and release state, and whether Stream has shipped the fix. Same README |
| Checking a package before proposing it for Hyperscale | `hs-intake safe-to-backport` | Compares a Fedora source package's dependencies and Provides with the CentOS Stream branch it would replace. [README](https://github.com/michel-slm/sandogasa/tree/main/tools/hs-intake) |

What the SIGs run once you hand something over, for reference only:
`cbspkg` builds and promotes in the CentOS Build System, and
`cpu-sig-tracker file-issue`, `ping` and `retire` track an update from
merge request to retirement.
[cbspkg README](https://github.com/michel-slm/sandogasa/tree/main/tools/cbspkg)
