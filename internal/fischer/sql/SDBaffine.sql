-- SDBaffine.sql - patches
-- 2021-06-25, Georg Fischer
UPDATE seq4 SET parm3='~~    ~~super.next();~~super.next();' WHERE aseqno IN ('A180282');
COMMIT;
