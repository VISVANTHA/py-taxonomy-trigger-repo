# Python taxonomy trigger repo

Minimal Python 3.12 project for Testable whitebox. Each file exists only to give a Python tool something to measure.

Import this folder (or push it to GitHub/Bitbucket) in Execution Assistant, confirm Python 3.12, and run White Box Analysis.

## What should fire

| Tool | What this repo supplies |
|------|-------------------------|
| pylint, flake8 | Long line + unused name in `lint_noise.py` |
| radon, lizard, cognitive-ast, complexipy | Nested `if` / `for` in `core.py`, `perf.py` |
| jscpd-py | Duplicated function in `clone_a.py` / `clone_b.py` |
| bandit, semgrep | `eval`, pickle, md5, shell=True, hardcoded password |
| pip-audit, safety, pip-outdated | Old pins in `requirements.txt` (`requests==2.19.1` + `urllib3==1.23`, which pip can install together) |
| git-churn, pydriller | Git history (several commits) |
| coverage-py | pytest tests; some branches in `score_bucket` left untested |
| crosshair | Typed functions in `core.py` |
| cosmic-ray | Mutable `add` / `nested` plus passing tests |
| py-coverage-delta | Current coverage.json vs missing/empty baseline |
| py-all-defs-uses | Locals defined and used in `core.py` |
| pymcdc | `decide(flag and extra)` |
| testmon | pytest tests (wave 2 after coverage-py) |
| python-perf-dependency | Unused import + circular modules |
| semgrep-perf-static | N+1 `requests.get` in loop, triple `for`, append in nested loop, `Thread.start` |
| gitleaks, detect-secrets | Dummy AWS/GitHub-shaped strings in `secrets.py` |
| checkov, tfsec, kics | IaC smells in `infra/` — open SSH SG, public S3, unencrypted RDS/EBS, privileged K8s |

`requests==2.19.1` needs `urllib3>=1.21.1,<1.24`. Do not pin `urllib3==1.24.2` — coverage-py then fails pip install and writes `failure.json`.

GitHub Actions YAML does **not** count as IaC. Testable fingerprints `.tf`, CloudFormation (`AWSTemplateFormatVersion` / `AWS::`), Kubernetes (`apiVersion` + `kind`), and `.bicep`. The eight B1 leaves (CIS / open firewall / public storage / unencrypted storage, plus IaC Security Scanning) stay N/A until at least one of those files exists.

Cert fixtures (`cert-delay`, `cert-retry`) are platform-only and are not in this repo.

## Local smoke (optional)

```
python -m venv .venv
.venv\Scripts\pip install -e . pytest
.venv\Scripts\pytest
```
