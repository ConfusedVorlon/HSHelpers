#!/bin/sh

# Run with the following in a build script phase
# time ${BUILD_DIR%%Build/Products}SourcePackages/checkouts/HSHelpers/Sources/HSHelpers/todoFixme.sh

KEYWORDS="TODO|FIXME|WARNING|\?\?\?:|\!\!\!:"
find "${SRCROOT}" -path "${SRCROOT}/Pods" -prune -o \( -name "*.h" -or -name "*.m" -or -name "*.swift" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | perl -p -e "s/($KEYWORDS)/ warning: \$1/"
