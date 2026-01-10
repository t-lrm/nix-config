#!/bin/env python3
 
import sys
import subprocess
from os.path import exists

class Architecture:
    def __init__(self, filepath: str) -> None:
        self.filepath: str = filepath
        self.data: list[str] = []
        self.indentations: list[tuple[int, str]] = []
        self.commands: list[list[str]] = []

        self.indent_size = 4
        self.separator = "── "

        if not exists(filepath):
            raise FileNotFoundError()

        with open(filepath, "r") as f:
            self.data = f.readlines()

    def populate_indentation_list(self) -> None:
        for row in self.data:
            if self.separator not in row:
                continue;

            indent, filename = row.split(self.separator)
            indent = indent[:-1] # remove the '├' or '└' character
            filename = filename[:-1] # remove the '\n' at the end

            indent_level = len(indent) // self.indent_size

            self.indentations.append((indent_level, filename))

    def populate_commands(self) -> None:
        path = ["."]
        for i in range(len(self.indentations) - 1):
            if self.indentations[i + 1][0] > self.indentations[i][0]:
                path.append(self.indentations[i][1])
                self.commands.append(["mkdir", "/".join(path)])
            else:
                self.commands.append(["touch", f'{"/".join(path)}/{self.indentations[i][1]}'])

            if self.indentations[i + 1][0] < self.indentations[i][0]:
                path.pop()

        self.commands.append(["touch", f'{"/".join(path)}/{self.indentations[-1][1]}'])


    def run_commands(self, ask_confirmation: bool = True) -> None:
        if len(self.commands) == 0:
            print("Nothing to run.")

        if ask_confirmation:
            print("You are about to run those commands:")
            for cmd in self.commands:
                print(" ".join(cmd))
            confirmation = str(input("Are you sure? [y/N] "))

            if confirmation.lower() not in ["y", "yes"]:
                print("Command aborted.")
                return None

        for cmd in self.commands:
            subprocess.run(cmd)

def main(filename: str):
    archi = Architecture(filename)
    archi.populate_indentation_list()
    archi.populate_commands()
    archi.run_commands()

if __name__ == "__main__":
    args = sys.argv
    if len(args) != 2:
        raise ValueError(f"Invalid number of arguments. You should run '{args[0]} filename'")

    main(args[1])
