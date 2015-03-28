#!/usr/bin/env lr

if (is.null(argv) | length(argv)<2) {
  cat("Usage: pinky-bundle.r path/to/project bundle_file\n")
  q()
}

packrat::bundle(project=argv[1], file=argv[2])
