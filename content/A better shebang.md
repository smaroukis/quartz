---
title: "Shebang #!/usr/bin/env/bash is superior to #!/bin/bash"
date: 2024-02-15
description: 
tags:
  - bash
slug: 
draft: false
math: false
---
`#!/usr/bin/env bash` is superior to `#!/bin/bash` since the former will use the first version of bash found on the system path which is necessary if the user has updated bash like I did on macOS (I needed to update >v4 to get debugging in VSCode). 

To see the full path to the binary being used we can do
`readlink -f $(which bash)`