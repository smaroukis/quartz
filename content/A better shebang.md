---
title: "Shebang #!/usr/bin/env bash is superior to #!/bin/bash"
date: 2024-02-15
description: 
tags:
  - bash
slug: 
draft: false
math: false
---
`#!/usr/bin/env bash` is superior to `#!/bin/bash` since the former will use the first version of bash found on the system path which is necessary if the user has updated bash like I did on macOS (I needed to update >v4 to get debugging in VSCode). 

Comparing the default installed bash version (3.2) with the newly installed one (5.2)
![](attachments/Screenshot%202024-03-01%20at%2010.23.07%20AM.png)
To see the full path to the binary being used we can do
`readlink -f $(which bash)`

Investigating the symlink path shows the homebrew installed location of the binary, upgraded to 5.2.26.
![](attachments/Screenshot%202024-03-01%20at%2010.25.01%20AM.png)

