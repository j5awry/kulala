; Real time LP analysis driven synthesizer
; multiple options for synthesis
; added pitch shifting via fft
; slightly volatile
; designed for integration with Max/MSP via CSound~
; working in:
; I Sing with the Steam
<CsoundSynthesizer>
    <CsInstruments>
        sr=44100
        ksmps=32
        nchnls=2

        instr 1

            ; p statements:
            ; p3 = duration of original recording
            ; p4 = analysis file number
            ; p5 = kanalErr switch -- noise vs. synth for more human like sound
            ; p6 = Synth Type. Wave terrain or buzz synth. 1 = WT. All others Buzz
            ; p7 = pitch shift amount. Any non-zero corresponds to a pitch shift.
            ;      most usable from .1 to 20 or so. Feel free to break this one
            ; p8 = WT table 1. value form 1 - 6
            ; p9 = WT table 2. value from 1 - 6
            ; p10 = WT Center outer limit. Starts at 1 and moves to p10
            ; p11 = amplitude multiplier. value from 0 to 1, best used between .1 and .6
            ; p12 = FM. Any non-zero adds FM to the synthesizers. Audible frequency does FM synth
            ; p13 = FM depth. value from > 0 to 32
            ; p14 = Reverb amplitude multiplier. Value from 0 to 1. Best practice is .1 - .5
            ; p15 = Reverb time in seconds. defined as the time in seconds for a signal to decay to 1/1000, or 60dB down from its original amplitude.
            ;       Best practice is short to medium (.1 to 2)
            ; p16 = read speed multiplier (speed up and down). best used between .01 - 10 (or so)
            ;       feel free to break this one. default is obviously 1.
            ;       0 is a bad thing to enter. negative has unknown consequences.
            ; p17 = scrub start time.
            ; p18 = scrub length. value is constrained to be LESS than original duration minus scrub start time
            ; p19 = envelope. 0 = noclick, 1 = long attack, 2 = long release, 3 = long attack long release, 4 = weird oscillating envelope
            ; p20 = apply lpreson or not. Makes the effect of the analysis slightly less (though not hugely)

            iFile = p4 ; analysis file number. corresponds to lp.p4
            iFileDur = p3 ; original file duration
            iNewDur = p3 * p16 ; new duration based on read speed. 0 is an invalid entry.
            iScrubEnd = p18; sets scrub end.
            
            ; scrub end point truncation. 
            ; if longer than the file duration, sets it to file duration.
            ; if iScrubEnd = 0, ends at length of file
            if iScrubEnd = 0 then
                iEndPoint = iFileDur
            else 
                iEndPoint = ((p17+p18) > iFileDur ? (iFileDur) : (p17 + p18)) 
            endif

            klineRead linseg p17, iNewDur, iEndPoint ; read of the lp analysis

            ; sets p3 to be the 
            p3 = p3 * p16

            ; Envelopes
            if p19 = 1 goto LongAttack
            if p19 = 2 goto LongRelease
            if p19 = 3 goto LongALongR
            if p19 = 4 goto Osciliting

            NoClicky:
                kEnv linseg  0, p3*.02, 1, p3*.96, 0, p3*.02, 0
                goto ReadAnalysis
            LongAttack:
                kEnv linseg 0, p3*.48, 1, p3*.48, 0, p3*.04, 0
                goto ReadAnalysis
            LongRelease:
                kEnv linseg 0, p3*.04, 1, p3*.48, 0, p3*.48, 0
                goto ReadAnalysis
            LongALongR:
                kEnv linseg 0, p3*.5, 1, p3*.5, 0
                goto ReadAnalysis
            Osciliting:
                kEnv linseg 0, p3/8, 1, p3/8, 0, p3/8, 1, p3/8, 0, p3/8, 1, p3/8, 0, p3/8, 1, p3/8, 0

            ReadAnalysis:
            kanalRMS1, kanalRMS2, kanalErr, kanalCPS lpread klineRead, iFile ; set variables from lpanalysis file
            
            if p12 > 0 then
                kFM oscili p13*1000, p12, 1
            else
                kFM oscili 500, 2, 1
            endif   
            
            if p6 = 1 kgoto WT ; switch for wave terrain or buzz
            kgoto Buzzer
            ; Wave Terrain Synthesizer.
            ; center moves from 1 to p10
            ; radius moves from .1 to p10/2
            ; p8 and p9 define tables
            ; slight reverb added for depth of sound
            WT:
                ; initialize values at i and k rates
                iCenter = p10
                kcx line 1, p3, iCenter
                krx linseg .1, p3/2, iCenter/2, p3/2, .1

                ;creates wave terrain synth
                aSig wterrain kanalRMS1, kanalCPS+kFM, kcx, kcx, -krx, krx, p8, p9

                ; creates reverb channel
                aVerb reverb aSig, 1 
                aVerb = aVerb * p14

                ; rough mix
                aMix1 = (aSig+aVerb)*.2

                aMix1 tone aMix1, 12000 

                a1 = aMix1

                kgoto Err

            
            Buzzer:
                aBuzz1 buzz kanalRMS1, kanalCPS+kFM, 50, 1

                aVerb reverb aBuzz1, 1
                aVerb = aVerb * p14

                aMix1 = (aBuzz1+aVerb)*.2
                a1 = aBuzz1

                kgoto Err
            Err:
            
            if kanalErr < p5 kgoto res

                a1 rand kanalRMS1

            if p20 == 0 kgoto SynthMixer

            res: 

                a1 lpreson a1

            SynthMixer: 
            if p6 = 1 kgoto WTMixin
            kgoto BuzzMixin

            WTMixin:
                a1 = (a1 + aMix1) * .3
                kgoto Gain
            BuzzMixin:
                a1 = (a1 + aBuzz1) * .3
                kgoto Gain

            Gain:
                a1 gain a1, kanalRMS2

            if p7 > 0 kgoto PShift
            kgoto OutSection

            PShift:
                kshift = (kanalCPS*p7)-kanalCPS
                fsig  pvsanal   a1, 2048, 1024, 2048, 1
                ftps  pvshift fsig, kshift, 20, .5
                a1 pvsynth   ftps
                a1 = a1 * .3

            OutSection:
                a1 gain a1, kanalRMS2
                a1 dam a1, 24575, 3, 1.2, .01, .2
                a1 = a1 * kEnv
                outch 1, a1*p11, 2, a1*p11

        endin

    </CsInstruments>
    <CsScore>
        f0 86400
        f1 0 16384 10 1
        f2 0 8193 6 0 1024 1 1024 .5 1024 -1 1024 -.5 1024 .25 1024 1 1024 -.25 1025 0; just a random exponential table
        f3 0 4096 10 1 0 .333 0 .2 0 .143 0 .111 0 .0909 0 .077 0 .0666 0 .0588 ; square
        f4 0 4096 10 1 .95 .9 .8 .85 .7 .75 .7 .65 .6 .55 .5 .45 .4 .35 .3 .25 .2 .15 .1 ; sawtooth
        f5 0 8193 6  0 2048 1 2048 -1 2048 1 2049 0; exponential sine wave
        f6  0   8193    21  3 1; noise 1

        e
</CsScore>
</CsoundSynthesizer>