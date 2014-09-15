#!/bin/bash

if [ -z $1 ] || [ -z $2 ]; then
    echo "Usage: $0 MODULE_NAME DEBIAN_DIR"
    echo "DEBIAN_DIR is the 'debian' directory in the build directory."
    exit 1
fi

DIR="$( cd "$( dirname "$0" )" && pwd )"
package=$1
DEBIAN_DIR=$2

for script in postinst preinst postrm prerm; do
    sed -e"s/@package@/${package}/g; \
           s/@dsoname@/${package}/g; \
            /#EXTRA#/ r ${DIR}/php5-${package}.${script}.extra" \
        < "${DIR}/php5-module.${script}" \
    | sed -e'/#EXTRA#/ d' > "${DEBIAN_DIR}/php5-${package}.${script}"
done

cp "${DIR}/php5-module.triggers" "${DEBIAN_DIR}/php5-${package}.triggers"

patch "${DEBIAN_DIR}/rules" < "${DIR}/rules.patch"

echo -e "Now use './debian/rules binary' to build the package.\n"

exit 0
