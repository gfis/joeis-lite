interface(prettyprint=0,errorbreak=0):
with(StringTools):
read "C://Users/User/work/gits/OEIS-mat/software/RPS.txt";
read "C://Users/User/work/gits/OEIS-mat/software/SCHUTZENBERGER.txt";
ezra();
ezra(TerseBook);

#Mishpat1(m,w1,w2,n,N,P,t,K,M,k): 
#Like Mishpat(m,w1,w2,n,N,P,t,K,M,k) but with the Proposition
#numbered k
#For example, for Richard Stanley's Amer. Math. Monthly Problem
#11610 (118(10)[Dec. 2011], p. 937)
#type
#Mishpat1(2,[1,1],[1,2],n,N,P,t,40,3,1);

pfinite:=proc(m,w1,w2) local gu,i,mu,ope,i1,a,d1:
gu:=Info2(m,w1,w2,n,N,P,t,40,3,1):
printf("as many occurrences of the substring %a as those of %a\n", w1,w2):
# mu:=gu[3]:
ope:=gu[2]:
print(`a(n) safisfies the recurrence`):
d1:=degree(ope[1],N):
print(a(n+degree(ope[1],N))= -add(coeff(ope[1],N,d1-i1)*a(n+d1-i1),i1=1..d1)):
# print(``):
# print(`subject to the initial conditions`):
print(seq(a[i1]=ope[2][i1],i1=1..nops(ope[2]))):
end;
pfinite(2,[1,1],[1,2]);


f:= gfun:-rectoproc({
a(n+5) = (3*n^2+22*n+37)/(n+5)/(3+n)*a(n+4)-(3*n^2+20*n+27)/(n+5)/(3+n)*a(3+n)+(5*n^2+32*n+41)/(n+5)/(3+n)*a
(n+2)-2*(4*n^2+23*n+26)/(n+5)/(3+n)*a(1+n)+4*(n+4)*(1+n)/(n+5)/(3+n)*a(n)
,a(0)=0,a(1) = 2, a(2) = 2, a(3) = 3, a(4) = 6, a(5) = 9
}, a(n), remember): map(f, [$0..40]);

f:= gfun:-rectoproc({
-(n+5)*(3+n)*a(n+5) + (3*n^2+22*n+37)*a(n+4)-(3*n^2+20*n+27)*a(3+n)+(5*n^2+32*n+41)*a
(n+2)-2*(4*n^2+23*n+26)*a(1+n)+4*(n+4)*(1+n)*a(n) = 0
,a(0)=0,a(1) = 2, a(2) = 2, a(3) = 3, a(4) = 6, a(5) = 9
}, a(n), remember): map(f, [$0..40]);

RECaz(2,[1,1],[1,2],n,N,10);
[-16*(3+n)*(1+n)/(n+7)/(6+n)+8*(5*n^2+26*n+30)/(n+7)/(6+n)*N-8*(5*n^2+34*n+54)/(n+7)/(6+n)*N^2+2*(15*n^2+119
*n+228)/(n+7)/(6+n)*N^3-(23*n^2+185*n+366)/(n+7)/(6+n)*N^4+(n+5)*(13*n+54)/(n+7)/(6+n)*N^5-(5*n+27)/(n+7)*N^
6+N^7, [2, 2, 3, 6, 9, 15, 30]]

# e;
# 3*b(n)+(n-2)*b(n-1)+(-n^2+4)/(3+n)*b(3+n)
# m:= -2222:for j from 1 to nops(e) do e2:= op(j,e): e3:=op(1,op(nops(e2),e2))-n: m:=max(m,e3):end do: m;
# 3
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

timelimit($(TIMEOUT), holmap($(PARM0), $(PARM2), proc(n) $(PARM3) end));
