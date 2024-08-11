#!/usr/bin/env bash
set -eou pipefail

args=("$@")

if [[ "${CPPNIX_DEBUG:-}" == "1" ]]; then
  echo "cppnix args: ${args[@]}"
  set -x
fi

cpp_passthru=()
in=""

defer_to_cc1() {
  exec "$CPPNIX_ORIG_CC1" "${args[@]}"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help)
      echo "Usage: gcc -no-integrated-cpp -B <dir> cc1 [OPTION]... [FILE]..."
      exit 0
      ;;
    -fpreprocessed)
      defer_to_cc1
      ;;
    -o)
      out="$2"
      shift
      ;;
    *.nix.c)
      in="$1"
      ;;
    *)
      cpp_passthru+=("$1")
      ;;
  esac
  shift
done

# If we're not compiling a .nix.c file, defer to cc1
if [[ -z "$in" ]]; then
  defer_to_cc1
fi

nix eval --extra-experimental-features nix-command --raw --file "$in" > "$out".tmp
cat -n "$out" >&2
exec "$CPPNIX_ORIG_CC1" -iquote "$(dirname "$in")" "${cpp_passthru[@]}" "$out".tmp -o "$out"
