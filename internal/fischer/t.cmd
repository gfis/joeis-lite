@echo off
echo "-------- %1% --------"
grep %1% ../../../OEIS-mat/common/stripped | sed -e "s/^A[0-9]* ,//" -e "s/,/, /g"
make seqtest A=%1% | grep -v java