#!/usr/bin/env lr

if (is.null(argv) | length(argv)<1) {
  cat("Usage: pinky.r path/to/project\n")
  q()
}

pinky::scaffold(argv[1])
