# upstream-primer

[![AI-DECLARATION: copilot](https://img.shields.io/badge/䷼%20AI--DECLARATION-copilot-fee2e2?labelColor=fee2e2)](https://ai-declaration.md)

A primer for teams that run fleets on CentOS Stream: how to work
directly with Fedora, EPEL, CentOS Stream and the CentOS Hyperscale and
Proposed Updates SIGs, and how to keep your own distribution team
informed while doing so.

It summarises and links the projects' own documentation rather than
repeating it. Where the two disagree, the project docs are the
reference, and a fix belongs there first.

**Read it:** [primer.md](primer.md)

## Layout

- `parts/`: one file per topic, assembled in file name order
- `primer.md`: the assembled primer, built with `make` and committed
  so it can be read and downloaded directly

Edit the parts, run `make`, and commit both. `make check` fails if
`primer.md` is out of date.

## Using it inside an organisation

Each release attaches `primer.md` to its
[GitHub release](https://github.com/slopfest/upstream-primer/releases).
To adapt it internally, import that file unchanged and keep your
organisation's details (who the distribution team is, where to reach
them, internal repositories) in a separate addendum. Refreshing the
internal copy is then a re-import, and the diff between two releases
shows what changed.

## Maintenance

The primer is checked against its sources periodically and when the
tools it mentions change significantly, not on every release of them.
Releases are tagged by date (`2026.11`). Each part's sources and when
they were last checked are noted in a comment at its top, where there
is one.

## License

[CC BY-SA 4.0](LICENSE), the license of the Fedora documentation it
summarises.
