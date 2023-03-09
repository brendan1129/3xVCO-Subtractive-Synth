/*  bounds(0, 0, 0, 0)
------------------------------------
Title: 3xVCO Subtractive Synthesizer
------------------------------------

---------------------------------------------------------------------------------------------
Author: Brendan Hannum, senior-level Computer Science student at Saint Joseph's University
---------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------
Description: 

The purpose of this project is to give my best attempt at recreating the 3x Oscillator by 
Image-Line, the company behind FL Studio. There are a few key features missing from here that are available
in the 3xOsc, which I will list below:

    - Phase Offset Control for each wave
    - Invert Phase Option for each wave
    - Sine, Rounded Saw, Noise, and Custom as options for generatable waves
    - AM OSC 3, which converts the third oscillator into an amplitude modulator for the first two oscillators
    - HQ Option which provides anti-aliasing for the oscillators from 15Hz to 20kHz

Admittedly, a portion of these features are missing due to my own shortcomings and lack of expertise in the CSound language.
However, thanks to numerous contributors in the languages community, I was able to implement other features which are not directly available 
in the 3xOsc. I will also list these capabilities below:

    - Resonant High and Low pass filter
    - ASDR Envelope
    - Low-Frequency Oscillation (LFO) 
    
I am very pleased with the results thus far, but I am also aware there is much more that could be done. 
I plan to continue working on this and refining it. With the possibility of adding new features as I gain more experience with CSound and Cabbage.
--------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------
Acknowledgements:

I was absolutely astounded by the resources that I was able to obtain surrounding this subject of audio programming. 
The community has been running strong for decades now, and still I was able to come into personal contact with key contributors of CSound 
on multiple occasions. The following people are almost entirely responsible for what I learned and was able to create here:

    - Rory Walsh, Lead Developer of Cabbage and extremely helpful community member
    - Iain McCurdy, Sound Designer of Cabbage and author of numerous examples I was able to extract knowledge from
    - Gordon Boyle, Web Developer of Cabbage 
    - Steven Yi, Accomplished Developer of CSound and responsible for introducing me to features of the language through his YouTube channel
--------------------------------------------------------------------------------------------------------------------------------------------
*/
<Cabbage> bounds(0, 0, 0, 0)
; GUI Initialization
form caption("3xVCO") size(1000, 525), colour(100, 122, 153), guiMode("queue"), pluginId("def1")
image bounds(0, 0, 1000, 525) file("synthbg.png") channel("image50")
keyboard bounds(0, 430, 1000, 95) channel("keyboard2") mouseOverKeyColour(0, 0, 255, 128) blackNoteColour(48, 64, 99, 255) whiteNoteColour(212, 212, 212, 255) keypressBaseOctave(6)

combobox bounds(325, 388, 142, 29), populate("*.snaps"), channelType("string") automatable(0) channel("combo52") value("0")
filebutton bounds(256, 388, 64, 29), text("Save", "Save"), populate("*.snaps", "test"), mode("named preset") channel("filebutton53")
filebutton bounds(472, 388, 60, 29), text("Remove", "Remove"), populate("*.snaps", "test"), mode("remove preset") channel("filebutton54")

groupbox bounds(794, 8, 201, 40) channel("groupbox10001") colour(0, 0, 0, 128) text("Master") {
}
groupbox bounds(794, 54, 201, 100) channel("groupbox10000") colour(0, 0, 0, 128) text("Reverb") {
rslider bounds(20, 30, 80, 52), text("Room Size"), channel("roomsize"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), imgFile("Slider", "knob2.jpeg")
rslider bounds(100, 30, 80, 52), text("Damp"), channel("reverbfreq"), range(20, 22000, 3000, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
}
groupbox bounds(794, 160, 201, 165) channel("groupbox10002") colour(0, 0, 0, 128) text("Delay") {
rslider bounds(5, 31, 80, 53), text("Time"), channel("time"), range(0.01, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
rslider bounds(60, 31, 80, 53), text("FDBK"), channel("fdbk"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
rslider bounds(115, 31, 80, 53), text("Mix"), channel("mix"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
}
;|---------------------------------------------START WAVE #1---------------------------------------------|
; Wave Selection #1
groupbox bounds(4, 8, 120, 120) channel("groupbox10010") colour(0, 0, 0, 128) text("Wave") {
optionbutton bounds(20, 30, 80, 23) channel("waveform"), , corners(5), colour(0, 0, 255, 128) text("Saw", "Square", "Triangle")
rslider  bounds(16, 60, 40, 50), channel("pitch1"),  range(-24, 24, 0, 1, 1),  text("Pitch"),  , colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
rslider  bounds(65, 60, 40, 50), channel("fine1"),   range(-1,    1,     0,     1,     .001 ),  text("Fine"),   textBox(1), colour(0, 0, 255, 128), markerColour(0, 0, 0, 255), trackerColour(255, 255, 255, 255)
}
; ASDR Envelope #1
groupbox bounds(130, 8, 270, 120) channel("groupbox100011") text("Envelope") colour(0, 0, 0, 128) {
rslider bounds(20, 45, 50, 50), channel("att"), range(0.01, 1, 0.01, 1, 0.01), text("Attack") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(80, 45, 50, 50), channel("dec"), range(0.01, 1, 0.5, 1, 0.01), text("Decay") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(140, 45, 50, 50), channel("sus"), range(0, 1, 0.5, 1, 0.01), text("Sustain") markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) textColour(255, 255, 255, 255)
rslider bounds(200, 45, 50, 50), channel("rel"), range(0.01, 1, 0.7, 1, 0.01), text("Release") trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) textColour(255, 255, 255, 255)
}
; Filter #1
groupbox bounds(406, 8, 140, 119) channel("groupbox10012") colour(0, 0, 0, 128) text("Filter") {
optionbutton bounds(20, 30, 102, 23) channel("filterType"), corners(5),  text("LowPass", "HighPass") colour:1(0, 0, 255, 128)
rslider bounds(14, 60, 54, 50), channel("cutoff"), range(0, 22000, 2000, 0.5, 0.01), text("Cut"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(72, 60, 54, 50), channel("res"), range(1,  100, 1,  1,    .01  ), text("Res"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
; LFO #1
groupbox bounds(552, 8, 80, 119)  channel("groupbox10013") colour(0, 0, 0, 128) text("LFO")  {
rslider bounds(22, 20, 34, 50), channel("LFOFreq"), range(0, 10, 0, 1, 0.01), text("Freq"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(22, 65, 34, 50), channel("amp"), range(0, 1, 0.7, 1, 0.01), text("Amp"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
; Panning & Volume Control #1
groupbox bounds(638, 8, 150, 119) channel("groupbox10014") text("Options") colour(0, 0, 0, 128) {
rslider bounds(28, 20, 34, 50), channel("Panning"), range(0, 1, 0.5, 1, 0.01), text("Pan"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(28, 65, 34, 50), channel("Volume"), range(0, 1.25, 0.75, 1, 0.01), text("Gain"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
vslider bounds(78, 27, 70, 84), channel("detune"), range(-1, 1, 0, 1, 0.1), text("Detune"), colour(0, 0, 255, 128) markerColour(100, 100, 100, 255) trackerThickness(0.05) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
;|---------------------------------------------END WAVE #1---------------------------------------------|

;|---------------------------------------------START WAVE #2---------------------------------------------|
; Wave Selection #2
groupbox bounds(4, 132, 120, 120) channel("groupbox10021") colour(0, 0, 0, 128) text("Wave") {
optionbutton bounds(20, 30, 80, 23) channel("waveform2"), , corners(5), colour(0, 0, 255, 128) text("Saw", "Square", "Triangle")
rslider  bounds(16, 60, 40, 50), channel("pitch2"),  range(-24, 24, 0, 1, 1),  text("Pitch"),  , colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
rslider  bounds(65, 60, 40, 50), channel("fine2"),   range(-1,    1,     0,     1,     .001 ),  text("Fine"),   textBox(1), colour(0, 0, 255, 128), markerColour(0, 0, 0, 255), trackerColour(255, 255, 255, 255)
}
; ASDR Envelope #2
groupbox bounds(130, 132, 270, 120) channel("groupbox10022") text("Envelope") colour(0, 0, 0, 128) {
rslider bounds(20, 45, 50, 50), channel("att2"), range(0.01, 1, 0.01, 1, 0.01), text("Attack") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(80, 45, 50, 50), channel("dec2"), range(0.01, 1, 0.5, 1, 0.01), text("Decay") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(140, 45, 50, 50), channel("sus2"), range(0, 1, 0.5, 1, 0.01), text("Sustain") markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) textColour(255, 255, 255, 255)
rslider bounds(200, 45, 50, 50), channel("rel2"), range(0.01, 1, 0.7, 1, 0.01), text("Release") trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) textColour(255, 255, 255, 255)
}
; Filter #2
groupbox bounds(406, 132, 140, 119) channel("groupbox10023") colour(0, 0, 0, 128) text("Filter") {
optionbutton bounds(20, 30, 102, 23) channel("filterType2"), corners(5),  text("LowPass", "HighPass") colour:1(0, 0, 255, 128)
rslider bounds(14, 60, 54, 50), channel("cutoff2"), range(0, 22000, 2000, 0.5, 0.01), text("Cut"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(72, 60, 54, 50), channel("res2"), range(.01,  1,     .01,  1,    .01  ), text("Res"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
; LFO #2
groupbox bounds(552, 132, 80, 119)  channel("groupbox10024") colour(0, 0, 0, 128) text("LFO")  {
rslider bounds(22, 20, 34, 50), channel("LFOFreq2"), range(0, 10, 0, 1, 0.01), text("Freq"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(22, 65, 34, 50), channel("amp2"), range(0, 1, 0.7, 1, 0.01), text("Amp"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
; Panning & Volume Control #2
groupbox bounds(638, 132, 150, 119) channel("groupbox10025") text("Options") colour(0, 0, 0, 128) {
rslider bounds(28, 20, 34, 50), channel("Panning2"), range(0, 1, 0.5, 1, 0.01), text("Pan"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(28, 65, 34, 50), channel("Volume2"), range(0, 1.25, 0, 1, 0.01), text("Gain"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
vslider bounds(78, 27, 70, 84), channel("detune2"), range(-1, 1, 0, 1, 0.1), text("Detune"), colour(0, 0, 255, 128) markerColour(100, 100, 100, 255) trackerThickness(0.05) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
;|---------------------------------------------END WAVE #2---------------------------------------------|

;|---------------------------------------------START WAVE #3---------------------------------------------|
; Wave Selection #3
groupbox bounds(4, 256, 120, 120) channel("groupbox10031") colour(0, 0, 0, 128) text("Wave") {
optionbutton bounds(20, 30, 80, 23) channel("waveform3"), , corners(5), colour(0, 0, 255, 128) text("Saw", "Square", "Triangle")
rslider  bounds(16, 60, 40, 50), channel("pitch3"),  range(-24, 24, 0, 1, 1),  text("Pitch"),  , colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255)
rslider  bounds(65, 60, 40, 50), channel("fine3"),   range(-1,    1,     0,     1,     .001 ),  text("Fine"),   textBox(1), colour(0, 0, 255, 128), markerColour(0, 0, 0, 255), trackerColour(255, 255, 255, 255)
}
; ASDR Envelope #3
groupbox bounds(130, 256, 270, 120) channel("groupbox10032") text("Envelope") colour(0, 0, 0, 128) {
rslider bounds(20, 45, 50, 50), channel("att3"), range(0.01, 1, 0.01, 1, 0.01), text("Attack") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(80, 45, 50, 50), channel("dec3"), range(0.01, 1, 0.5, 1, 0.01), text("Decay") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(140, 45, 50, 50), channel("sus3"), range(0, 1, 0.5, 1, 0.01), text("Sustain") markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) textColour(255, 255, 255, 255)
rslider bounds(200, 45, 50, 50), channel("rel3"), range(0.01, 1, 0.7, 1, 0.01), text("Release") trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) textColour(255, 255, 255, 255)
}
; Filter #3
groupbox bounds(406, 256, 140, 119) channel("groupbox10033") colour(0, 0, 0, 128) text("Filter") {
optionbutton bounds(20, 30, 102, 23) channel("filterType3"), corners(5),  text("LowPass", "HighPass") colour:1(0, 0, 255, 128)
rslider bounds(14, 60, 54, 50), channel("cutoff3"), range(0, 22000, 2000, 0.5, 0.01), text("Cut"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(72, 60, 54, 50), channel("res3"), range(.01,  1,     .01,  1,    .01  ), text("Res"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
; LFO #3
groupbox bounds(552, 256, 80, 119)  channel("groupbox10034") colour(0, 0, 0, 128) text("LFO")  {
rslider bounds(22, 20, 34, 50), channel("LFOFreq3"), range(0, 10, 0, 1, 0.01), text("Freq"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(22, 65, 34, 50), channel("amp3"), range(0, 1, 0.7, 1, 0.01), text("Amp"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
; Panning & Volume Control #3
groupbox bounds(638, 256, 150, 119) channel("groupbox10035") text("Options") colour(0, 0, 0, 128) {
rslider bounds(28, 20, 34, 50), channel("Panning3"), range(0, 1, 0.5, 1, 0.01), text("Pan"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
rslider bounds(28, 65, 34, 50), channel("Volume3"), range(0, 1.25, 0, 1, 0.01), text("Gain"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
vslider bounds(78, 27, 70, 84), channel("detune3"), range(-1, 1, 0, 1, 0.1), text("Detune"), colour(0, 0, 255, 128) markerColour(100, 100, 100, 255) trackerThickness(0.05) trackerColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
}
;|---------------------------------------------END WAVE #3---------------------------------------------|
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
;massign 0, 5

gaReverbSendL init 0
gaReverbSendR init 0

gaLofiSendL init 0
gaLofiSendR init 0

gkcps1 init 0
gkcps2 init 0

opcode	LoFi,a,akk
	ain,kbits,kfold	xin									;READ IN INPUT ARGUMENTS
	kvalues		pow		2, kbits					;RAISES 2 TO THE POWER OF kbitdepth. THE OUTPUT VALUE REPRESENTS THE NUMBER OF POSSIBLE VALUES AT THAT PARTICULAR BIT DEPTH
	aout		=	(int((ain/0dbfs)*kvalues))/kvalues	;BIT DEPTH REDUCE AUDIO SIGNAL
	aout		fold 	aout, kfold							;APPLY SAMPLING RATE FOLDOVER
		xout	aout									;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

;instrument will be triggered by keyboard widget
instr 1


; Each Oscillator operation is seperated by an entire line.
; One signal must be produced per channel ( to achieve stereo effects )
; Pitch and Fine Tune Control
kpitch chnget "pitch1"
kfine chnget "fine1"

kpitch2 chnget "pitch2"
kfine2 chnget "fine2"

kpitch3 chnget "pitch3"
kfine3 chnget "fine3"
; Get midi note number using notnum
imidi notnum
; convert midi number to cycles per second ( frequency )
kcps = p4

kcps2 = p4

kcps3 = p4
; Factor in the values of pitch and fine sliders
kcps = kcps*semitone(kpitch)*cent(kfine*100)

kcps20 = kcps2*semitone(kpitch2)*cent(kfine2*100)

kcps30 = kcps3*semitone(kpitch3)*cent(kfine3*100)
; Amplitude or Volume of the Note will come from the p-field assigned in <CsOptions>
iAmp = p5
; Envelope Control
iAtt chnget "att" ; Attack Mod
iDec chnget "dec" ; Decay Mod
iSus chnget "sus" ; Sustain Mod
iRel chnget "rel" ; Release Mod

iAtt2 chnget "att2"
iDec2 chnget "dec2"
iSus2 chnget "sus2"
iRel2 chnget "rel2"

iAtt3 chnget "att3"
iDec3 chnget "dec3"
iSus3 chnget "sus3"
iRel3 chnget "rel3"
; Filter Control
kRes chnget "res"
kCutOff chnget "cutoff"
iFType chnget "filterType"

kRes2 chnget "res2"
kCutOff2 chnget "cutoff2"
iFType2 chnget "filterType2"

kRes3 chnget "res3"
kCutOff3 chnget "cutoff3"
iFType3 chnget "filterType3"
; LFO Control
kLFOFreq chnget "LFOFreq"
kAmp chnget "amp"

kLFOFreq2 chnget "LFOFreq2"
kAmp2 chnget "amp2"

kLFOFreq3 chnget "LFOFreq3"
kAmp3 chnget "amp3"
; Options Control
kPan chnget "Panning"
kVol chnget "Volume"
kDet chnget "detune"

kPan2 chnget "Panning2"
kVol2 chnget "Volume2"
kDet2 chnget "detune2"

kPan3 chnget "Panning3"
kVol3 chnget "Volume3"
kDet3 chnget "detune3"

khighend chnget "highend"
klowend chnget "lowend"
kharmonics chnget "harmonics"
kblend chnget "blend"


; Calculate classical ASDR Envelope
kEnv madsr iAtt, iDec, iSus, iRel, 0, 1  

kEnv2 madsr iAtt2, iDec2, iSus2, iRel2, 0, 1

kEnv3 madsr iAtt3, iDec3, iSus3, iRel3, 0, 1
; Detune by duplicating frequency signal and offsetting by an inverted, constant rate


kcps1 = kcps + kDet
kcps2 = kcps - kDet

kcps21 = kcps20 + kDet2
kcps22 = kcps20 + kDet2

kcps31 = kcps30 + kDet3
kcps32 = kcps30 + kDet3

gkcps1 = kcps1
gkcps2 = kcps2
; Fill array with VCO2 options: Integrated Saw, Square, and Triangle
iWaves[] fillarray 8, 10, 12
; init Pulse Width for "thicker" sounds
kPW init 0.5
; Two signals for each channel output 
aOut vco2 iAmp, kcps1, iWaves[chnget:i("waveform")], kPW
aOut2 vco2 iAmp, kcps2, iWaves[chnget:i("waveform")], kPW

aOut21 vco2 iAmp, kcps21, iWaves[chnget:i("waveform2")], kPW
aOut22 vco2 iAmp, kcps22, iWaves[chnget:i("waveform2")], kPW

aOut31 vco2 iAmp, kcps31, iWaves[chnget:i("waveform3")], kPW
aOut32 vco2 iAmp, kcps32, iWaves[chnget:i("waveform3")], kPW

; add 'brightness' to audio signal
    kfeedback chnget "feedback"
    kQ init 0.75
    kOrd init 8
    kMode init 1
    kSep init 2
    aPhaseL phaser2 aOut, khighend, kQ, kOrd, kMode, kSep, kfeedback
    aPhaseR phaser2 aOut2, khighend, kQ, kOrd, kMode, kSep, kfeedback
; Modify by volume
aOut = (aOut + aPhaseL) * kVol
aOut2 = (aOut2 + aPhaseR) * kVol

aOut21 = aOut21 * kVol2
aOut22 = aOut22 * kVol2

aOut31 = aOut31 * kVol3
aOut32 = aOut32 * kVol3
; LFO which oscillates between + and - value of defined frequency
kLFO lfo kAmp, kLFOFreq, 0
kLFO2 lfo kAmp, kLFOFreq, 0

kLFO21 lfo kAmp2, kLFOFreq2, 0
kLFO22 lfo kAmp2, kLFOFreq2, 0

kLFO31 lfo kAmp3, kLFOFreq3, 0
kLFO32 lfo kAmp3, kLFOFreq3, 0
; Tweaking LFO to avoid thumping result
kLFO *= 0.5
kLFO += 0.5
kLFO2 *= 0.5
kLFO2 += 0.5

kLFO21 *= 0.5
kLFO21 += 0.5
kLFO22 *= 0.5
kLFO22 += 0.5

kLFO31 *= 0.5
kLFO31 += 0.5
kLFO32 *= 0.5
kLFO32 += 0.5
; Rezzy filter applied with LFO
iFilters[] fillarray 0, 1
aFilt rezzy aOut, kCutOff*kLFO, kRes, iFilters[iFType]
aFilt2 rezzy aOut2, kCutOff *kLFO2, kRes, iFilters[iFType]

aFilt21 rezzy aOut21, kCutOff2*kLFO21, kRes2, iFilters[iFType2]
aFilt22 rezzy aOut22, kCutOff2 *kLFO22, kRes2, iFilters[iFType2]

aFilt31 rezzy aOut31, kCutOff3*kLFO31, kRes3, iFilters[iFType3]
aFilt32 rezzy aOut32, kCutOff3 *kLFO32, kRes3, iFilters[iFType3]
; Panning applied to each signal
aL, aR pan2 aFilt*kEnv, kPan
aL2, aR2 pan2 aFilt2*kEnv, kPan

aL21, aR21 pan2 aFilt21*kEnv2, kPan2
aL22, aR22 pan2 aFilt22*kEnv2, kPan2

aL31, aR31 pan2 aFilt31*kEnv3, kPan3
aL32, aR32 pan2 aFilt32*kEnv3, kPan3
; Add both signals back together on output
;aFinalL, aFinalR reverbsc (aL + aL2), aR + aR2, kroomsize, kreverbfreq
aFinalOutL = (aL + aL2) + (aL21 + aL22) + (aL31 + aL32)
aFinalOutR = (aR + aR2) + (aR21 + aR22) + (aR31 + aR32)

outs aFinalOutL * .33, aFinalOutR * .33

gaLofiSendL = (gaLofiSendL/2) + ((aL + aL2) + (aL21 + aL22) + (aL31 + aL32))
gaLofiSendR = (gaLofiSendR/2) + ((aR + aR2) + (aR21 + aR22) + (aR31 + aR32))
;outs aFinalL, aFinalR
gaReverbSendL = gaReverbSendL + ((aL + aL2) + (aL21 + aL22) + (aL31 + aL32))
gaReverbSendR = gaReverbSendR + ((aR + aR2) + (aR21 + aR22) + (aR31 + aR32))

endin

; Reverb Unit
instr 5
    kroomsize chnget "roomsize"
    kreverbfreq chnget "reverbfreq"
    aRL, aRR reverbsc gaReverbSendL, gaReverbSendR, kroomsize, kreverbfreq
    outs aRL, aRR
    clear gaReverbSendL, gaReverbSendR
endin

instr 10
    kTime    chnget "time"   ; delay time
    kFB      chnget "fdbk"   ; feedback ratio
    kMix     chnget "mix"
    iMaxTime =       4

    aInDel   vdelay  gaLofiSendR, a(kTime), iMaxTime ; offset delay
    
    aBufL    delayr  iMaxTime
    aTapL    deltapi kTime*2 ; n.b. delay time doubled
             delayw  gaLofiSendL + aTapL*kFB

    aBufR    delayr  iMaxTime
    aTapR    deltapi kTime*2
             delayw  aInDel + aTapR*kFB
    
    aTapL = aTapL
    aTapR = aTapR 
    aOutL = (gaLofiSendL + aTapL)
    aOutR = (gaLofiSendL + aTapR + aInDel)
    
    outs    aOutL * kMix, aOutR * kMix
    clear gaLofiSendL, gaLofiSendR

endin
</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i5 0 z
i10 0 z
</CsScore>
</CsoundSynthesizer>
