<CsoundSynthesizer> 
    <CsInstruments>
        sr=44100
        ksmps=32
        nchnls=2
        0dbfs=1

        instr 1
            kFreq invalue "sine1Freq"
            kAmp invalue "sine1Amp"
            aSine1 oscil kAmp, kFreq, 1
            outch 1, aSine1, 2, aSine1

        endin

    </CsInstruments>

    <CsScore>
        f1  0   8192    10  1
        i1 0 86400
        e
    </CsScore>
</CsoundSynthesizer>

