README
======

The `sandmark-nightly-config` repository consists of the custom
configuration files used to run
[sandmark-nightly](https://github.com/ocaml-bench/sandmark-nightly/)
scripts. The custom JSON files are present in the `config/` folder,
one per machine.

## Example

A sample JSON file is shown below:

```json
[
  {
    "url": "https://github.com/ocaml/ocaml/archive/trunk.tar.gz",
    "tag": "macro_bench",
    "config_json": "multicore_parallel_run_config_filtered.json",
    "name": "5.00+trunk+parallel",
    "expiry": "2100-01-01"
  },
  {
    "url": "https://github.com/ocaml/ocaml/archive/b73cbbea4bc40ffd26a459d594a39b99cec4273d.zip",
    "tag": "macro_bench",
    "config_json": "multicore_parallel_run_config_filtered.json",
    "name": "5.00+stable+parallel",
    "expiry": "2100-01-01"
  },
  {
    "url": "https://github.com/sadiqj/ocaml/archive/refs/heads/eventring-pr.zip",
    "tag": "run_in_ci",
    "config_json": "run_config_filtered.json",
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
| tag  | Yes       | The TAG entry from Sandmark | * `run_in_ci` <br /> * `macro_bench` <br /> * `1s_10s` <br /> * `10s_100s` <br /> * `gt_100s`|
| config_json | Yes | The run configuration *.json file from Sandmark | * `run_config.json` <br /> * `multicore_parallel_run_config.json` <br /> * `multicore_parallel_navajo_run_config.json` |
| name | Yes | An OCaml variant name with developer name, branch or PR | * `5.0.0+trunk+sequential` <br /> * `5.0.0+trunk+sadiqj+pr10964` <br /> * `5.0.0+trunk+parallel` |
| expiry | Yes | A date (YYYY-MM-DD) until which the nightly runs should be executed | 2022-02-25 |
| configure | No | `configure` options used when building the compiler | * "-q" |
| runparams | No | runtime parameters used when building the compiler | * "v=0x400" |
| environment | No | Environment variables passed when running the benchmarks | "OCAMLRUNPARAM='s=2M'"
| override_packages | No | Override Sandmark dependency package version in runtime | "fmt.0.9.0 ocamlfind.1.9.3 checkseum.0.3.0" |
| remove_packages | No | Remove Sandmark dependency package versions in runtime | "integers ppx_derivers ppx_deriving ppx_deriving_yojson" |

## UI

The nightly results can be viewed at https://sandmark.ocamllabs.io.
