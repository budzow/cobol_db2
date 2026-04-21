       IDENTIFICATION DIVISION.
       PROGRAM-ID. DB2WINFN.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

           EXEC SQL INCLUDE SQLCA END-EXEC.

       01  WS-DEPT        PIC X(10).
       01  WS-EMPNO       PIC X(06).
       01  WS-DEPT-COUNT  PIC S9(09) COMP.

           EXEC SQL DECLARE C1 CURSOR FOR
               SELECT EMPNO,
                      WORKDEPT,
                      COUNT(*) OVER(PARTITION BY WORKDEPT)
                        AS DEPT_COUNT
                 FROM DSN8C10.EMP
                ORDER BY WORKDEPT, EMPNO
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
                     :WS-DEPT,
                     :WS-DEPT-COUNT
           END-EXEC.

           IF SQLCODE = 0
               DISPLAY 'EMP=' WS-EMPNO
                       ' DEPT=' WS-DEPT
                       ' DEPT_COUNT=' WS-DEPT-COUNT
           END-IF.
