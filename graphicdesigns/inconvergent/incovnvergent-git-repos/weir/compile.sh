#!/bin/bash

set -e
touch ./weir.asd
sbcl --quit \
     --eval '(load "~/quicklisp/setup.lisp")'\
     --eval '(load "weir.asd")'\
     --eval '(handler-case (ql:quickload :weir :verbose t)
                           (error (c) (print c) (sb-ext:quit :unix-status 2)))'\
  >compile.sh.tmp 2>&1
