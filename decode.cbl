       IDENTIFICATION DIVISION.
       PROGRAM-ID. DB2DECOD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

           EXEC SQL INCLUDE SQLCA END-EXEC.

       01  WS-EMPNO      PIC X(06).
       01  WS-EDLABEL    PIC X(20).

           EXEC SQL DECLARE C1 CURSOR FOR
               SELECT EMPNO,
                      DECODE(EDLEVEL,
                             16, 'BACHELOR',
                             18, 'MASTER',
                             20, 'DOCTORATE',
                             'OTHER')
                 FROM DSN8C10.EMP
           END-EXEC.

       PROCEDURE DIVISION.
       MAIN-PARA.

           EXEC SQL OPEN C1 END-EXEC.

           PERFORM FETCH-ROW UNTIL SQLCODE NOT = 0.

           EXEC SQL CLOSE C1 END-EXEC.

           STOP RUN.

       FETCH-ROW.
           EXEC SQL
               FETCH C1
                INTO :WS-EMPNO,
                     :WS-EDLABEL
           END-EXEC.

           IF SQLCODE = 0
               DISPLAY 'EMP=' WS-EMPNO
                       ' EDUCATION=' WS-EDLABEL
           END-IF.
