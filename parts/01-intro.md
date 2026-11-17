# Working with Fedora, EPEL and the CentOS SIGs

*A primer for teams that run fleets on CentOS Stream. Current as of
2026-11.*

## TL;DR

Most of what a CentOS Stream fleet runs comes from public projects:
Fedora, EPEL, CentOS Stream, and CentOS Special Interest Groups (SIGs)
such as Hyperscale and Proposed Updates. You can work with all of them
directly, as anyone can. Please do: report bugs, open pull or merge
requests, and request packages yourself, then tell your organisation's
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

Many organisations have a team that maintains their Linux
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

- **Prioritise.** With limited time, they spend it where the fleet
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
