       IDENTIFICATION DIVISION.
       PROGRAM-ID. SIMPLCNT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

           EXEC SQL INCLUDE SQLCA END-EXEC.

       01  WS-DEPT        PIC X(03).
       01  WS-COUNT       PIC S9(09) COMP.

           EXEC SQL DECLARE C1 CURSOR FOR
               SELECT WORKDEPT,
                      COUNT(*) OVER(PARTITION BY WORKDEPT)
                 FROM DSN8C10.EMP
           END-EXEC.

       PROCEDURE DIVISION.
           EXEC SQL OPEN C1 END-EXEC.

           PERFORM UNTIL SQLCODE NOT = 0
               EXEC SQL
                   FETCH C1 INTO :WS-DEPT, :WS-COUNT
               END-EXEC
               IF SQLCODE = 0
                   DISPLAY WS-DEPT ' ' WS-COUNT
               END-IF
           END-PERFORM.

           EXEC SQL CLOSE C1 END-EXEC.
           STOP RUN.
