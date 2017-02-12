<CsoundSynthesizer> 
    <CsInstruments>
        sr=44100
        ksmps=32
        nchnls=8
        0dbfs=1

        ; p3 = time/speed of elipses
        ; p4 = amplitude
        ; p5 = frequency
        ; p6 = verb time
        ; p7 = verb amplitude
        ; p8 = wterrain table 1
        ; p9 = wterrain table 2
        ; p10 = offswitch
        ; p11 = distance of center
        ; p12 = radius distance

        instr 1

            kAmp linseg 0, .1, p4
            kFreq = p5
            kVerbTime = p6
            kWet = p7
            kcx line .1, p3, p11
            krx linseg .1, p3/2, .5, p3/2, p12

            aSig wterrain kAmp, kFreq, kcx, kcx, -krx, krx, p8, p9

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = aSig+aVerb

            aMix1 tone aMix1, 14000
            aMix1 atone aMix1, 60

            aMix1 limit aMix1, 0, .8
            
            ihold

            if p10 == 0 kgoto OffSwitch
            kgoto Player

            OffSwitch:
                turnoff

            Player:
                outch 1, aMix1

        endin

        instr 2

            ; p3 = time/speed of elipses
            ; p4 = amplitude
            ; p5 = frequency
            ; p6 = verb time
            ; p7 = verb amplitude
            ; p8 = wterrain table 1
            ; p9 = wterrain table 2
            ; p10 = offswitch
            ; p11 = distance of center
            ; p12 = radius distance
            kAmp linseg 0, .4, p4
            kFreq = p5
            kVerbTime = p6
            kWet = p7
            kcx line .1, p3, p11
            krx linseg .1, p3/2, p12, p3/2, .1

            aSig wterrain kAmp, kFreq, kcx, kcx, -krx, krx, p8, p9

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = aSig+aVerb

            aMix1 tone aMix1, 14000
            aMix1 atone aMix1, 60

            aMix1 limit aMix1, 0, .8
            
            ihold

            if p10 == 0 kgoto OffSwitch
            kgoto Player

            OffSwitch:
                turnoff

            Player:
                outch 2, aMix1

        endin
        instr 3

            kAmp = p4
            kFreq = p5
            kVerbTime = p6
            kWet = p7
            kcx line .1, p3, p11
            krx linseg .1, p3/2, p12, p3/2, .1

            aSig wterrain kAmp, kFreq, kcx, kcx, -krx, krx, p8, p9

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = aSig+aVerb

            aMix1 tone aMix1, 14000
            aMix1 atone aMix1, 60

            aMix1 limit aMix1, 0, .8
            ihold

            if p10 == 0 kgoto OffSwitch
            kgoto Player

            OffSwitch:
                turnoff

            Player:
                outch 3, aMix1

        endin
        instr 4

            kAmp = p4
            kFreq = p5
            kVerbTime = p6
            kWet = p7
            kcx line .1, p3, p11
            krx linseg .1, p3/2, p12, p3/2, .1

            aSig wterrain kAmp, kFreq, kcx, kcx, -krx, krx, p8, p9

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = aSig+aVerb

            aMix1 tone aMix1, 14000
            aMix1 atone aMix1, 60

            aMix1 limit aMix1, 0, .8
            
            ihold

            if p10 == 0 kgoto OffSwitch
            kgoto Player

            OffSwitch:
                turnoff

            Player:
                outch 4, aMix1

        endin
        instr 5

            kAmp = p4
            kFreq = p5
            kVerbTime = p6
            kWet = p7
            kcx line .1, p3, p11
            krx linseg .1, p3/2, p12, p3/2, .1

            aSig wterrain kAmp, kFreq, kcx, kcx, -krx, krx, p8, p9

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = aSig+aVerb

            aMix1 tone aMix1, 14000
            aMix1 atone aMix1, 60

            aMix1 limit aMix1, 0, .8
            
            ihold

            if p10 == 0 kgoto OffSwitch
            kgoto Player

            OffSwitch:
                turnoff

            Player:
                outch 5, aMix1

        endin
        instr 6

            kAmp = p4
            kFreq = p5
            kVerbTime = p6
            kWet = p7
            kcx line .1, p3, p11
            krx linseg .1, p3/2, p12, p3/2, .1

            aSig wterrain kAmp, kFreq, kcx, kcx, -krx, krx, p8, p9

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = aSig+aVerb

            aMix1 tone aMix1, 14000
            aMix1 atone aMix1, 60

            aMix1 limit aMix1, 0, .8
            
            ihold

            if p10 == 0 kgoto OffSwitch
            kgoto Player

            OffSwitch:
                turnoff

            Player:
                outch 6, aMix1

        endin
        instr 7

            kAmp = p4
            kFreq = p5
            kVerbTime = p6
            kWet = p7
            kcx line .1, p3, p11
            krx linseg .1, p3/2, p12, p3/2, .1

            aSig wterrain kAmp, kFreq, kcx, kcx, -krx, krx, p8, p9

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = aSig+aVerb

            aMix1 tone aMix1, 14000
            aMix1 atone aMix1, 60

            aMix1 limit aMix1, 0, .8
            
            ihold

            if p10 == 0 kgoto OffSwitch
            kgoto Player

            OffSwitch:
                turnoff

            Player:
                outch 7, aMix1

        endin
        instr 8

            kAmp = p4
            kFreq = p5
            kVerbTime = p6
            kWet = p7
            kcx line .1, p3, p11
            krx linseg .1, p3/2, p12, p3/2, .1

            aSig wterrain kAmp*.1, kFreq, kcx, -kcx, -krx, krx, p8, p9

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = aSig+aVerb

            aMix1 tone aMix1, 14000
            aMix1 atone aMix1, 60
            
            ihold

            if p10 == 0 kgoto OffSwitch
            kgoto Player

            OffSwitch:
                turnoff

            Player:
                outch 8, aMix1

        endin

    </CsInstruments>

    <CsScore>
        f 0 86400
        f1 0 16384 10 1
        f2 0 16384 10 1 0.5 0.3 0.25 0.2 0.167 0.14 0.125 .111   ; Sawtooth
        f3  0   4096    10  1 0 .333 0 .2 0 .143 0 .111 0 .0909 0 .077 0 .0666 0 .0588 ; square
        f4  0   4096    9   1 1 0 3 .333 180 5 .2 0 7 .143 180 9 .111 0; every other reverses phase
        f5  0   4096    9   1.66 1 0 3.33 1 0; enharmonic 1
        f6  0   4096    9   1.25 1 0 4.25 1 0; enharmonic 2
        f7  0   8192    6   0 2048 1 2048 -1 2048 1 2049 0; exponential sine wave
        f8  0   8192    6   0 1024 1 1024 .5 1024 -1 1024 -.5 1024 .25 1024 1 1024 -.25 1025 0; just a random exponential table
        f9 0 513 13 1 1 0 0 0 -.1 0 .3 0 -.5 0 .7 0 -.9 0 1 0 -1 0; transfer function 2. doesn't sound very different.
        ;f9  0   4096    9   1.66 1 0 3.33 1 0; enharmonic 1
        e
    </CsScore>
</CsoundSynthesizer>

