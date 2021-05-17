interface(prettyprint=0,errorbreak=0):
with(StringTools):
read "C://Users/User/work/gits/OEIS-mat/software/RPS_gfis.txt"; # without the header text
# read "C://Users/User/work/gits/joeis-lite/internal/fischer/rps_exp.mp";

RECaz:=proc(m,w1,w2,n,N) local ope,z,Dz,ORDER,lu,i1:
  option remember:
  ope:=DOaz(m,w1,w2,z,Dz):
  ope:=DiffToRec1(ope,z,Dz,n,N):
  ORDER:=degree(ope,N):
  ope:=add(factor(coeff(ope,N,i1))*N^i1,i1=0..ORDER):
  # print(seq(coeff(ope,N,i1)*a(n-i1),i1=0..ORDER));
  lu:=RSseq(m,w1,w2,ORDER):
  # [ope,lu]:
  { add(coeff(ope,N,i1)*a(n+i1),i1=0..ORDER)
    , a(0)=1,
    seq(a(j)=lu[j], j=1..nops(lu))
  } ;
end:

Yafe:=proc(ope,N) local i,ope1,coe1,L: 
  if ope=0 then
    RETURN(1,0):
  fi:
  ope1:=expand(ope):
  L:=degree(ope1,N):
  coe1:=coeff(ope1,N,L):
  # ope1:=normal(ope1/coe1):
  ope1:=normal(ope1):
  ope1:= convert([seq(factor(coeff(ope1,N,i))*N^i,i=ldegree(ope1,N)..degree(ope1,N))],`+`):
  factor(coe1),ope1:
end:

recgf:=proc(w1,w2) local n,N,f,re;
  re:=RECaz(2,w1,w2,n,N,10);
  f:= gfun:-rectoproc(re, a(n), remember): 
  [map(f, [$0..16])
  , re];
end:
recgf([1,1],[1,2]);

# holmap  := proc(aseqno, offset, a); local fract, num, den, str, j;
#   fract := simplify(simplify(-a(n)/a(n-1), GAMMA));
#   printf("# %a\tholof\t%a\t\%a\t[%a]\t0\t%a\n", aseqno, offset, fract, 1, a);
#   num   := seq(coeff(numer(fract),n,j),j=0..degree(numer(fract)));
#   den   := seq(coeff(denom(fract),n,j),j=0..degree(denom(fract)));
#   str   := cat("[[0],", DeleteSpace(convert([num],string)), ","
#                       , DeleteSpace(convert([den],string)), "]");
#   printf("%a\tholos\t%a\t\%s\t[%a]\t0\t%a\n", aseqno, offset, str, 1, a);
#   printf("make runholo A=%a MATRIX=\"%s\" OFFSET=%a INIT=\"[1]\"\n", aseqno, str, offset);
# end;

# timelimit($(TIMEOUT), holmap($(PARM0), $(PARM2), proc(n) $(PARM3) end));
