

/*  bounds(0, 0, 0, 0)
------------------------------------
Title: 3xVCO Subtractive Synthesizer
------------------------------------

---------------------------------------------------------------------------------------------
Author: Brendan Hannum, Spring 2023 graduate studying Computer Science at Saint Joseph's University
---------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------
Description: 

The purpose of this project is to give my best attempt at recreating the 3x Oscillator by 
Image-Line, the company behind FL Studio. There are a few key features missing from here that are available
in the 3xOsc, which I will list below:

    - Phase Offset Control for each wave
    - Invert Phase Option for each wave
    - Sine, Rounded Saw and Custom as options for generatable waves
    - AM OSC 3, which converts the third oscillator into an amplitude modulator for the first two oscillators
    - HQ Option which provides anti-aliasing for the oscillators from 15Hz to 20kHz

Admittedly, a portion of these features are missing due to my own shortcomings and lack of expertise in the CSound language.
However, thanks to numerous contributors in the languages community, I was able to implement other features which are not directly available 
in the 3xOsc. I will also list these capabilities below:

    - Resonant High and Low pass filter
    - ASDR Envelope
    - Low-Frequency Oscillation (LFO) 
    - Reverb Effect Unit 
    - Ping Pong Delay Effect Unit
    - Flanger Effect Unit
    
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
<Cabbage> 
bounds(0, 0, 0, 0)
; GUI Initialization
form caption("3xVCO") size(1200, 525), colour(100, 122, 153), guiMode("queue"), pluginId("def1"), bundle("./imgs", "./sources", "./presets")
;gentable bounds(1010, 100, 150, 150), tableNumber(99), channel("table1"), fill(0), outlineThickness(3)
image bounds(0, 0, 1200, 525) file("./imgs/synthbg.png") channel("image50")
signaldisplay bounds(794, 6, 194, 120), colour("white") displayType("waveform"), backgroundColour(84, 80, 102), zoom(2), signalVariable( "aL", "aR" ) channel("display1"), updateRate(50)
signaldisplay bounds(794, 130, 194, 120), colour("white") displayType("waveform"), backgroundColour(84, 80, 102), zoom(2), signalVariable("aL21", "aR21") channel("display2")
signaldisplay bounds(794, 254, 194, 120), colour("white") displayType("waveform"), backgroundColour(84, 80, 102), zoom(2), signalVariable("aL31", "aR31") channel("display3")

keyboard bounds(0, 430, 1200, 95), keyWidth(19) channel("keyboard2"), middleC(4), value(12), scrollbars(0), mouseOverKeyColour(205, 0, 235, 128), keyDownColour(205, 0, 235, 194), blackNoteColour(48, 64, 99, 255), whiteNoteColour(212, 212, 212, 255), keypressBaseOctave(5)

/* Keys Declaration */
image bounds(-55, 413, 130, 128), channel("image196"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(-36, 413, 130, 128), channel("image197"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(-17, 413, 130, 128), channel("image198"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(2, 413, 130, 128), channel("image199"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(21, 413, 130, 128), channel("image201"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(40, 413, 130, 128), channel("image200"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(59, 413, 130, 128), channel("image202"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(-21, 424, 82, 80),  channel("image99"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(0, 424, 82, 80),  channel("image101"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(34, 424, 82, 80),  channel("image99"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(55, 424, 82, 80),  channel("image101"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(76, 424, 82, 80),  channel("image100"), file("./imgs/blackkey.png"), mouseInteraction(0)

image bounds(78, 413, 130, 128), channel("image203"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(97, 413, 130, 128), channel("image204"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(116, 413, 130, 128), channel("image205"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(135, 413, 130, 128), channel("image206"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(154, 413, 130, 128), channel("image207"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(173, 413, 130, 128), channel("image208"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(192, 413, 130, 128), channel("image209"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(112, 424, 82, 80),  channel("image102"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(133, 424, 82, 80),  channel("image103"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(167, 424, 82, 80),  channel("image104"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(188, 424, 82, 80),  channel("image105"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(209, 424, 82, 80),  channel("image106"), file("./imgs/blackkey.png"), mouseInteraction(0)

image bounds(211, 413, 130, 128), channel("image210"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(230, 413, 130, 128), channel("image211"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(249, 413, 130, 128), channel("image212"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(268, 413, 130, 128), channel("image213"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(287, 413, 130, 128), channel("image214"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(306, 413, 130, 128), channel("image215"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(325, 413, 130, 128), channel("image216"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(245, 424, 82, 80),  channel("image107"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(266, 424, 82, 80),  channel("image108"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(300, 424, 82, 80),  channel("image109"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(321, 424, 82, 80),  channel("image110"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(342, 424, 82, 80),  channel("image111"), file("./imgs/blackkey.png"), mouseInteraction(0)

image bounds(344, 413, 130, 128), channel("image224"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(363, 413, 130, 128), channel("image225"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(382, 413, 130, 128), channel("image226"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(401, 413, 130, 128), channel("image227"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(420, 413, 130, 128), channel("image228"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(439, 413, 130, 128), channel("image229"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(458, 413, 130, 128), channel("image230"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(378, 424, 82, 80),  channel("image112"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(397, 424, 82, 80),  channel("image113"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(433, 424, 82, 80),  channel("image114"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(452, 424, 82, 80),  channel("image115"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(471, 424, 82, 80),  channel("image116"), file("./imgs/blackkey.png"), mouseInteraction(0)

image bounds(477, 413, 130, 128), channel("image231"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(496, 413, 130, 128), channel("image232"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(515, 413, 130, 128), channel("image233"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(534, 413, 130, 128), channel("image234"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(553, 413, 130, 128), channel("image235"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(572, 413, 130, 128), channel("image236"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(591, 413, 130, 128), channel("image237"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(511, 424, 82, 80),  channel("image117"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(530, 424, 82, 80),  channel("image118"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(566, 424, 82, 80),  channel("image119"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(585, 424, 82, 80),  channel("image120"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(604, 424, 82, 80),  channel("image121"), file("./imgs/blackkey.png"), mouseInteraction(0)

image bounds(610, 413, 130, 128), channel("image238"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(629, 413, 130, 128), channel("image239"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(648, 413, 130, 128), channel("image240"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(667, 413, 130, 128), channel("image241"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(686, 413, 130, 128), channel("image242"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(705, 413, 130, 128), channel("image243"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(724, 413, 130, 128), channel("image244"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(644, 424, 82, 80),  channel("image122"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(663, 424, 82, 80),  channel("image123"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(699, 424, 82, 80),  channel("image124"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(718, 424, 82, 80),  channel("image125"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(737, 424, 82, 80),  channel("image126"), file("./imgs/blackkey.png"), mouseInteraction(0)

image bounds(743, 413, 130, 128), channel("image217"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(762, 413, 130, 128), channel("image218"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(781, 413, 130, 128), channel("image219"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(800, 413, 130, 128), channel("image220"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(819, 413, 130, 128), channel("image221"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(838, 413, 130, 128), channel("image222"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(857, 413, 130, 128), channel("image223"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(777, 424, 82, 80),  channel("image122"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(796, 424, 82, 80),  channel("image123"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(832, 424, 82, 80),  channel("image124"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(851, 424, 82, 80),  channel("image125"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(870, 424, 82, 80),  channel("image126"), file("./imgs/blackkey.png"), mouseInteraction(0)

image bounds(876, 413, 130, 128), channel("image224"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(895, 413, 130, 128), channel("image225"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(914, 413, 130, 128), channel("image226"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(933, 413, 130, 128), channel("image227"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(952, 413, 130, 128), channel("image228"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(971, 413, 130, 128), channel("image229"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(990, 413, 130, 128), channel("image230"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(910, 424, 82, 80),  channel("image127"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(929, 424, 82, 80),  channel("image128"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(965, 424, 82, 80),  channel("image129"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(984, 424, 82, 80),  channel("image130"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(1003, 424, 82, 80),  channel("image131"), file("./imgs/blackkey.png"), mouseInteraction(0)

image bounds(1009, 413, 130, 128), channel("image231"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(1028, 413, 130, 128), channel("image232"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(1047, 413, 130, 128), channel("image233"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(1066, 413, 130, 128), channel("image234"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(1085, 413, 130, 128), channel("image235"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(1104, 413, 130, 128), channel("image236"), file("./imgs/whitekey.png"), mouseInteraction(0)
image bounds(1123, 413, 130, 128), channel("image237"), file("./imgs/whitekey.png"), mouseInteraction(0)

image bounds(1043, 424, 82, 80),  channel("image132"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(1062, 424, 82, 80),  channel("image133"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(1095, 424, 82, 80),  channel("image134"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(1117, 424, 82, 80),  channel("image135"), file("./imgs/blackkey.png"), mouseInteraction(0)
image bounds(1136, 424, 82, 80),  channel("image136"), file("./imgs/blackkey.png"), mouseInteraction(0)

combobox bounds(130, 388, 659, 30), populate("./presets/*.snaps"), corners(5), channelType("string") automatable(0) channel("combo52") value("0") text("Swirly Goddess") colour(38, 40, 43, 255)
filebutton bounds(4, 388, 120, 30), text("Save", "Save"), corners(5), populate("./presets/*.snaps", "test"), mode("named preset") channel("filebutton53") colour:0(38, 40, 43, 255)
filebutton bounds(794, 388, 194, 30), text("Remove", "Remove"), corners(5), populate("*/presets/.snaps", "test"), mode("remove preset") channel("filebutton54") colour:0(38, 40, 43, 255)

groupbox bounds(994, 6, 201, 40) channel("groupbox10001") colour(0, 0, 0, 128), imgFile("./imgs/MasterPanel.png") {
label bounds(74, 15, 55, 10), channel("label0"), text("Master"), fontSize(15)
}
groupbox bounds(994, 52, 201, 100) channel("groupbox10000") colour(0, 0, 0, 0) text("Reverb"),  imgFile("./imgs/ReverbPanel.png") corners(6) {
rslider bounds(20, 12, 80, 80), channel("roomsize"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(33, 80, 55, 10), channel("label1"), text("Room Size"), fontSize(12)
rslider bounds(100, 12, 80, 80), channel("reverbfreq"), range(20, 22000, 3000, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(103, 80, 75, 10), channel("label2"), text("Freq. Cutoff"), fontSize(12)
}
groupbox bounds(994, 158, 201, 100) channel("groupbox10002") colour(0, 0, 0, 128) text("Delay"), imgFile("./imgs/ReverbPanel.png") {
rslider bounds(2, 12, 80, 80), channel("time"), range(0.01, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(15, 80, 55, 10), channel("label3"), text("Time"), fontSize(12)
rslider bounds(60, 12, 80, 80), channel("fdbk"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(73, 80, 55, 10), channel("label4"), text("FDBK"), fontSize(12)
rslider bounds(134, 6, 50, 50), channel("delaycutoff"), range(20, 22000, 10000, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(134, 40, 50, 50), channel("mix"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(132, 80, 55, 10), channel("label5"), text("Mix"), fontSize(12)
}
groupbox bounds(994, 264, 201, 158) channel("groupbox10003") colour(0, 0, 0, 128), text("Flanger") imgFile("./imgs/FlangerPanel.png") {
;label bounds(73, 8, 55, 15), channel("label6"), text("Flanger"), fontSize(15)
rslider bounds(2, 12, 80, 80), channel("del"), range(0.01, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(15, 78, 55, 10), channel("label6"), text("Delay"), fontSize(12)
rslider bounds(60, 12, 80, 80), channel("flangerfdbk"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(73, 78, 55, 10), channel("label7"), text("FDBK"), fontSize(12)
rslider bounds(119, 12, 80, 80), channel("flangermix"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(132, 78, 55, 10), channel("label8"), text("Mix"), fontSize(12)
rslider bounds(119, 76, 80, 80), channel("level"), range(0, 1, 0, 1, 0.01), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(132, 142, 55, 10), channel("label8"), text("Level"), fontSize(12)
rslider bounds(60, 76, 80, 80), channel("rate"), range(0.001, 40, 0.15, 0.5, 0.001), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(74, 142, 55, 10), channel("label8"), text("Rate"), fontSize(12)
rslider bounds(2, 76, 80, 80), channel("depth"),  range(0, 0.01, 0.005, 1, 0.0001), colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
label bounds(15, 142, 55, 10), channel("label8"), text("Depth"), fontSize(12)
}
;|---------------------------------------------START WAVE #1---------------------------------------------|
; Wave Selection #1
groupbox bounds(4, 6, 120, 120) channel("groupbox10010") colour(0, 0, 0, 128) text("Source"), imgFile("./imgs/WavePanel.png") {
combobox bounds(20, 30, 80, 23) channel("waveform"), align(left), value(1), corners(5),  text("Saw", "Square", "Triangle", "Noise", "Buzz", "FM Bell", "FM B3 Organ", "FM Perc", "FM Metal", "FM Rhode", "Shaker", "Moog", "Bamboo", "Snare", "Kick", "Sandpaper", "Crunch", "Sekere", "Cabasa", "WGPluck", "WGBow") colour:0(38, 40, 43, 255)
rslider  bounds(12, 60, 50, 50), channel("pitch1"),  range(-24, 24, 0, 1, 1),  text("Pitch"),  , colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider  bounds(60, 60, 50, 50), channel("fine1"),   range(-1, 1, 0, 1, 0.001),  text("Fine"),   , colour(0, 0, 255, 128), markerColour(0, 0, 0, 255), trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; ASDR Envelope #1
groupbox bounds(130, 6, 270, 120) channel("groupbox100011") text("Envelope") colour(0, 0, 0, 128), imgFile("./imgs/ASDRPanel.png") {
rslider bounds(15, 35, 60, 60), channel("att"), range(0.01, 1, 0.01, 1, 0.01), text("Attack") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(75, 35, 60, 60), channel("dec"), range(0.01, 1, 0.5, 1, 0.01), text("Decay") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(135, 35, 60, 60), channel("sus"), range(0, 1, 0.5, 1, 0.01), text("Sustain") markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(195, 35, 60, 60), channel("rel"), range(0.01, 1, 0.7, 1, 0.01), text("Release") trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; Filter #1
groupbox bounds(406, 6, 140, 120) channel("groupbox10012") colour(0, 0, 0, 128) text("Filter"), imgFile("./imgs/FilterPanel.png") {
optionbutton bounds(20, 30, 102, 23) channel("filterType"), corners(5),  text("LowPass", "HighPass") colour:0(38, 40, 43, 255)
rslider bounds(20, 55, 54, 54), channel("cutoff"), range(0, 22000, 2000, 0.5, 0.01), text("Cut"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(68, 55, 54, 54), channel("res"), range(1, 100, 1, 1, 0.01), text("Res"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255),  filmstrip("./imgs/ChromedKnob.png", 101)
}
; LFO #1
groupbox bounds(552, 6, 80, 120)  channel("groupbox10013") colour(0, 0, 0, 128) text("LFO"), imgFile("./imgs/LFOPanel.png")  {
rslider bounds(15, 15, 50, 50), channel("LFOFreq"), range(0, 10, 0, 1, 0.01), text("Freq"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(15, 65, 50, 50), channel("amp"), range(0, 1, 0.7, 1, 0.01), text("Amp"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; Panning, Volume, Detune, Option1 & Option2 Control #1
groupbox bounds(638, 6, 150, 120) channel("groupbox10014") text("Options") colour(0, 0, 0, 128), imgFile("./imgs/OptionsPanel.png")  {
rslider bounds(15, 15, 50, 50), channel("Panning"), range(0, 1, 0.5, 1, 0.01), text("Pan"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(15, 65, 50, 50), channel("Volume"), range(0, 1.25, 0.75, 1, 0.01), text("Gain"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
vslider bounds(94, 20, 18, 90), channel("detune"), range(-1, 1, 0, 1, 0.1), colour(201, 90, 220, 225) markerColour(201, 90, 220, 255) trackerColour(128, 128, 128, 255), filmstrip("./imgs/DetuneSlider.png", 128)
label bounds(54, 105, 40, 10), channel("label10"), text("Detune"), fontSize(12)
;rslider bounds(90, 15, 50, 50), channel("OptionA"), range(0, 1, 0, 1, 0.01), text("Opt. 1"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
;rslider bounds(90, 65, 50, 50), channel("OptionB"), range(0, 1, 0, 1, 0.01), text("Opt. 2"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
;|---------------------------------------------END WAVE #1---------------------------------------------|

;|---------------------------------------------START WAVE #2---------------------------------------------|
; Wave Selection #2
groupbox bounds(4, 130, 120, 120) channel("groupbox10021") colour(0, 0, 0, 128) text("Source"), imgFile("./imgs/WavePanel.png") {
combobox bounds(20, 30, 80, 23) channel("waveform2"), value(2), corners(5),  text("Saw", "Square", "Triangle", "Noise", "Buzz", "FM Bell", "FM B3 Organ", "FM Perc", "FM Metal", "FM Rhode", "Shaker", "Moog", "Bamboo", "Snare", "Kick", "Sandpaper", "Crunch", "Sekere", "Cabasa", "WGPluck", "WGBow") colour:0(38, 40, 43, 255)
rslider  bounds(12, 60, 50, 50), channel("pitch2"),  range(-24, 24, 0, 1, 1),  text("Pitch"),  , colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider  bounds(60, 60, 50, 50), channel("fine2"),   range(-1, 1, 0, 1, 0.001),  text("Fine"),   , colour(0, 0, 255, 128), markerColour(0, 0, 0, 255), trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; ASDR Envelope #2
groupbox bounds(130, 130, 270, 120) channel("groupbox10022") text("Envelope") colour(0, 0, 0, 128), imgFile("./imgs/ASDRPanel.png") {
rslider bounds(15, 35, 60, 60), channel("att2"), range(0.01, 1, 0.01, 1, 0.01), text("Attack") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(75, 35, 60, 60), channel("dec2"), range(0.01, 1, 0.5, 1, 0.01), text("Decay") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(135, 35, 60, 60), channel("sus2"), range(0, 1, 0.5, 1, 0.01), text("Sustain") markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(195, 35, 60, 60), channel("rel2"), range(0.01, 1, 0.7, 1, 0.01), text("Release") trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; Filter #2
groupbox bounds(406, 130, 140, 120) channel("groupbox10023") colour(0, 0, 0, 128) text("Filter"), imgFile("./imgs/FilterPanel.png") {
optionbutton bounds(20, 30, 102, 23) channel("filterType2"), corners(5),  text("LowPass", "HighPass") colour:0(38, 40, 43, 255)
rslider bounds(20, 55, 54, 54), channel("cutoff2"), range(0, 22000, 2000, 0.5, 0.01), text("Cut"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(68, 55, 54, 54), channel("res2"), range(1, 100, 1, 1, 0.01), text("Res"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255),  filmstrip("./imgs/ChromedKnob.png", 101)
}
; LFO #2
groupbox bounds(552, 130, 80, 120)  channel("groupbox10024") colour(0, 0, 0, 128) text("LFO"), imgFile("./imgs/LFOPanel.png")  {
rslider bounds(15, 15, 50, 50), channel("LFOFreq2"), range(0, 10, 0, 1, 0.01), text("Freq"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(15, 65, 50, 50), channel("amp2"), range(0, 1, 0.7, 1, 0.01), text("Amp"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; Panning & Volume Control #2
groupbox bounds(638, 130, 150, 120) channel("groupbox10025") text("Options") colour(0, 0, 0, 128), imgFile("./imgs/OptionsPanel.png")  {
rslider bounds(15, 15, 50, 50), channel("Panning2"), range(0, 1, 0.5, 1, 0.01), text("Pan"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(15, 65, 50, 50), channel("Volume2"), range(0, 1.25, 0, 1, 0.01), text("Gain"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
vslider bounds(94, 20, 18, 90), channel("detune2"), range(-1, 1, 0, 1, 0.1), colour(201, 90, 220, 225) markerColour(201, 90, 220, 255) trackerColour(128, 128, 128, 255), filmstrip("./imgs/DetuneSlider.png", 128)
label bounds(82, 105, 40, 10), channel("label11"), text("Detune"), fontSize(13)
}
;|---------------------------------------------END WAVE #2---------------------------------------------|

;|---------------------------------------------START WAVE #3---------------------------------------------|
; Wave Selection #3
groupbox bounds(4, 254, 120, 120) channel("groupbox10031") colour(0, 0, 0, 128) text("Source"), imgFile("./imgs/WavePanel.png") {
combobox bounds(20, 30, 80, 23) channel("waveform3"), value(3), corners(5), colour:0(38, 40, 43, 255), text("Saw", "Square", "Triangle", "Noise", "Buzz", "FM Bell", "FM B3 Organ", "FM Perc", "FM Metal", "FM Rhode", "Shaker", "Moog", "Bamboo", "Snare", "Kick", "Sandpaper", "Crunch", "Sekere", "Cabasa", "WGPluck", "WGBow") colour:0(38, 40, 43, 255)
rslider  bounds(12, 60, 50, 50), channel("pitch3"),  range(-24, 24, 0, 1, 1),  text("Pitch"),  , colour(0, 0, 255, 128), trackerColour(255, 255, 255, 255), markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider  bounds(60, 60, 50, 50), channel("fine3"),   range(-1,    1,     0,     1,     .001 ),  text("Fine"),   textBox(1), colour(0, 0, 255, 128), markerColour(0, 0, 0, 255), trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; ASDR Envelope #3
groupbox bounds(130, 254, 270, 120) channel("groupbox10032") text("Envelope") colour(0, 0, 0, 128), imgFile("./imgs/ASDRPanel.png") {
rslider bounds(15, 35, 60, 60), channel("att3"), range(0.01, 1, 0.01, 1, 0.01), text("Attack") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(75, 35, 60, 60), channel("dec3"), range(0.01, 1, 0.5, 1, 0.01), text("Decay") colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(135, 35, 60, 60), channel("sus3"), range(0, 1, 0.5, 1, 0.01), text("Sustain") markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(195, 35, 60, 60), channel("rel3"), range(0.01, 1, 0.7, 1, 0.01), text("Release") trackerColour(255, 255, 255, 255) colour(0, 0, 255, 128) markerColour(0, 0, 0, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; Filter #3
groupbox bounds(406, 254, 140, 120) channel("groupbox10033") colour(0, 0, 0, 128) text("Filter"), imgFile("./imgs/FilterPanel.png") {
optionbutton bounds(20, 30, 102, 23) channel("filterType3"), corners(5), colour:0(38, 40, 43, 255),  text("LowPass", "HighPass") colour:1(0, 0, 255, 128)
rslider bounds(20, 55, 54, 54), channel("cutoff3"), range(0, 22000, 2000, 0.5, 0.01), text("Cut"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(68, 55, 54, 54), channel("res3"), range(1,  100, 1,  1,    .01  ), text("Res"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255),  filmstrip("./imgs/ChromedKnob.png", 101)
}
; LFO #3
groupbox bounds(552, 254, 80, 120)  channel("groupbox10034") colour(0, 0, 0, 128) text("LFO"), imgFile("./imgs/LFOPanel.png")  {
rslider bounds(15, 15, 50, 50), channel("LFOFreq3"), range(0, 10, 0, 1, 0.01), text("Freq"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(15, 65, 50, 50), channel("amp3"), range(0, 1, 0.7, 1, 0.01), text("Amp"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
}
; Panning & Volume Control #3
groupbox bounds(638, 254, 150, 120) channel("groupbox10035") text("Options") colour(0, 0, 0, 128), imgFile("./imgs/OptionsPanel.png") {
rslider bounds(15, 15, 50, 50), channel("Panning3"), range(0, 1, 0.5, 1, 0.01), text("Pan"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
rslider bounds(15, 65, 50, 50), channel("Volume3"), range(0, 1.25, 0, 1, 0.01), text("Gain"), colour(0, 0, 255, 128) markerColour(0, 0, 0, 255) trackerColour(255, 255, 255, 255), filmstrip("./imgs/ChromedKnob.png", 101)
vslider bounds(94, 20, 18, 90), channel("detune3"), range(-1, 1, 0, 1, 0.1), colour(201, 90, 220, 225) markerColour(201, 90, 220, 255) trackerColour(128, 128, 128, 255), filmstrip("./imgs/DetuneSlider.png", 128)
label bounds(82, 105, 40, 10), channel("label13"), text("Detune"), fontSize(13)
}
}
;|---------------------------------------------END WAVE #3---------------------------------------------|
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
/*-d -n */ --displays -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 16
nchnls = 2
0dbfs = 1

;Reverb Send for Left and Right channels

gaReverbSendL init 0 
gaReverbSendR init 0

;Delay Send for Left and Right channels

gaDelaySendL init 0
gaDelaySendR init 0

;Flanger Send for Left and Right channels

gaFlangerSendL init 0
gaFlangerSendR init 0

;F-Table global variables holding source files ( For FM Family of sounds )

gitwopeaks	ftgen	4, 0, 256,  1, "sources/twopeaks.aiff", 0, 0, 0
giWaveBlank ftgen 5, 0, 256, 1, "sources/fwavblnk.aiff", 0, 0, 0
giImpluse20 ftgen 6, 0, 256, 1, "sources/impuls20.aiff", 0, 0, 0
giMandPluck ftgen 7, 0, 8192, 1, "sources/mandpluk.aiff", 0, 0, 0

; Display Send for Left and Right channels

gaDisplaySendL init 0
gaDisplaySendR init 0


; Custom opcode for applying a resonant filter to Pink Noise

opcode    resonsr,a,akki
    asig,kcf,kbw,iscal    xin
        setksmps    1
    acf    interp    kcf
    kcf    downsamp    acf
    abw    interp    kbw
    kbw    downsamp    abw
    asig      reson   asig, kcf, kbw, iscal
        xout    asig
endop

;instrument will be triggered by keyboard widget
instr 1

; Each Oscillator operation is seperated by an entire line.
; One signal must be produced per channel ( to achieve stereo effects )
; Pitch and Fine Tune Control

; Get values from channels using chnget opcode

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

kAmpJitter = iAmp ; Artifact variable from when the jitter opcode was used to add liveliness to the output. Most variables use this now so it's staying.

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

; Waveform Selection 

kWaveForm chnget "waveform"
kWaveForm2 chnget "waveform2"
kWaveForm3 chnget "waveform3"

kWaveForm -= 1 ; Modifying index for if-else statement
kWaveForm2 -= 1
kWaveForm3 -= 1

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

kPW init 1.0

; This structure is used to reinitialize the instrument whenever a change is made to the WaveForm field.
; Each time you switch between Saw, Square and Triangle, this code will execute to adjust the inputs of the VCO2 opcode

; BEGIN WAVE 1

    kWavTrig  changed      kWaveForm        ;GENERATE A 'BANG' IF WAVEFORM SELECTOR CHANGES
    if kWavTrig=1 then    
     ;IF A 'BANG' HAS BEEN GENERATED...
     reinit REINIT_VCO                ;BEGIN A REINITIALISATION PASS FROM THE LABEL 'REINIT_VCO'
    endif
    
REINIT_VCO:

if i(kWaveForm) == 0 then
    iMode = 0
elseif i(kWaveForm) == 1 then
    iMode = 10
    printk2 kAmpJitter 
elseif i(kWaveForm) == 2 then
    iMode = 12
elseif i(kWaveForm) == 3 then


    ; Pink Noise generated using pinkish opcode and a custom opcode to apply resonance 
    
    aPink pinkish 1

    aOut resonsr aPink, kcps1, kcps1*0.01, 1
    aOut2 resonsr aPink, kcps2, kcps2*0.01, 1
    
    ; Multiply amplitude by a lot because it's initially quiet
    
    aOut *= 100 
    aOut2 *= 100

goto SKIP

elseif i(kWaveForm) == 4 then
    
    ; The buzz opcode produces a set of harmonically related sine partials
    ; Users input a starting number of harmonics and a function table with a sine wave
    ; This one uses 10 harmonics
     
    aOut buzz kAmpJitter, kcps1, 10, 1
    aOut2 buzz kAmpJitter, kcps2, 10, 1
    
goto SKIP

elseif i(kWaveForm) == 5 then
    
    ; The FMBell opcode from the FM family of opcodes. All parameters are fixed
    
    kc1 = .5
    kc2 = 1
    kvDepth = .005
    kvRate = 6
    
    aOut fmbell kAmpJitter, kcps1, kc1, kc2, kvDepth, kvRate
    aOut2 fmbell kAmpJitter, kcps2, kc1, kc2, kvDepth, kvRate

goto SKIP

elseif i(kWaveForm) == 6 then

    ; The Hammond B3 opcode from the FM family of opcodes. All parameters are fixed
    
    kc1 = .5
    kc2 = .5
    kvDepth = 0.1
    kvRate = 6
    
    aOut fmb3 kAmpJitter, kcps1, kc1, kc2, kvDepth, kvRate
    aOut2 fmb3 kAmpJitter, kcps2, kc1, kc2, kvDepth, kvRate
        
goto SKIP

elseif i(kWaveForm) == 7 then

    ; The percussion opcode from the FM family of opcodes. All parameters are fixed.
    
    kc1 = 5
    kc2 = 4.5
    kvDepth = .01
    kvRate = 6
    
    aOut fmpercfl kAmpJitter, kcps1, kc1, kc2, kvDepth, kvRate
    aOut2 fmpercfl kAmpJitter, kcps2, kc1, kc2, kvDepth, kvRate
    
goto SKIP

elseif i(kWaveForm) == 8 then
    
    ; The metal opcode from the FM family of opcodes. All parameters are fixed.
    
    kvdepth = 0
    kvrate = 0
    kc1 = 5
    kc2 = 5
    ifn1 = 1
    ifn2 = 4
    ifn3 = 4
    ifn4 = 1
    ivfn = 1
    
    aOut fmmetal kAmpJitter, kcps1, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    aOut2 fmmetal kAmpJitter, kcps2, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    
goto SKIP

elseif i(kWaveForm) == 9 then

    ; The Rhodes Piano opcode from the FM family of opcodes. All parameters are fixed.
    
    kvdepth = 0.01
    kvrate = 3
    kc1 = 6
    kc2 = 0
    ifn1 = 1
    ifn2 = 1
    ifn3 = 1
    ifn4 = 5
    ivfn = 1
    
    aOut fmrhode kAmpJitter, kcps1, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    aOut2 fmrhode kAmpJitter, kcps2, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    
goto SKIP

elseif i(kWaveForm) == 10 then

    ; Model of a maraca originally developed by Perry Cook but recoded for CSound.
    ; This version had 8 'beans' and shakes twice
    
    aOut shaker kAmpJitter, kcps1, 8, .99, 2
    aOut2 shaker kAmpJitter, kcps2, 8, .99, 2
    
goto SKIP

elseif i(kWaveForm) == 11 then

    ; Emulator of a Moog synth. This opcode inputs 3 different function tables: One for attack, another for the main loop, and one for the vibrato.
    
    kFiltQ = .85
    kFiltRate = .0002
    kVib = 5
    kVibAmp = .01
    aOut moog kAmpJitter, kcps1, kFiltQ, kFiltRate, kVib, kVibAmp, 7, 6, 1
    aOut2 moog kAmpJitter, kcps2, kFiltQ, kFiltRate, kVib, kVibAmp, 7, 6, 1
    aOut *= .5
    aOut2 *= .5
    
goto SKIP

elseif i(kWaveForm) == 12 then

    ; Semi-Physical model of bamboo sticks clashing. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch to this sound. So regardless of where on the keyboard it is pressed, it will sound relatively the same.
    aOut bamboo kAmpJitter, .01
    aOut2 bamboo kAmpJitter, .01
    
goto SKIP 

elseif i(kWaveForm) == 13 then

    ; Pluck opcode providing decaying string or drum sounds based on the Karplus-Strong algorithms.
    
    aOut pluck kAmpJitter, kcps1, i(kcps1), 0, 3, .5, 10
    aOut2 pluck kAmpJitter, kcps2, i(kcps2), 0, 3, .5, 10
    
goto SKIP

elseif i(kWaveForm) == 14 then

    ; Custom Kick sound accepting multiple variables which define the behavior
    ; Each variable is used in the construction of an amplitude and frequency envelope
    ; which is eventually outputted as a somewhat desirable 808 bass drum sound.
    ; Pitch of keys only slightly modifies sound here
    
    idur   =         .25           ; Duration
    iamp   =         i(kAmpJitter)  ; Amplitude
    iacc   =         1            ; Accent
    irez   =         1            ; Resonance
    iod    =         1            ; Overdrive
    ilowf  =         80            ; Low Frequency

    kfenv  linseg    1000+(i(kcps1)/10),  .02, 180+(i(kcps1)/10), .04, 120+(i(kcps1)/10), idur-.06, ilowf+(i(kcps1)/10) ; Freq Envelope
    kaenv  expseg    .1, .001, 1, .02, 1, .04, .7, idur-.062, .7  ; Amp Envelope
    kdclck linseg    0, .002, 1, idur-.042, 1, .04, 0             ; Declick
    asig   rand      2                                            ; Random number

    aflt   rezzy     asig, kfenv, irez*40         ; Filter

    aout1  =         aflt*kaenv*3*iod/iacc        ; Scale the sound

    krms   rms       aout1, 1000                  ; Limiter, get rms
    klim   table3    krms*.5, 10, 1                ; Get limiting value
    aOut   =         aout1*klim*iamp*kdclck/sqrt(iod)*1.3   ; Scale again and ouput
    aOut2   =        aout1*klim*iamp*kdclck/sqrt(iod)*1.3   ; Scale again and ouput


goto SKIP

elseif i(kWaveForm) == 15 then

    ; Semi-Physical model of sandpaper scraping. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.1
    iNumParticles = 128
    
    aOut sandpaper i(kAmpJitter), iDettack, iNumParticles, .5, 0
    aOut2 sandpaper i(kAmpJitter), iDettack, iNumParticles, .5, 0
    
    aOut *= 5
    aOut2 *= 5
    
goto SKIP

elseif i(kWaveForm) == 16 then
    
    ; Semi-Physical model of a crunch It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.1
    iNumParticles = 7
    
    aOut crunch i(kAmpJitter), iDettack, iNumParticles
    aOut2 crunch i(kAmpJitter), iDettack, iNumParticles
    
    aOut *= 10
    aOut2 *= 10
    
goto SKIP

elseif i(kWaveForm) == 17 then

    ; Semi-Physical model of the sekere percussion instrument. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    iDettack = 0.01
    iNumParticles = 64
    
    aOut sekere i(kAmpJitter), iDettack, iNumParticles
    aOut2 sekere i(kAmpJitter), iDettack, iNumParticles
    
    aOut *= 20
    aOut2 *= 20
    
goto SKIP

elseif i(kWaveForm) == 18 then

    ; Semi-Physical model of the cabasa percussion instrument. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.01
    iNumParticles = 48
    
    aOut cabasa i(kAmpJitter), iDettack, iNumParticles
    aOut2 cabasa i(kAmpJitter), iDettack, iNumParticles
    
    aOut *= 20
    aOut2 *= 20
    
goto SKIP

elseif i(kWaveForm) == 19 then

    iplk = 0.75
    kpick = 0.75
    krefl = 0.5
    
    aOut wgpluck2 iplk, kAmpJitter, i(kcps1), kpick, krefl
    aOut2 wgpluck2 iplk, kAmpJitter, i(kcps2), kpick, krefl
    
    aOut *= .75
    aOut2 *= .75
    
goto SKIP

elseif i(kWaveForm) == 20 then

    kPres = 3
    kRat = 0.127236
    kVib = 4.5
    kVibAmp = 0.008
    
    aOut wgbow kAmpJitter, kcps1, kPres, kRat, kVib, kVibAmp
    aOut2 wgbow kAmpJitter, kcps2, kPres, kRat, kVib, kVibAmp
    
goto SKIP
endif

    aOut vco2 kAmpJitter, kcps1, iMode, kPW, 0, 0.25
    aOut2 vco2 kAmpJitter, kcps2, iMode, kPW, 0, 0.25

SKIP:
rireturn

; END WAVEFROM 1

; BEGIN WAVEFORM 2

    kWavTrig2  changed      kWaveForm2        ;GENERATE A 'BANG' IF WAVEFORM SELECTOR CHANGES
    if kWavTrig2=1 then    
     ;IF A 'BANG' HAS BEEN GENERATED...
     reinit REINIT_VCO2               ;BEGIN A REINITIALISATION PASS FROM THE LABEL 'REINIT_VCO'
    endif
    
REINIT_VCO2:
if i(kWaveForm2) == 0 then
    iMode2 = 0
elseif i(kWaveForm2) == 1 then
    iMode2 = 10
elseif i(kWaveForm2) == 2 then
    iMode2 = 12
elseif i(kWaveForm2) == 3 then

    aPink pinkish 1

    aOut21 resonsr aPink, kcps21, kcps21*0.01, 1
    aOut22 resonsr aPink, kcps22, kcps22*0.01, 1
    
    aOut21 *= 50
    aOut22 *= 50

goto SKIP2

elseif i(kWaveForm2) == 4 then
    
    ; The buzz opcode produces a set of harmonically related sine partials
    ; Users input a starting number of harmonics and a function table with a sine wave
    ; This one uses 10 harmonics
     
    aOut21 buzz kAmpJitter, kcps21, 10, 1
    aOut22 buzz kAmpJitter, kcps22, 10, 1
    
goto SKIP2

elseif i(kWaveForm2) == 5 then
    
    ; The FMBell opcode from the FM family of opcodes. All parameters are fixed
    
    kc1 = .5
    kc2 = 1
    kvDepth = .005
    kvRate = 6
    
    aOut21 fmbell kAmpJitter, kcps21, kc1, kc2, kvDepth, kvRate
    aOut22 fmbell kAmpJitter, kcps22, kc1, kc2, kvDepth, kvRate

goto SKIP2

elseif i(kWaveForm2) == 6 then

    ; The Hammond B3 opcode from the FM family of opcodes. All parameters are fixed
    
    kc1 = .5
    kc2 = .5
    kvDepth = 0.1
    kvRate = 6
    
    aOut21 fmb3 kAmpJitter, kcps21, kc1, kc2, kvDepth, kvRate
    aOut22 fmb3 kAmpJitter, kcps22, kc1, kc2, kvDepth, kvRate
        
goto SKIP2

elseif i(kWaveForm2) == 7 then

    ; The percussion opcode from the FM family of opcodes. All parameters are fixed.
    
    kc1 = 5
    kc2 = 4.5
    kvDepth = .01
    kvRate = 6
    
    aOut21 fmpercfl kAmpJitter, kcps21, kc1, kc2, kvDepth, kvRate
    aOut22 fmpercfl kAmpJitter, kcps22, kc1, kc2, kvDepth, kvRate
    
goto SKIP2

elseif i(kWaveForm2) == 8 then
    
    ; The metal opcode from the FM family of opcodes. All parameters are fixed.
    
    kvdepth = 0
    kvrate = 0
    kc1 = 5
    kc2 = 5
    ifn1 = 1
    ifn2 = 4
    ifn3 = 4
    ifn4 = 1
    ivfn = 1
    
    aOut21 fmmetal kAmpJitter, kcps21, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    aOut22 fmmetal kAmpJitter, kcps22, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    
goto SKIP2

elseif i(kWaveForm2) == 9 then

    ; The Rhods Piano opcode from the FM family of opcodes. All parameters are fixed.
    
    kvdepth = 0.01
    kvrate = 3
    kc1 = 6
    kc2 = 0
    ifn1 = 1
    ifn2 = 1
    ifn3 = 1
    ifn4 = 5
    ivfn = 1
    
    aOut21 fmrhode kAmpJitter, kcps21, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    aOut22 fmrhode kAmpJitter, kcps22, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    
goto SKIP2

elseif i(kWaveForm2) == 10 then

    ; Model of a maraca originally developed by Perry Cook but recoded for CSound.
    ; This version had 8 'beans' and shakes twice
    
    aOut21 shaker kAmpJitter, kcps21, 8, .99, 2
    aOut22 shaker kAmpJitter, kcps22, 8, .99, 2
    
goto SKIP2

elseif i(kWaveForm2) == 11 then

    ; Emulator of a Moog synth. This opcode inputs 3 different function tables: One for attack, another for the main loop, and one for the vibrato.
    
    kFiltQ = .85
    kFiltRate = .0002
    kVib = 5
    kVibAmp = .01
    aOut moog kAmpJitter, kcps21, kFiltQ, kFiltRate, kVib, kVibAmp, 7, 6, 1
    aOut2 moog kAmpJitter, kcps22, kFiltQ, kFiltRate, kVib, kVibAmp, 7, 6, 1
    aOut21 *= .5
    aOut22 *= .5
    
goto SKIP2

elseif i(kWaveForm2) == 12 then

    ; Semi-Physical model of bamboo sticks clashing. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch to this sound. So regardless of where on the keyboard it is pressed, it will sound relatively the same.
    aOut21 bamboo kAmpJitter, .01
    aOut22 bamboo kAmpJitter, .01
    
goto SKIP2

elseif i(kWaveForm2) == 13 then

    ; Pluck opcode providing decaying string or drum sounds based on the Karplus-Strong algorithms.
    
    aOut21 pluck kAmpJitter, kcps21, i(kcps21), 0, 3, .5, 10
    aOut22 pluck kAmpJitter, kcps22, i(kcps22), 0, 3, .5, 10
    
goto SKIP2

elseif i(kWaveForm2) == 14 then

    ; Custom Kick sound accepting multiple variables which define the behavior
    ; Each variable is used in the construction of an amplitude and frequency envelope
    ; which is eventually outputted as a somewhat desirable 808 bass drum sound.
    ; Pitch of keys only slightly modifies sound here
    
    idur   =         .25           ; Duration
    iamp   =         i(kAmpJitter)  ; Amplitude
    iacc   =         1            ; Accent
    irez   =         1            ; Resonance
    iod    =         1            ; Overdrive
    ilowf  =         80            ; Low Frequency

    kfenv  linseg    1000+(i(kcps21)/10),  .02, 180+(i(kcps21)/10), .04, 120+(i(kcps21)/10), idur-.06, ilowf+(i(kcps21)/10) ; Freq Envelope
    kaenv  expseg    .1, .001, 1, .02, 1, .04, .7, idur-.062, .7  ; Amp Envelope
    kdclck linseg    0, .002, 1, idur-.042, 1, .04, 0             ; Declick
    asig   rand      2                                            ; Random number

    aflt   rezzy     asig, kfenv, irez*40         ; Filter

    aout1  =         aflt*kaenv*3*iod/iacc        ; Scale the sound

    krms   rms       aout1, 1000                  ; Limiter, get rms
    klim   table3    krms*.5, 10, 1                ; Get limiting value
    aOut21   =         aout1*klim*iamp*kdclck/sqrt(iod)*1.3   ; Scale again and ouput
    aOut22   =        aout1*klim*iamp*kdclck/sqrt(iod)*1.3   ; Scale again and ouput


goto SKIP2

elseif i(kWaveForm2) == 15 then

    ; Semi-Physical model of sandpaper scraping. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.1
    iNumParticles = 128
    
    aOut21 sandpaper i(kAmpJitter), iDettack, iNumParticles, .5, 0
    aOut22 sandpaper i(kAmpJitter), iDettack, iNumParticles, .5, 0
    
goto SKIP2

elseif i(kWaveForm2) == 16 then
    
    ; Semi-Physical model of a crunch It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.1
    iNumParticles = 7
    
    aOut21 crunch i(kAmpJitter), iDettack, iNumParticles
    aOut22 crunch i(kAmpJitter), iDettack, iNumParticles
    
goto SKIP2

elseif i(kWaveForm2) == 17 then

    ; Semi-Physical model of the sekere percussion instrument. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    iDettack = 0.01
    iNumParticles = 64
    
    aOut21 sekere i(kAmpJitter), iDettack, iNumParticles
    aOut22 sekere i(kAmpJitter), iDettack, iNumParticles
    
goto SKIP2

elseif i(kWaveForm2) == 18 then

    ; Semi-Physical model of the cabasa percussion instrument. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.01
    iNumParticles = 48
    
    aOut21 cabasa i(kAmpJitter), iDettack, iNumParticles
    aOut22 cabasa i(kAmpJitter), iDettack, iNumParticles
    
goto SKIP2

elseif i(kWaveForm2) == 19 then

    iplk = 0.75
    kpick = 0.75
    krefl = 0.5
    
    aOut21 wgpluck2 iplk, kAmpJitter, i(kcps21), kpick, krefl
    aOut22 wgpluck2 iplk, kAmpJitter, i(kcps22), kpick, krefl
    aOut21 *= .75
    aOut22 *= .75
    
goto SKIP2

elseif i(kWaveForm2) == 20 then

    kPres = 3
    kRat = 0.127236
    kVib = 4.5
    kVibAmp = 0.008
    
    aOut21 wgbow kAmpJitter, kcps21, kPres, kRat, kVib, kVibAmp
    aOut22 wgbow kAmpJitter, kcps22, kPres, kRat, kVib, kVibAmp
    
goto SKIP2

endif

    aOut21 vco2 iAmp, kcps21, iMode2, kPW
    aOut22 vco2 iAmp, kcps22, iMode2, kPW

SKIP2:
rireturn

    kWavTrig3  changed      kWaveForm3        ;GENERATE A 'BANG' IF WAVEFORM SELECTOR CHANGES
    if kWavTrig3=1 then    
     ;IF A 'BANG' HAS BEEN GENERATED...
     reinit REINIT_VCO3               ;BEGIN A REINITIALISATION PASS FROM THE LABEL 'REINIT_VCO'
    endif

; END WAVEFORM 2

; BEGIN WAVEFORM 3

REINIT_VCO3:
if i(kWaveForm3) == 0 then
    iMode3 = 0
elseif i(kWaveForm3) == 1 then
    iMode3 = 10
elseif i(kWaveForm3) == 2 then
    iMode3 = 12
elseif i(kWaveForm3) == 3 then

    aPink pinkish 1

    aOut31 resonsr aPink, kcps31, kcps31*0.01, 1
    aOut32 resonsr aPink, kcps32, kcps32*0.01, 1
    
    aOut31 *= 50
    aOut32 *= 50

goto SKIP3

elseif i(kWaveForm3) == 4 then
    
    ; The buzz opcode produces a set of harmonically related sine partials
    ; Users input a starting number of harmonics and a function table with a sine wave
    ; This one uses 10 harmonics
     
    aOut31 buzz kAmpJitter, kcps31, 10, 1
    aOut32 buzz kAmpJitter, kcps32, 10, 1
    
goto SKIP3

elseif i(kWaveForm3) == 5 then
    
    ; The FMBell opcode from the FM family of opcodes. All parameters are fixed
    
    kc1 = .5
    kc2 = 1
    kvDepth = .005
    kvRate = 6
    
    aOut31 fmbell kAmpJitter, kcps31, kc1, kc2, kvDepth, kvRate
    aOut32 fmbell kAmpJitter, kcps32, kc1, kc2, kvDepth, kvRate

goto SKIP3

elseif i(kWaveForm3) == 6 then

    ; The Hammond B3 opcode from the FM family of opcodes. All parameters are fixed
    
    kc1 = .5
    kc2 = .5
    kvDepth = 0.1
    kvRate = 6
    
    aOut31 fmb3 kAmpJitter, kcps31, kc1, kc2, kvDepth, kvRate
    aOut32 fmb3 kAmpJitter, kcps32, kc1, kc2, kvDepth, kvRate
        
goto SKIP3

elseif i(kWaveForm3) == 7 then

    ; The percussion opcode from the FM family of opcodes. All parameters are fixed.
    
    kc1 = 5
    kc2 = 4.5
    kvDepth = .01
    kvRate = 6
    
    aOut31 fmpercfl kAmpJitter, kcps31, kc1, kc2, kvDepth, kvRate
    aOut32 fmpercfl kAmpJitter, kcps32, kc1, kc2, kvDepth, kvRate
    
goto SKIP3

elseif i(kWaveForm3) == 8 then
    
    ; The metal opcode from the FM family of opcodes. All parameters are fixed.
    
    kvdepth = 0
    kvrate = 0
    kc1 = 5
    kc2 = 5
    ifn1 = 1
    ifn2 = 4
    ifn3 = 4
    ifn4 = 1
    ivfn = 1
    
    aOut31 fmmetal kAmpJitter, kcps31, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    aOut32 fmmetal kAmpJitter, kcps32, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    
goto SKIP3

elseif i(kWaveForm3) == 9 then

    ; The Rhods Piano opcode from the FM family of opcodes. All parameters are fixed.
    
    kvdepth = 0.01
    kvrate = 3
    kc1 = 6
    kc2 = 0
    ifn1 = 1
    ifn2 = 1
    ifn3 = 1
    ifn4 = 5
    ivfn = 1
    
    aOut31 fmrhode kAmpJitter, kcps31, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    aOut32 fmrhode kAmpJitter, kcps32, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
    
goto SKIP3

elseif i(kWaveForm3) == 10 then

    ; Model of a maraca originally developed by Perry Cook but recoded for CSound.
    ; This version had 8 'beans' and shakes twice
    
    aOut31 shaker kAmpJitter, kcps31, 8, .99, 2
    aOut32 shaker kAmpJitter, kcps32, 8, .99, 2
    
goto SKIP3

elseif i(kWaveForm3) == 11 then

    ; Emulator of a Moog synth. This opcode inputs 3 different function tables: One for attack, another for the main loop, and one for the vibrato.
    
    kFiltQ = .85
    kFiltRate = .0002
    kVib = 5
    kVibAmp = .01
    aOut moog kAmpJitter, kcps31, kFiltQ, kFiltRate, kVib, kVibAmp, 7, 6, 1
    aOut2 moog kAmpJitter, kcps32, kFiltQ, kFiltRate, kVib, kVibAmp, 7, 6, 1
    aOut31 *= .5
    aOut32 *= .5
    
goto SKIP3

elseif i(kWaveForm3) == 12 then

    ; Semi-Physical model of bamboo sticks clashing. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch to this sound. So regardless of where on the keyboard it is pressed, it will sound relatively the same.
    aOut31 bamboo kAmpJitter, .01
    aOut32 bamboo kAmpJitter, .01
    
goto SKIP3

elseif i(kWaveForm3) == 13 then

    ; Pluck opcode providing decaying string or drum sounds based on the Karplus-Strong algorithms.
    
    aOut31 pluck kAmpJitter, kcps31, i(kcps31), 0, 3, .5, 10
    aOut32 pluck kAmpJitter, kcps32, i(kcps32), 0, 3, .5, 10
    
goto SKIP3

elseif i(kWaveForm3) == 14 then

    ; Custom Kick sound accepting multiple variables which define the behavior
    ; Each variable is used in the construction of an amplitude and frequency envelope
    ; which is eventually outputted as a somewhat desirable 808 bass drum sound.
    ; Pitch of keys only slightly modifies sound here
    
    idur   =         .25           ; Duration
    iamp   =         i(kAmpJitter)  ; Amplitude
    iacc   =         1            ; Accent
    irez   =         1            ; Resonance
    iod    =         1            ; Overdrive
    ilowf  =         80            ; Low Frequency

    kfenv  linseg    1000+(i(kcps1)/10),  .02, 180+(i(kcps31)/10), .04, 120+(i(kcps31)/10), idur-.06, ilowf+(i(kcps31)/10) ; Freq Envelope
    kaenv  expseg    .1, .001, 1, .02, 1, .04, .7, idur-.062, .7  ; Amp Envelope
    kdclck linseg    0, .002, 1, idur-.042, 1, .04, 0             ; Declick
    asig   rand      2                                            ; Random number

    aflt   rezzy     asig, kfenv, irez*40         ; Filter

    aout1  =         aflt*kaenv*3*iod/iacc        ; Scale the sound

    krms   rms       aout1, 1000                  ; Limiter, get rms
    klim   table3    krms*.5, 10, 1                ; Get limiting value
    aOut31   =         aout1*klim*iamp*kdclck/sqrt(iod)*1.3   ; Scale again and ouput
    aOut32   =        aout1*klim*iamp*kdclck/sqrt(iod)*1.3   ; Scale again and ouput


goto SKIP3

elseif i(kWaveForm3) == 15 then

    ; Semi-Physical model of sandpaper scraping. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.1
    iNumParticles = 128
    
    aOut31 sandpaper i(kAmpJitter), iDettack, iNumParticles, .5, 0
    aOut32 sandpaper i(kAmpJitter), iDettack, iNumParticles, .5, 0
    
goto SKIP2

elseif i(kWaveForm3) == 16 then
    
    ; Semi-Physical model of a crunch It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.1
    iNumParticles = 7
    
    aOut31 crunch i(kAmpJitter), iDettack, iNumParticles
    aOut32 crunch i(kAmpJitter), iDettack, iNumParticles
    
goto SKIP3

elseif i(kWaveForm3) == 17 then

    ; Semi-Physical model of the sekere percussion instrument. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    iDettack = 0.01
    iNumParticles = 64
    
    aOut31 sekere i(kAmpJitter), iDettack, iNumParticles
    aOut32 sekere i(kAmpJitter), iDettack, iNumParticles
    
goto SKIP3

elseif i(kWaveForm3) == 18 then

    ; Semi-Physical model of the cabasa percussion instrument. It is a part of the PhISEM percussion opcodes.
    ; There is no pitch modification available to this sound.
    
    iDettack = 0.01
    iNumParticles = 48
    
    aOut31 cabasa i(kAmpJitter), iDettack, iNumParticles
    aOut32 cabasa i(kAmpJitter), iDettack, iNumParticles
    
goto SKIP3

elseif i(kWaveForm3) == 19 then

    iplk = 0.75
    kpick = 0.75
    krefl = 0.5
    
    aOut31 wgpluck2 iplk, kAmpJitter, i(kcps31), kpick, krefl
    aOut32 wgpluck2 iplk, kAmpJitter, i(kcps32), kpick, krefl
    aOut31 *= .75
    aOut32 *= .75
    
goto SKIP3

elseif i(kWaveForm3) == 20 then

    kPres = 3
    kRat = 0.127236
    kVib = 4.5
    kVibAmp = 0.008
    
    aOut31 wgbow kAmpJitter, kcps31, kPres, kRat, kVib, kVibAmp
    aOut32 wgbow kAmpJitter, kcps32, kPres, kRat, kVib, kVibAmp
    
goto SKIP3

endif

    aOut31 vco2 iAmp, kcps31, iMode3, kPW
    aOut32 vco2 iAmp, kcps32, iMode3, kPW

SKIP3:
rireturn

; END WAVEFORM 3


    ; Modify by volume
    aOut = aOut * kVol
    aOut2 = aOut2 * kVol

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

    ; Sending waves to GUI signal display
    display aL, .1, 1
    display aR, .1, 1
    dispfft aL, .1, 1024
    dispfft aR, .1, 1024

    aL21, aR21 pan2 aFilt21*kEnv2, kPan2
    aL22, aR22 pan2 aFilt22*kEnv2, kPan2

    display aL21, .05, 1
    display aR21, .05, 1
    dispfft aL21, .1, 1024
    dispfft aR21, .1, 1024

    aL31, aR31 pan2 aFilt31*kEnv3, kPan3
    aL32, aR32 pan2 aFilt32*kEnv3, kPan3

    display aL31, .05, 1
    display aR31, .05, 1
    dispfft aL31, .1, 1024
    dispfft aR31, .1, 1024
    
    ; Add both signals back together on output
    ;aFinalL, aFinalR reverbsc (aL + aL2), aR + aR2, kroomsize, kreverbfreq
    
    aFinalOutL = (aL + aL2) + (aL21 + aL22) + (aL31 + aL32)
    aFinalOutR = (aR + aR2) + (aR21 + aR22) + (aR31 + aR32)

    outs aFinalOutL * .33, aFinalOutR * .33
    
    gaDelaySendL = (gaDelaySendL/2) + ((aL + aL2) + (aL21 + aL22) + (aL31 + aL32))
    gaDelaySendR = (gaDelaySendR/2) + ((aR + aR2) + (aR21 + aR22) + (aR31 + aR32))

    gaReverbSendL = gaReverbSendL + ((aL + aL2) + (aL21 + aL22) + (aL31 + aL32))
    gaReverbSendR = gaReverbSendR + ((aR + aR2) + (aR21 + aR22) + (aR31 + aR32))

    gaFlangerSendL = gaFlangerSendL + ((aL + aL2) + (aL21 + aL22) + (aL31 + aL32))
    gaFlangerSendR = gaFlangerSendR + ((aR + aR2) + (aR21 + aR22) + (aR31 + aR32))

    clear gaDisplaySendL, gaDisplaySendR
    
endin

/* Reverb Unit */
instr 5
    kWaveForm chnget "waveform"
    kroomsize chnget "roomsize"
    kreverbfreq chnget "reverbfreq"
    
    aRL, aRR reverbsc gaReverbSendL, gaReverbSendR, kroomsize, kreverbfreq
    outs aRL, aRR
    
    gaDisplaySendL = (gaDisplaySendL + gaReverbSendL)/2
    gaDisplaySendR = (gaDisplaySendR + gaReverbSendR)/2

    
    clear gaReverbSendL, gaReverbSendR
endin

/* Delay Unit */

instr 10

    kTime    chnget "time"   
    kFB      chnget "fdbk"   
    kMix     chnget "mix"
    kCut   chnget "delaycutoff"
    kdamp    chnget "damp"
    iMaxTime =       4
    
    kporttime    linseg    0,0.01,0.03                ;CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
    kTime        portk    kTime,kporttime   
    aTime interp kTime
        
    aL_OS        vdelay    gaDelaySendL,(aTime*1000)/2,(10*1000)/2    ;DELAYED OFFSET OF LEFT CHANNEL (FIRST 'PING')
         
    aBuf    delayr 10
    aDelL  deltapi aTime
    aDelL   tone aDelL, kCut 
             delayw aL_OS + (aDelL*kFB)
    
    aBuf    delayr 10
    aDelR  deltapi aTime
    aDelR   tone aDelR, kCut
             delayw gaDelaySendR + (aDelR*kFB)
    
    aMixL ntrpol gaDelaySendL, aDelL+aL_OS, kMix
    aMixR ntrpol gaDelaySendR, aDelR, kMix
    /*
    aBuf    delayr  10
    atapL    deltap3 aTime*2 ; n.b. delay time doubled
             delayw  afirst + atapL*kFB
             
    // Above this works
    
    aBuf    delayr  10
    atapR    deltap3 aTime*2
             delayw gaDelaySendR + atapR*kFB
             
    atapL    =    afirst+atapL+(atapR*(kwidth))
    atapR    =    atapR+(atapL*(1-kwidth))

    
    aMixL ntrpol atapL, gaDelaySendL, kdamp
    aMixR ntrpol atapR, gaDelaySendR, kdamp
    */
    outs    aMixL, aMixR
    
    gaDisplaySendL = gaDisplaySendL + gaDelaySendL
    gaDisplaySendR = gaDisplaySendR + gaDelaySendR

    //gaDisplaySendL *= .5
    //gaDisplaySendR *= .5
    
    clear gaDelaySendL, gaDelaySendR

endin

/* Flanger Unit */

instr 15
    kDel chnget "del"
    
    kporttime    linseg    0,0.001,0.1
    kDel   portk    kDel,kporttime
    
    kFlangerF chnget "flangerfdbk"
    kFlangerMix chnget "flangermix"
    kFlangerRate chnget "rate"
    kFlangerDepth chnget "depth"
    kLev chnget "level"
    
    isine        ftgentmp    0, 0, 131072, 19, 1, 0.5, 0,   0.5
    
    adlt interp kDel
    
    aMod oscili kFlangerDepth, kFlangerRate, isine
    
    adlt sum adlt, aMod

    aflgL flanger gaFlangerSendL, adlt, kFlangerF, 20
    aflgR flanger gaFlangerSendR, adlt, kFlangerF, 20
    
    aflgL dcblock aflgL
    aflgR dcblock aflgR
    
    aoutL sum gaFlangerSendL * 0.5, aflgL * 0.5
    aoutR sum gaFlangerSendR * 0.5, aflgR * 0.5
    
    aoutL ntrpol gaFlangerSendL, aoutL, kFlangerMix
    aoutR ntrpol gaFlangerSendR, aoutR, kFlangerMix
    
    outs aoutL * kLev, aoutR * kLev
    
    gaFlangerSendL = aoutL * kLev
    gaFlangerSendR = aoutR * kLev
    
    gaDisplaySendL = gaDisplaySendL + gaFlangerSendL
    gaDisplaySendR = gaDisplaySendR + gaFlangerSendR
    
    clear gaFlangerSendL, gaFlangerSendR
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z

f1 0 32768 10 1                     ;sine
f2 0 1024 7 0 512 1 0 -1 512 0      ;saw
f10 0 1024 -8 1 256 1 256 .5 128 .3 128 .1 256 .1

i5 0 z
i10 0 z
i15 0 z
</CsScore>
</CsoundSynthesizer>
