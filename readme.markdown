Thanks to https://github.com/joncooper for pairing on the development of this tool.

Thanks for the useful examples and references

Pbxproj file manipulation in Ruby using Erica Sadun's plutil

- http://emilloer.com/2011/08/15/dealing-with-project-dot-pbxproj-in-ruby/
- http://ericasadun.com/2008/07/announcing-jailbreak-erica-utilities/

Treetop

- https://github.com/nathansobo/treetop

Treetop parsers

- http://thingsaaronmade.com/blog/a-quick-intro-to-writing-a-parser-using-treetop.html

Tree merging

- "A 3-way Merging Algorithm for Synchronizing Ordered Trees — the 3DM merging and differencing tool for XML" by Tancred Lindholm (http://www.cs.hut.fi/~ctl/3dm/thesis.pdf)

Git

- http://www.kernel.org/pub/software/scm/git/docs/git-mergetool.html

      --tool=<tool>
      Use the merge resolution program specified by <tool>. Valid merge tools are: araxis, bc3, diffuse, ecmerge, emerge, gvimdiff, kdiff3, meld, opendiff, p4merge, tkdiff, tortoisemerge, vimdiff and xxdiff.
      If a merge resolution program is not specified, git mergetool will use the configuration variable merge.tool. If the configuration variable merge.tool is not set, git mergetool will pick a suitable default.
      You can explicitly provide a full path to the tool by setting the configuration variable mergetool.<tool>.path. For example, you can configure the absolute path to kdiff3 by setting mergetool.kdiff3.path. Otherwise, git mergetool assumes the tool is available in PATH.
      Instead of running one of the known merge tool programs, git mergetool can be customized to run an alternative program by specifying the command line to invoke in a configuration variable mergetool.<tool>.cmd.
      When git mergetool is invoked with this tool (either through the -t or --tool option or the merge.tool configuration variable) the configured command line will be invoked with $BASE set to the name of a temporary file containing the common base for the merge, if available; $LOCAL set to the name of a temporary file containing the contents of the file on the current branch; $REMOTE set to the name of a temporary file containing the contents of the file to be merged, and $MERGED set to the name of the file to which the merge tool should write the result of the merge resolution.
      If the custom merge tool correctly indicates the success of a merge resolution with its exit code, then the configuration variable mergetool.<tool>.trustExitCode can be set to true. Otherwise, git mergetool will prompt the user to indicate the success of the resolution after the custom tool has exited.