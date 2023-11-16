#!/usr/bin/env bash
# Check for non-200 links in built Jekyll site using Firebase emulator
set -eu -o pipefail
source $TOOL_DIR/utils.sh

dart pub get

echo "Checking for valid link references..."
# Check for invalid link references before checking for links
dart run tool/dart_tools/bin/check_link_references.dart
echo $'No invalid link references found!\n'

trap clean_up SIGINT SIGTERM ERR EXIT

EMULATOR_PORT=5500 # airplay runs on :5000

# Catch error, stop running emulator process by port
clean_up() {
  trap - SIGINT SIGTERM ERR EXIT
  echo -e "$(blue "Shutting down emulator...")"
  lsof -t -i:$EMULATOR_PORT | xargs kill -9 > /dev/null 2>&1
  echo -e "$(blue "Done!")\n"
}

echo -e "$(blue "Starting emulator async...")"
python3 -m http.server --directory=_site $EMULATOR_PORT > /dev/null &

sleep 5 # wait a few just in case

SKIP_FILE="$TOOL_DIR/config/linkcheck-skip-list.txt"
dart run linkcheck :$EMULATOR_PORT --skip-file $SKIP_FILE
