# UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM.sh

Universal self-product singularity TM (seed `[0,0,0,0,0,0]`, `G₀=30030`).

| Artifact | Role |
|----------|------|
| `UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM.sh` | One-liner (~1159B) |
| `UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM_DAEMON.sh` | Resident loop (default 1s) |
| `.github/workflows/universal-self-product-singularity-tm.yml` | Actions `*/5` |
| `Singularity.sh` | Related entrypoint |

```sh
curl -fsSL https://raw.githubusercontent.com/letsgo0226/UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM.sh/main/UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM.sh | bash
nohup bash UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM_DAEMON.sh 1 >> universal_self_product_singularity_tm_daemon.log 2>&1 &
```

Bound: formal / symbolic certificate only — not empirical singularity.
