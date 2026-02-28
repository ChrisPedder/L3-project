#!/bin/zsh
#
# ork_extract.sh
# Extracts an OpenRocket .ork file (ZIP archive) and produces a trimmed XML
# containing only the M1550 Simulation. Output is saved alongside the .ork file.
#
# Usage: ./ork_extract.sh path/to/rocket.ork

set -euo pipefail

SIM_NAME="M1550 Simulation"

# --- Validate input ---
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <path-to-ork-file>"
    exit 1
fi

ork_file="$1"

if [[ ! -f "$ork_file" ]]; then
    echo "Error: File not found: $ork_file"
    exit 1
fi

if [[ "${ork_file:e}" != "ork" ]]; then
    echo "Error: Expected a .ork file, got: $ork_file"
    exit 1
fi

# --- Set up paths ---
ork_dir="${ork_file:h}"
ork_name="${ork_file:t}"
ork_name="${ork_name%.ork}"
output_file="${ork_dir}/${ork_name}_trimmed.xml"
tmp_dir=$(mktemp -d)

cleanup() {
    rm -rf "$tmp_dir"
}
trap cleanup EXIT

# --- Extract the ZIP archive ---
echo "Extracting $ork_file..."
unzip -q -o "$ork_file" -d "$tmp_dir"

# Find the inner XML file (usually rocket.ork)
inner_file=$(find "$tmp_dir" -name "*.ork" -type f | head -1)

if [[ -z "$inner_file" ]]; then
    echo "Error: No .ork file found inside the archive."
    exit 1
fi

# --- Locate the simulations block and the target simulation ---
sim_block_start=$(grep -n '<simulations>' "$inner_file" | head -1 | cut -d: -f1)
sim_block_end=$(grep -n '</simulations>' "$inner_file" | tail -1 | cut -d: -f1)

if [[ -z "$sim_block_start" || -z "$sim_block_end" ]]; then
    echo "Warning: No simulations block found. Outputting full file as XML."
    cp "$inner_file" "$output_file"
    echo "Output saved to: $output_file"
    exit 0
fi

# Find the line containing the target simulation name
target_name_line=$(grep -n "<name>${SIM_NAME}</name>" "$inner_file" | head -1 | cut -d: -f1)

if [[ -z "$target_name_line" ]]; then
    echo "Error: Could not find a simulation named '${SIM_NAME}'."
    echo "Available simulations:"
    awk '/<simulation/{found=1} found && /<name>/{gsub(/.*<name>|<\/name>.*/,""); print "  " $0; found=0}' "$inner_file"
    exit 1
fi

# The <simulation> opening tag is typically 1-2 lines before the <name> tag
target_start=$(awk -v name_line="$target_name_line" '
    /<simulation/ { last_sim_start = NR }
    NR == name_line { print last_sim_start; exit }
' "$inner_file")

# Find the closing </simulation> tag after the start
target_end=$(awk -v start="$target_start" '
    NR >= start && /<\/simulation>/ { print NR; exit }
' "$inner_file")

if [[ -z "$target_start" || -z "$target_end" ]]; then
    echo "Error: Could not determine the boundaries of the '${SIM_NAME}' block."
    exit 1
fi

echo "Simulations block: lines ${sim_block_start}-${sim_block_end}"
echo "${SIM_NAME}: lines ${target_start}-${target_end}"

# --- Build the trimmed file ---
{
    # Everything up to and including <simulations>
    sed -n "1,${sim_block_start}p" "$inner_file"

    # Just the target simulation
    sed -n "${target_start},${target_end}p" "$inner_file"

    # </simulations> and everything after
    sed -n "${sim_block_end},\$p" "$inner_file"
} > "$output_file"

# --- Summary ---
original_lines=$(wc -l < "$inner_file")
trimmed_lines=$(wc -l < "$output_file")
original_size=$(wc -c < "$inner_file" | tr -d ' ')
trimmed_size=$(wc -c < "$output_file" | tr -d ' ')

echo ""
echo "Done! Trimmed file saved to: $output_file"
echo "  Original: ${original_lines} lines (${original_size} bytes)"
echo "  Trimmed:  ${trimmed_lines} lines (${trimmed_size} bytes)"
