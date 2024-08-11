{ example, runCommand }:

runCommand "check" {
  nativeBuildInputs = [ example ];
} ''
  [[ hello == $(example) ]] || {
    echo "Expected 'hello', got '$(example)'"
    exit 1
  }
  touch $out
''
