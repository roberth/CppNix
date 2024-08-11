
postConfigureHooks+=( "setupCppNix" )
shellHook="setupCppNix"$'\n'"${shellHook:-}"

setupCppNix() {
  export CPPNIX_ORIG_CC1="$(gcc -print-prog-name=cc1)"
  NIX_CFLAGS_COMPILE="${NIX_CFLAGS_COMPILE:-} -no-integrated-cpp -B@out@/bin"

  # Also configure Nix to run in the sandbox
  if [[ -z "${IN_NIX_SHELL:-}" ]]; then
    store="$(mktemp -d)"
    export NIX_STORE=$store/store
    export NIX_STATE_DIR=$store/state
    # Since we've changed NIX_STORE, ld-wrapper thinks all store paths are
    # on the "system" instead, so we disable that check.
    NIX_ENFORCE_PURITY=0
  fi

}
