#!/usr/bin/env bash
# Determinism check: main.py must write the same entry.txt every run.
set -euo pipefail
cd "$(dirname "$0")"

python3 main.py
sha256sum /output/entry.txt > /tmp/two-lines-run1.sha
python3 main.py
sha256sum /output/entry.txt > /tmp/two-lines-run2.sha
diff /tmp/two-lines-run1.sha /tmp/two-lines-run2.sha

# Format checks: exactly 136 bytes, exactly one newline (two lines, no
# trailing newline), each line a single sentence ending in a period.
test "$(wc -c < /output/entry.txt)" = "136"
test "$(wc -l < /output/entry.txt)" = "1"
python3 - <<'EOF'
data = open("/output/entry.txt", encoding="utf-8").read()
lines = data.split("\n")
assert len(lines) == 2, lines
assert not data.endswith("\n")
for line in lines:
    assert line.endswith("."), line
    assert line.count(".") == 1, line  # one sentence per line
assert 1 <= len(data) <= 280
print("entry ok:", len(data), "chars,", len(lines), "lines")
EOF

echo "determinism OK"
