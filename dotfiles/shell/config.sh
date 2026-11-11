eval "$(direnv hook "$SHELL")"

if [ "$(uname -s)" = "Darwin" ]; then # needed when LLDB is installed with nix
  export LLDB_DEBUGSERVER_PATH="/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources/debugserver"
fi
