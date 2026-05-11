       IDENTIFICATION DIVISION.
       PROGRAM-ID. DB2DECOD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

           EXEC SQL INCLUDE SQLCA END-EXEC.

       01  WS-EMPNO      PIC X(06) VALUE '000010'.
       01  WS-EDLABEL    PIC X(20).

       PROCEDURE DIVISION.
           EXEC SQL
               SELECT DECODE(EDLEVEL,
                             16, 'BACHELOR',
                             'OTHER')
                 INTO :WS-EDLABEL
                 FROM DSN8C10.EMP
                WHERE EMPNO = :WS-EMPNO
           END-EXEC.

           STOP RUN.
