# Things to work on

## Compilation

- given the parse tree, emit a project file

## lint analyses

- targets which don't appear in the project dictionary
- files in a spec target's tested target which aren't included in the
  spec target
- duplicate file entries

## 3-way merge

- parse base, remote, local, merge result for validation

## gem-ish functionality

- insert entries into the tree so that one can, for example:
  `project_err install https://github.com/erikdoe/ocmock.git
--project="./Foo.xcodeproj/project.pbxproj" --target="Specs" "Unit
Tests"`
