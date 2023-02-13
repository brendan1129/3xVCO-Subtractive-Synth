<Cabbage> bounds(0, 0, 0, 0)
form caption("Brendan's SubSynth") size(800, 500), colour(100, 122, 153), guiMode("queue"), pluginId("def1")
keyboard bounds(0, 406, 800, 95) channel("keyboard2") mouseOverKeyColour(0, 0, 255, 128) blackNoteColour(48, 64, 99, 255) whiteNoteColour(212, 212, 212, 255) keypressBaseOctave(6)
groupbox bounds(190, 12, 270, 120) channel("groupbox10009") text("Envelope") colour(0, 0, 0, 128) {
rslider bounds(20, 60, 50, 50), channel("att"), range(0, 1, 0.01, 1, 0.01), text("Attack") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(80, 60, 50, 50), channel("dec"), range(0, 1, 0.5, 1, 0.01), text("Decay") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(140, 60, 50, 50), channel("sus"), range(0, 1, 0.5, 1, 0.01), text("Sustain") markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) textColour(255, 255, 255, 255)
rslider bounds(200, 60, 50, 50), channel("rel"), range(0, 1, 0.7, 1, 0.01), text("Release") trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) textColour(255, 255, 255, 255)
}
groupbox bounds(24, 12, 146, 120) channel("groupbox10010") colour(0, 0, 0, 128) text("Wave") {
optionbutton bounds(16, 30, 113, 23) channel("waveform"), , corners(5), colour(0, 0, 255, 128) text("Sin","Saw", "Square", "Pulse")
rslider  bounds(16, 60, 40, 50), channel("pitch1"),  range(-12, 12, 0, 1, 1),  text("Pitch"),  , colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
rslider  bounds(90, 60, 40, 50), channel("fine1"),   range(-1,    1,     0,     1,     .001 ),  text("Fine"),   textBox(1), colour(0, 0, 255, 128), markerColour(0, 0, 0, 255), trackerColour(255, 255, 255, 255)
}
groupbox bounds(480, 12, 298, 120) channel("groupbox10011") colour(0, 0, 0, 128) text("LFO") {
optionbutton bounds(88, 30, 113, 23) channel("lfoType"), corners(5), colour(0, 0, 255, 128) text("Sine", "Triangle", "Bipolar", "Unipolar", "Saw", "Saw-Down" )
rslider bounds(16, 60, 40, 50), channel("cutoff"), range(0, 22000, 2000, 0.5, 0.01), text("Cut-Off")
rslider bounds(90, 60, 40, 50), channel("res"), range(0, 1, 0.7, 1, 0.01), text("Resonance")
rslider bounds(160, 60, 40, 50), channel("LFOFreq"), range(0, 10, 0, 1, 0.01), text("LFO Freq")
rslider bounds(240, 60, 40, 50), channel("amp"), range(0, 1, 0.7, 1, 0.01), text("Amp")
}
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
/*-d -n */  -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1
massign 0, 1

;instrument will be triggered by keyboard widget
instr 1

kpitch chnget "pitch1"
kfine chnget "fine1"
imidi notnum
kcps cpsmidinn imidi+kpitch+kfine
kpb pchbend -24, 24
kcps = kcps + kpb

iFreq = p4
iAmp = p5
iAtt chnget "att" ; Attack Mod
iDec chnget "dec" ; Decay Mod
iSus chnget "sus" ; Sustain Mod
iRel chnget "rel" ; Release Mod

kRes chnget "res"
kCutOff chnget "cutoff"
kLFOFreq chnget "LFOFreq"
kAmp chnget "amp"

kEnv madsr iAtt, iDec, iSus, iRel  ; Calculate classical ASDR Envelope

aOut poscil iAmp, kcps, chnget:i("waveform")+1
kLFO lfo 1, kLFOFreq, 5
aLP butterlp aOut, kCutOff*kLFO
outs aLP*kEnv, aLP*kEnv

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f1 0 4096 10 1 ; sine wave
f2 0 4096 10 1 .5 ; saw wave
f3 0 4096 10 1 .5 .2 .1 ;square wave
f4 0 4096 10 1 1   1   1    0.7 0.5   0.3  0.1 ; pulse wave
f0 z
</CsScore>
</CsoundSynthesizer>
