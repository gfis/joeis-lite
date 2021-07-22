# joeis-lite
Subset of jOEIS for program generation and testing

This repository is a strongly stripped-down version of Sean Irvine's https://github.com/archmageirvine/joeis. The test classes and all implemented sequences in the directories src/irvine/oeis/a* are removed in order to reduce compile time and jar size.

joeis-lite/internal/fischer contains scripts for the generation of groups of sequences, among them:
* Linear Recurrences
* Ordinary generating functions
* Coxeter groups
* Finite/full sequences
* Continuous fraction expansions for square roots
* Sequences related to bases which are represented by two decimal digits

There is a Wiki with further details.
