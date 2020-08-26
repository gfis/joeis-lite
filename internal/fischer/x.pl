use strict; if (m{\A\%t (A\d+)}) { my $$aseqno = $$1; '\
	' if (m{PadRight *\[ *(\{ *[\}0-9][^\]]+)\]}) { '\
	' my $$pad = $$1; $$pad =~ s{ }{}g; '\
	' print join("\t", $$aseqno, $$pad) . "\n"; }}