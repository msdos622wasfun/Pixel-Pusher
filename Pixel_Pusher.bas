' *****************************************
'
' PIXEL PUSHER
'
' A simple graphics demo that creates its
' effect by moving many individual pixels
' around on the screen in different colors.
'
' Version 1.01 (for QB64)
'
' Copyleft 2020 by Erich Kohl
'
' Feel free to use this code.
'
' Send comments/questions to:
' ekohl1972@outlook.com
'
' *****************************************

CONST TRUE = -1
CONST FALSE = 0

DIM SHARED KEY_ENTER AS STRING
DIM SHARED KEY_ESC AS STRING
DIM SHARED KEY_SPACE AS STRING

DIM SHARED fnt1 AS LONG
DIM SHARED fnt2 AS LONG
DIM SHARED fnt3 AS LONG

Initialize
Main
Terminate

SYSTEM 0

SUB DemoLoop ()

    DIM x(1 TO 10000) AS INTEGER
    DIM y(1 TO 10000) AS INTEGER
    DIM colors(1 TO 10000) AS LONG
    DIM fast AS INTEGER
    DIM keyin AS STRING
    DIM a AS INTEGER
    DIM b AS INTEGER

    fast = FALSE

    CLS

    _FONT fnt3

    FOR a = 1 TO 2
        FOR b = 1 TO 7
            COLOR _RGB(INT(255 * RND + 1), INT(255 * RND + 1), INT(255 * RND + 1))
            _PRINTSTRING (60 + (400 * (ABS(a = 2))), b * 70), "PIXEL PUSHER"
        NEXT b
    NEXT a

    FOR a = 1 TO 10000
        x(a) = INT(800 * RND)
        y(a) = INT(600 * RND)
        colors(a) = _RGB(INT(255 * RND + 1), INT(255 * RND + 1), INT(255 * RND + 1))
    NEXT a

    DO
        FOR a = 1 TO 10000
            PSET (x(a), y(a)), colors(a)
        NEXT a
        _DISPLAY
        IF fast = FALSE THEN _DELAY .1
        keyin = INKEY$
        IF keyin = KEY_ESC THEN EXIT DO
        IF keyin = KEY_SPACE THEN fast = NOT fast
        FOR a = 1 TO 10000
            PSET (x(a), y(a)), _RGB(0, 0, 0)
        NEXT a
        FOR a = 1 TO 10000
            SELECT CASE INT(4 * RND + 1)
                CASE 1
                    x(a) = x(a) + 1
                CASE 2
                    x(a) = x(a) - 1
                CASE 3
                    y(a) = y(a) + 1
                CASE 4
                    y(a) = y(a) - 1
            END SELECT
        NEXT a
    LOOP

    _AUTODISPLAY

END SUB

SUB Initialize ()

    RANDOMIZE TIMER

    KEY_ENTER = CHR$(13)
    KEY_ESC = CHR$(27)
    KEY_SPACE = CHR$(32)

    fnt1 = _LOADFONT(ENVIRON$("SYSTEMROOT") + "\Fonts\Arial.ttf", 80)
    fnt2 = _LOADFONT(ENVIRON$("SYSTEMROOT") + "\Fonts\Arial.ttf", 20)
    fnt3 = _LOADFONT(ENVIRON$("SYSTEMROOT") + "\Fonts\Arial.ttf", 40)

END SUB

SUB Main ()

    DIM text AS STRING
    DIM left AS INTEGER
    DIM keyin AS STRING
    DIM t AS SINGLE

    _FULLSCREEN
    SCREEN _NEWIMAGE(800, 600, 32)
    _TITLE "Pixel Pusher"

    DO
        CLS
        DO
            COLOR _RGB(INT(255 * RND + 1), INT(255 * RND + 1), INT(255 * RND + 1))
            _FONT fnt1
            text = "PIXEL PUSHER"
            left = 400 - (_PRINTWIDTH(text) / 2)
            _PRINTSTRING (left, 150), text
            _FONT fnt2
            text = "Pixel Pusher Graphics Demo 1.01"
            left = 400 - (_PRINTWIDTH(text) / 2)
            _PRINTSTRING (left, 250), text
            text = "Copyleft 2020 by Erich Kohl"
            left = 400 - (_PRINTWIDTH(text) / 2)
            _PRINTSTRING (left, 300), text
            text = "Press Enter to begin the demo.  Press Esc to exit."
            left = 400 - (_PRINTWIDTH(text) / 2)
            _PRINTSTRING (left, 350), text
            text = "Press Space Bar during the demo to toggle normal/fast mode."
            left = 400 - (_PRINTWIDTH(text) / 2)
            _PRINTSTRING (left, 400), text
            t = TIMER
            DO
                keyin = INKEY$
            LOOP UNTIL keyin = KEY_ENTER OR keyin = KEY_ESC OR TIMER - t >= 1 OR TIMER < t
            IF keyin = KEY_ENTER THEN DemoLoop
        LOOP UNTIL keyin = KEY_ENTER OR keyin = KEY_ESC
    LOOP UNTIL keyin = KEY_ESC

END SUB

SUB Terminate ()

    SCREEN 0
    COLOR 7, 0
    CLS

END SUB

