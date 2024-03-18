README
======

The `sandmark-nightly-config` repository consists of the custom
configuration files used to run
[sandmark-nightly](https://github.com/ocaml-bench/sandmark-nightly/)
scripts. The custom JSON files are present in the `config/` folder,
one per machine. Both the `sequential` and `parallel` Sandmark
benchmarks are built and executed, by default, for each entry.

## Adding your compiler branch to the nightly runs

The `config` folder includes two JSON files, `custom_navajo.json` and
`custom_turing.json`, for running the benchmarks on the Navajo and
Turing servers respectively. You are encouraged to create a PR for
your compiler development branch to be executed nightly on both the
server machines. The following three URLs are supported:

1. `Branch`: A compiler development branch whose changes need to be compared nightly.

2. `Commit`: A specific SHA1 commit on which the benchmarks should be executed.

3. `Pull Request`: An open pull request to check for performance regressions.

A sample custom JSON file illustrating the above three URLs is given below:

```json
[
  {
    "url": "https://github.com/ocaml/ocaml/archive/trunk.tar.gz",
    "name": "5.00+trunk",
    "expiry": "2100-01-01"
  },
  {
    "url": "https://github.com/ocaml/ocaml/archive/b73cbbea4bc40ffd26a459d594a39b99cec4273d.zip",
    "name": "5.00+stable+b73cbb",
    "expiry": "2100-01-01"
  },
  {
    "url": "https://github.com/sadiqj/ocaml/archive/refs/heads/eventring-pr.zip",
    "name": "5.00+trunk+sadiqj+pr10964",
    "expiry": "2022-02-25"
  }
]
```

## Attributes

The following attributes are supported for specifying the custom
variant build:

| Name | Mandatory | Description | Example(s) |
|------|-----------|----------|-------|
| url  | Yes       | Specify trunk or commit or branch URL | * https://github.com/ocaml/ocaml/archive/trunk.tar.gz <br /> * https://github.com/ocaml/ocaml/archive/b73cbbea4bc40ffd26a459d594a39b99cec4273d.zip <br /> * https://github.com/sadiqj/ocaml/archive/refs/heads/eventring-pr.zip |
| name | Yes | An OCaml variant name with developer name, branch or PR | * `5.0.0+trunk+sequential` <br /> * `5.0.0+trunk+sadiqj+pr10964` <br /> * `5.0.0+trunk+parallel` |
| expiry | Yes | A date (YYYY-MM-DD) until which the nightly runs should be executed | 2022-02-25 |
| configure | No | `configure` options used when building the compiler | * "-q" |
| runparams | No | runtime parameters used when building the compiler | * "v=0x400" |
| environment | No | Environment variables passed when running the benchmarks | "OCAMLRUNPARAM='s=2M'"

## UI

The nightly results can be viewed at https://sandmark.tarides.com

## Platform-specific instructions

The `turing` configuration runs on an Intel Xeon scalable processor
based on Skylake. It is recommended to apply the workaround to the JCC
erratum microcode update
(https://www.intel.com/content/dam/support/us/en/documents/processors/mitigations-jump-conditional-code-erratum.pdf).

To do so, add a line
```
    "configure": "CC='gcc -Wa,-mbranches-within-32B' AS='as -mbranches-within-32B'",
```
(for gcc) or
```
    "configure": "CC='clang -mbranches-within-32B-boundaries' AS='as -mbranches-within-32B'",
```
(for clang) to the configuration.
