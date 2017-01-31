<CsoundSynthesizer>
    <CsOptions>
    -W -otest123456.wav
    </CsOptions>
    <CsInstruments>
        sr=44100
        ksmps=32
        nchnls=2

        instr 1

            ;iDur chnget "duration"
            ;SFile chnget "file"
            iDur = p3
            iFile = p4
            ;SFile = "/Users/jchittum/dev01/MaxShit/Testing/test.analysis"
            ;iFile = "/Users/jchittum/dev01/MaxShit/Testing/test.analysis"
            ;puts SFile
            print iDur
            print iFile

            klineRead linseg 0, iDur, iDur

            kanalRMS1, kanalRMS2, kanalErr, kanalCPS lpread klineRead, iFile
            
            if p6 = 1 kgoto WT
            kgoto Buzzer

            WT:
                iCenter = 10
                kcx line .1, iCenter, 1.9
                krx linseg .1, iCenter/2, .5, iCenter/2, .1

                aSig wterrain kanalRMS1, kanalCPS, kcx, kcx, -krx, krx, 2, 3

                aVerb reverb aSig, 1
                aVerb = aVerb * .3

                aMix1 = (aSig+aVerb)*.2

                aMix1 tone aMix1, 12000 

                a1 = aMix1

                kgoto Err

            
            Buzzer:
                aBuzz1 buzz kanalRMS1, kanalCPS, 50, 1
                a1 = aBuzz1
            Err:
            
            if kanalErr < p5 kgoto res

                a1 rand kanalRMS1

            res: 

                a1 lpreson a1

            if p6 = 1 kgoto WTMixin
            kgoto BuzzMixin

            WTMixin:
                a1 = (a1 + aMix1) * .5
                kgoto OutSection
            BuzzMixin:
                a1 = (a1 + aBuzz1) * .5

            OutSection:
                a1 gain a1, kanalRMS2

                outch 1, a1*.3, 2, a1*.3
                ;aMix1 gain aMix1, kanalRMS2
                ;aBuzz1 gain aBuzz1, kanalRMS2
                ;outch 1, aMix1*4, 2, aBuzz1*4

        endin

    </CsInstruments>
    <CsScore>
        f0 86400
        f1 0 16384 10 1
        f2 0 8193 6 0 1024 1 1024 .5 1024 -1 1024 -.5 1024 .25 1024 1 1024 -.25 1025 0; just a random exponential table
        f3 0 4096 10 1 0 .333 0 .2 0 .143 0 .111 0 .0909 0 .077 0 .0666 0 .0588 ; square

        ;i1 0 10 103 2 1
        ;i1 11 10 103 2 2
        e
</CsScore>
</CsoundSynthesizer>