<Cabbage> bounds(0, 0, 0, 0)
; GUI Initialization
form caption("Brendan's SubSynth") size(800, 500), colour(100, 122, 153), guiMode("queue"), pluginId("def1")
keyboard bounds(0, 406, 800, 95) channel("keyboard2") mouseOverKeyColour(0, 0, 255, 128) blackNoteColour(48, 64, 99, 255) whiteNoteColour(212, 212, 212, 255) keypressBaseOctave(6)

; Wave Selection 
groupbox bounds(4, 8, 120, 120) channel("groupbox10010") colour(0, 0, 0, 128) text("Wave") {
optionbutton bounds(20, 30, 80, 23) channel("waveform"), , corners(5), colour(0, 0, 255, 128) text("Saw", "Square", "Triangle")
rslider  bounds(16, 60, 40, 50), channel("pitch1"),  range(-12, 12, 0, 1, 1),  text("Pitch"),  , colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
rslider  bounds(65, 60, 40, 50), channel("fine1"),   range(-1,    1,     0,     1,     .001 ),  text("Fine"),   textBox(1), colour(0, 0, 255, 128), markerColour(0, 0, 0, 255), trackerColour(255, 255, 255, 255)
}
; ASDR Envelope
groupbox bounds(130, 8, 270, 120) channel("groupbox10009") text("Envelope") colour(0, 0, 0, 128) {
rslider bounds(20, 60, 50, 50), channel("att"), range(0.01, 1, 0.01, 1, 0.01), text("Attack") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(80, 60, 50, 50), channel("dec"), range(0.01, 1, 0.5, 1, 0.01), text("Decay") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(140, 60, 50, 50), channel("sus"), range(0.01, 1, 0.5, 1, 0.01), text("Sustain") markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) textColour(255, 255, 255, 255)
rslider bounds(200, 60, 50, 50), channel("rel"), range(0.01, 1, 0.7, 1, 0.01), text("Release") trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) textColour(255, 255, 255, 255)
}
; Filter 
groupbox bounds(406, 8, 140, 119) channel("groupbox10011") colour(0, 0, 0, 128) text("Filter") {
optionbutton bounds(20, 30, 102, 23) channel("filterType"), corners(5),  text("LowPass", "HighPass", "BandPass", "BandReject", "AllPass") colour:1(0, 0, 255, 128)
rslider bounds(14, 60, 54, 50), channel("cutoff"), range(0, 22000, 2000, 0.5, 0.01), text("Cut"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(72, 60, 54, 50), channel("res"), range(.01,  100,     .01,  1,    .01  ), text("Res"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
; LFO
groupbox bounds(552, 8, 80, 119)  channel("groupbox26") colour(0, 0, 0, 128) text("LFO")  {
rslider bounds(22, 20, 34, 50), channel("LFOFreq"), range(0, 10, 0, 1, 0.01), text("Freq"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(22, 65, 34, 50), channel("amp"), range(0, 1, 0.7, 1, 0.01), text("Amp"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
; Panning & Volume Control
groupbox bounds(638, 8, 150, 119) channel("groupbox10017") text("Options") colour(0, 0, 0, 128) {
rslider bounds(28, 20, 34, 50), channel("Panning"), range(0, 1, 0.5, 1, 0.01), text("Pan"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(28, 65, 34, 50), channel("Volume"), range(0, 2, 0.5, 1, 0.01), text("Gain"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(78, 37, 64, 64), channel("detune"), range(0, 2, 0, 1, 0.1), text("Detune"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
rslider bounds(150, 200, 50, 50), channel("Depth"), range(-1, 1, 0, 1, 0.1), text("Depth")
rslider bounds(200, 200, 50, 50), channel("Rate"), range(0, 22000, 440, 1, 0.1), text("Rate")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
/*-d -n */  -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 16
nchnls = 2
0dbfs = 1
massign 0, 1
;instrument will be triggered by keyboard widget
instr 1

; Pitch and Fine Tune Control
kpitch chnget "pitch1"
kfine chnget "fine1"
; Get midi note number using notnum
imidi notnum
; convert midi number to cycles per second ( frequency )
kcps cpsmidinn imidi
; Factor in the values of pitch and fine sliders
kcps = kcps*semitone(kpitch)*cent(kfine*100)

; Amplitude or Volume of the Note will come from the p-field assigned in <CsOptions>
iAmp = p5
; Envelope Control
iAtt chnget "att" ; Attack Mod
iDec chnget "dec" ; Decay Mod
iSus chnget "sus" ; Sustain Mod
iRel chnget "rel" ; Release Mod
; Filter Control
kRes chnget "res"
kCutOff chnget "cutoff"
iFType chnget "filterType"
; LFO Control
kLFOFreq chnget "LFOFreq"
kAmp chnget "amp"
; Options Control
kPan chnget "Panning"
kVol chnget "Volume"
kDet chnget "detune"
; Calculate classical ASDR Envelope
kEnv madsr iAtt, iDec, iSus, iRel, 0, 1  

kD chnget "Depth"
kR chnget "Rate"

kcps1 = kcps + kDet
kcps2 = kcps - kDet

iWaves[] fillarray 4, 10, 12
kPW init 0.25
printk2 kcps1
printk2 kcps2
if kDet > 0 then 
    aOut vco2 iAmp, kcps1, iWaves[chnget:i("waveform")], kPW
    aOut2 vco2 iAmp, kcps2, iWaves[chnget:i("waveform")], kPW
elseif kDet == 0 then
    aOut vco2 iAmp, kcps, iWaves[chnget:i("waveform")], kPW
    aOut2 vco2 iAmp, kcps, iWaves[chnget:i("waveform")], kPW
endif
aOut = aOut * kVol
aOut2 = aOut2 * kVol
kord init 8
kfdbk init 0.5
kPLFO lfo kD*0.5, kR, 0
kPLFO2 lfo kD*0.5, kR, 0
aP phaser1 aOut, kPLFO+(kDepth * 0.5), kord, kfdbk
aP2 phaser1 aOut2, kPLFO2+(kDepth * 0.5), kord, kfdbk
kLFO lfo kAmp, kLFOFreq, 0
kLFO2 lfo kAmp, kLFOFreq, 0
kLFO *= 0.5
kLFO += 0.5
kLFO2 *= 0.5
kLFO2 += 0.5
aFilt bqrez aP, kCutOff*kLFO, kRes, iFType
aFilt2 bqrez aP2, kCutOff *kLFO2, kRes, iFType
aL2, aR2 pan2 aFilt2*kEnv, kPan
aL, aR pan2 aFilt*kEnv, kPan
outs aL + aL2, aR + aR2

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
