       IDENTIFICATION DIVISION.
       PROGRAM-ID. DB2TRIM.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

           EXEC SQL INCLUDE SQLCA END-EXEC.

       01  WS-NAME       PIC X(20).

       PROCEDURE DIVISION.
           EXEC SQL
               SELECT TRIM(FIRSTNME)
                 INTO :WS-NAME
                 FROM DSN8C10.EMP
                WHERE EMPNO = '000010'
           END-EXEC.

           IF SQLCODE = 0
               DISPLAY WS-NAME
           END-IF.

           STOP RUN.
