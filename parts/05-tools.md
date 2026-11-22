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
