<CsoundSynthesizer>
<CsOptions>
-+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

instr 1 ; sine wave
	;aSin	oscils 0dbfs/4, 440, 0
	;out aSin
	/*kSin chnget "sinWave"
	kSinChange changed kSin
	kSaw chnget "sawWave"
	kSawChange changed kSaw
	
	if kSinChange == 1 kgoto sinWave
	if kSawChange == 1 kgoto sawWave
	
		iFreq = p4
		iAmp = 0dbfs/4
		aOut vco2 iAmp, iFreq
		
	sinWave:
		iFreq = p4
		iAmp = 0dbfs/4
		aOut oscili iAmp, iFreq
		outs aOut, aOut
		goto End
	sawWave:
		outs aOut
		goto End
	End:*/
	iFreq = p4
	iAmp = 0dbfs/4
	iWave invalue "waveform"
	aOut oscili iAmp, iFreq, iWave
	outs aOut, aOut
endin


instr 2 ; saw wave 
	aOut vco2 1, 440
	out aOut
endin

instr 3 ; square wave
endin

instr 4 ; triangle wave
endin

</CsInstruments>
<CsScore>
f1 0 4096 10 1 
f2 0 4096 10 1 .5
f3 0 4096 10 1 .5 .2 .1 
	f0 z
   ; a sine wave.
   ; saw

</CsScore>
</CsoundSynthesizer>


<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>311</x>
 <y>139</y>
 <width>882</width>
 <height>375</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>174</r>
  <g>214</g>
  <b>240</b>
 </bgcolor>
 <bsbObject type="BSBButton" version="2">
  <objectName>sinWave</objectName>
  <x>60</x>
  <y>28</y>
  <width>146</width>
  <height>126</height>
  <uuid>{1719fe6c-cfee-4d9e-8b69-046b8fafc59e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <type>value</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>Sin Wave</text>
  <image>/</image>
  <eventLine/>
  <latch>true</latch>
  <momentaryMidiButton>false</momentaryMidiButton>
  <latched>false</latched>
  <fontsize>15</fontsize>
 </bsbObject>
 <bsbObject type="BSBButton" version="2">
  <objectName>button2</objectName>
  <x>59</x>
  <y>203</y>
  <width>146</width>
  <height>126</height>
  <uuid>{7f2060d6-bf4d-4ce1-a5cd-d8184d0ac653}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <type>event</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>Square Wave</text>
  <image>/</image>
  <eventLine>i1 0 10</eventLine>
  <latch>false</latch>
  <momentaryMidiButton>false</momentaryMidiButton>
  <latched>false</latched>
  <fontsize>15</fontsize>
 </bsbObject>
 <bsbObject type="BSBButton" version="2">
  <objectName>Button3</objectName>
  <x>247</x>
  <y>202</y>
  <width>146</width>
  <height>126</height>
  <uuid>{b5155738-c270-497e-a6f5-6767c2b77cf3}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <type>event</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>Triangle Wave</text>
  <image>/</image>
  <eventLine>i1 0 10</eventLine>
  <latch>false</latch>
  <momentaryMidiButton>false</momentaryMidiButton>
  <latched>false</latched>
  <fontsize>15</fontsize>
 </bsbObject>
 <bsbObject type="BSBButton" version="2">
  <objectName>sawWave</objectName>
  <x>246</x>
  <y>27</y>
  <width>146</width>
  <height>126</height>
  <uuid>{b99c15db-6723-4aab-a393-549074174d74}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <type>value</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>Saw Wave</text>
  <image>/</image>
  <eventLine>i 1 0 1</eventLine>
  <latch>true</latch>
  <momentaryMidiButton>false</momentaryMidiButton>
  <latched>true</latched>
  <fontsize>15</fontsize>
 </bsbObject>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>slider4</objectName>
  <x>454</x>
  <y>26</y>
  <width>75</width>
  <height>303</height>
  <uuid>{7e9427b4-04ec-43b2-8f6c-54b43a8897b8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.18481848</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>451</x>
  <y>337</y>
  <width>80</width>
  <height>25</height>
  <uuid>{d1e76060-48e9-42ae-862b-e59c1008dc2c}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>Pitch</label>
  <alignment>center</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>32</r>
   <g>235</g>
   <b>220</b>
  </bgcolor>
  <bordermode>true</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>2</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>waveform</objectName>
  <x>619</x>
  <y>202</y>
  <width>80</width>
  <height>25</height>
  <uuid>{c7e01939-ca81-46d5-bc3a-66c15a558d09}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>1.00000000</resolution>
  <minimum>0</minimum>
  <maximum>5</maximum>
  <randomizable group="0">false</randomizable>
  <value>4</value>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
