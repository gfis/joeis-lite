-- patches for A062845 and derived
-- @(#) $Id$
-- 2023-03-13, Georg Fischer
UPDATE asinfo i SET s.offset1 = '1' WHERE aseqno IN
('A062922'
,'A062923'
,'A062925'
,'A062928'
,'A062929'
,'A062930'
,'A062931'
,'A062934'
,'A062937'
,'A062939'
,'A062942'
,'A062943'
,'A062944'
);     
COMMIT;
UPDATE seq4 s SET s.offset1 = (SELECT i.offset1 FROM asinfo i WHERE s.aseqno = i.aseqno);
COMMIT;
