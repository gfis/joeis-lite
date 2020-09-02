use strict; \
	if (m{^(A\d+)\s+Coefficients in expansion of Dirichlet series Product_p}) { \
	  my $$aseqno =$$1; m{for\s+m\s*\=\s*(\-?\d+)}; my $$m = $$1;  \
	  print join("\t", $$aseqno, "$@", 0, $$m) . "\n"; }  \