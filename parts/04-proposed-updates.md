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
