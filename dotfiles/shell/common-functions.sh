# Make directory and cd into it
mkcd () {
    mkdir -p "$1" && cd "$1"
}

# Create temporary directory and cd into
mktmp () {
    if [ -z $1 ]; then
      cd "$(mktemp -d /tmp/XXXXXX)"
    else
      mkdir -p "$1" && cd "$1"
    fi
}

# Copy working directory to clipboard
cwd() {
  if command -v pbcopy >/dev/null 2>&1; then
    echo "$(pwd)/$1" | pbcopy
  elif command -v xclip >/dev/null 2>&1; then
      echo "$(pwd)/$1" | xclip -selection clipboard 
  else
    echo "No clipboard tool found"
    return 1
  fi
}

# Copy text to clipboard
cb() {
  if command -v pbcopy >/dev/null 2>&1; then
    pbcopy < "$1"
  elif command -v xclip >/dev/null 2>&1; then
    xclip -selection clipboard < "$1"
  else
    echo "No clipboard tool found"
    return 1
  fi
}

# Create a simple main.c
maininit() {
  cat > main.c <<'EOF'
#include <stdio.h>

int main(void)
{
    

    return 0;
}
EOF
  
  $EDITOR main.c
}

# Create a simple Makefile
makeinit() {
  cat > Makefile <<'EOF'
CC = gcc
CFLAGS = -std=c99 -pedantic -Werror -Wall -Wextra -Wvla

MAIN = main.c
TSTS = tests.c
SRCS =
OBJS = ${SRC:.c=.o}
DEST = main

all: ${DEST}

${DEST}: ${OBJS}

check: LDFLAGS = -lcriterion
check: ${TSTS} ${OBJS}

debug: CFLAGS += -O0 -g3 -fsanitize=address
debug: LDFLAGS = -fsanitize=address
debug: {SRCS}
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

clean:
	${RM} ${OBJS} ${DEST}

.PHONY: all clean

EOF

  $EDITOR Makefile
}

