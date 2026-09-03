#!/usr/bin/env bash
# test.sh — run all test_*.scad files and report pass/fail
# Usage: ./test.sh [optional: path/to/dir]
#
# Requires: openscad on PATH  (brew install openscad)
# Each file is exported to /tmp/scad_test_<name>.stl
# A non-zero exit code (assertion failure / geometry error) = FAIL.

set -euo pipefail

DIR="${1:-parametric_organizer}"
PASS=0
FAIL=0
ERRORS=()

echo "=== OpenSCAD tests in: $DIR ==="

for f in "$DIR"/test_*.scad; do
    name=$(basename "$f" .scad)
    out="/tmp/scad_test_${name}.stl"
    # Capture stderr (warnings/asserts); suppress normal ECHO lines
    log=$(openscad -o "$out" "$f" 2>&1) && ok=1 || ok=0
    # Separate echo lines from real errors
    echo_lines=$(echo "$log" | grep '^ECHO:' || true)
    err_lines=$(echo  "$log" | grep -v '^ECHO:' || true)

    if [ "$ok" -eq 1 ]; then
        echo "✓  $name"
        [ -n "$echo_lines" ] && echo "$echo_lines" | sed 's/^/   /'
        PASS=$((PASS + 1))
    else
        echo "✗  $name  FAILED"
        echo "$log" | sed 's/^/   /'
        FAIL=$((FAIL + 1))
        ERRORS+=("$name")
    fi
done

echo ""
echo "Results: $PASS passed, $FAIL failed"

if [ ${#ERRORS[@]} -gt 0 ]; then
    echo "Failed files:"
    for e in "${ERRORS[@]}"; do echo "  - $e"; done
    exit 1
fi
