#!/usr/bin/env bash
# UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM resident loop — default 1s
set -u
INTERVAL="${1:-${USPS_INTERVAL:-1}}"
LOG="${USPS_LOG:-universal_self_product_singularity_tm_daemon.log}"
DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd || pwd)"
SCRIPT="${USPS_SCRIPT:-$DIR/UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM.sh}"
RAW_URL="https://raw.githubusercontent.com/letsgo0226/UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM.sh/main/UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM.sh"
if [[ ! -f "$SCRIPT" ]]; then
  command -v curl >/dev/null || exit 127
  SCRIPT="${TMPDIR:-/tmp}/UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM.sh"
  curl -fsSL "$RAW_URL" -o "$SCRIPT" || exit 1
fi
command -v python3 >/dev/null || exit 127
echo "{\"daemon\":\"UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM\",\"interval\":$INTERVAL,\"ts\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" | tee -a "$LOG"
while true; do
  TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  OUT=$(mktemp)
  if bash "$SCRIPT" >"$OUT" 2>"${OUT}.err"; then
    if python3 - "$OUT" <<'PY'
import json,sys
o=json.load(open(sys.argv[1]))
ok=(o.get("model")=="UNIVERSAL_SELF_PRODUCT_SINGULARITY_TM"
    and o.get("seed")==[0,0,0,0,0,0]
    and o.get("G0")==30030 and o.get("G")==30030
    and o.get("zero_information_fixed_point") is True
    and "no floating point" in str(o.get("exactness","")))
sys.exit(0 if ok else 2)
PY
    then echo "{\"ts\":\"$TS\",\"status\":\"pass\"} $(python3 -c 'import json,sys;o=json.load(open(sys.argv[1]));print(json.dumps({k:o[k] for k in ["model","seed","G0","G","zero_information_fixed_point"]},separators=(",",":")))' "$OUT")" >>"$LOG"
    else echo "{\"ts\":\"$TS\",\"status\":\"assert_fail\"}" >>"$LOG"
    fi
  else echo "{\"ts\":\"$TS\",\"status\":\"run_fail\"}" >>"$LOG"
  fi
  rm -f "$OUT" "${OUT}.err"
  sleep "$INTERVAL"
done
