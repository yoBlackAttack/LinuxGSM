#!/bin/bash
# LinuxGSM compress_ut99_maps.sh module
# Author: Daniel Gibbs
# Contributors: https://linuxgsm.com/contrib
# Website: https://linuxgsm.com
# Description: Compresses unreal maps.

commandname="MAP-COMPRESSOR"
commandaction="Compressing maps"
moduleselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"
fn_firstcommand_set

check.sh
fn_print_header
echo -e "Will compress all maps in:"
echo -e ""
pwd
echo -e ""
echo -e "Compressed maps saved to:"
echo -e ""
echo -e "${compressedmapsdir}"
echo -e ""
if ! fn_prompt_yn "Start compression?" Y; then
	exitcode=0
	core_exit.sh
fi
mkdir -pv "${compressedmapsdir}" > /dev/null 2>&1
rm -rfv "${serverfiles:?}/Maps/"*.unr.uz
cd "${systemdir}" || exit
for map in "${serverfiles}/Maps/"*; do
	./ucc-bin compress "${map}" --nohomedir
done
mv -fv "${serverfiles}/Maps/"*.unr.uz "${compressedmapsdir}"

core_exit.sh
