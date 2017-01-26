<CsoundSynthesizer> 
    <CsInstruments>
        sr=44100
        ksmps=32
        nchnls=2
        0dbfs=1

        instr 1

            kFreq invalue "Freq"
            kAmp invalue "Amp"
            kWet invalue "Wet"
            kVerbTime invalue "VerbTime"
            iCenter = 10
            kcx line .1, iCenter, 1.9
            krx linseg .1, iCenter/2, .5, iCenter/2, .1

            aSig wterrain kAmp, kFreq, kcx, kcx, -krx, krx, 8, 3

            aVerb reverb aSig, kVerbTime
            aVerb = aVerb * kWet

            aMix1 = (aSig+aVerb)*.2

            aMix1 tone aMix1, 12000

            outch 1, aMix1, 2, aMix1

        endin

    </CsInstruments>

    <CsScore>
        f 0 86400
        f 1 0 16384 10 1
        f 2 0 8192  10 1 0 0.33 0 0.2 0 0.14 0 0.11
        f 3  0   4096    10  1 0 .333 0 .2 0 .143 0 .111 0 .0909 0 .077 0 .0666 0 .0588 ; square
        f 4  0   4096    9   1 1 0 3 .333 180 5 .2 0 7 .143 180 9 .111 0; every other reverses phase
        f 5  0   4096    9   1.66 1 0 3.33 1 0; enharmonic 1
        f 6  0   4096    9   1.25 1 0 4.25 1 0; enharmonic 2
        f 7  0   8193    6   0 2048 1 2048 -1 2048 1 2049 0; exponential sine wave
        f 8  0   8193    6   0 1024 1 1024 .5 1024 -1 1024 -.5 1024 .25 1024 1 1024 -.25 1025 0; just a random exponential table

        i1 0 86400
        e
    </CsScore>
</CsoundSynthesizer>

