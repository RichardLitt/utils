#!/bin/sh

ISSUES="$(ghi list)"
COMMENT="Thanks! This is likely stale, so we are closing it."

echo "$ISSUES" | while read x; do
  issueno=$(echo $x | grep -oE '(^[0-9]+)')
  if [ ! -z "$issueno" ]; then
    ghi close $issueno -m "$COMMENT"
  fi
done
