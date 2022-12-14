.ALIASES
E_U1            U1(OUT=OUT_HIGHPASS +=N00406 -=N00302 +=N00406 -=N00302 ) CN
+@DASHA.SCHEMATIC1(sch_1):INS28@ANALOG.OPAMP.Normal(chips)
E_U2            U2(OUT=OUT_BANDPASS +=N00438 -=N00485 +=N00438 -=N00485 ) CN
+@DASHA.SCHEMATIC1(sch_1):INS46@ANALOG.OPAMP.Normal(chips)
E_U3            U3(OUT=OUT_LOWPASS +=N00516 -=N00369 +=N00516 -=N00369 ) CN
+@DASHA.SCHEMATIC1(sch_1):INS64@ANALOG.OPAMP.Normal(chips)
R_R1            R1(1=IN 2=N00302 ) CN @DASHA.SCHEMATIC1(sch_1):INS114@ANALOG.R.Normal(chips)
R_R2            R2(1=0 2=N00406 ) CN @DASHA.SCHEMATIC1(sch_1):INS132@ANALOG.R.Normal(chips)
R_R3            R3(1=0 2=N00438 ) CN @DASHA.SCHEMATIC1(sch_1):INS150@ANALOG.R.Normal(chips)
R_R4            R4(1=OUT_HIGHPASS 2=N00485 ) CN @DASHA.SCHEMATIC1(sch_1):INS168@ANALOG.R.Normal(chips)
R_R5            R5(1=N00302 2=OUT_HIGHPASS ) CN @DASHA.SCHEMATIC1(sch_1):INS186@ANALOG.R.Normal(chips)
R_R6            R6(1=N00485 2=OUT_BANDPASS ) CN @DASHA.SCHEMATIC1(sch_1):INS202@ANALOG.R.Normal(chips)
R_R7            R7(1=OUT_BANDPASS 2=N00369 ) CN @DASHA.SCHEMATIC1(sch_1):INS218@ANALOG.R.Normal(chips)
R_R8            R8(1=0 2=N00516 ) CN @DASHA.SCHEMATIC1(sch_1):INS236@ANALOG.R.Normal(chips)
R_R9            R9(1=OUT_LOWPASS 2=N00369 ) CN @DASHA.SCHEMATIC1(sch_1):INS254@ANALOG.R.Normal(chips)
R_R10           R10(1=OUT_LOWPASS 2=N00302 ) CN @DASHA.SCHEMATIC1(sch_1):INS270@ANALOG.R.Normal(chips)
R_R11           R11(1=OUT_BANDPASS 2=N00406 ) CN @DASHA.SCHEMATIC1(sch_1):INS286@ANALOG.R.Normal(chips)
C_C1            C1(1=N00485 2=OUT_BANDPASS ) CN @DASHA.SCHEMATIC1(sch_1):INS532@ANALOG.C.Normal(chips)
C_C2            C2(1=N00369 2=OUT_LOWPASS ) CN @DASHA.SCHEMATIC1(sch_1):INS548@ANALOG.C.Normal(chips)
V_V1            V1(+=IN -=0 ) CN @DASHA.SCHEMATIC1(sch_1):INS672@SOURCE.VAC.Normal(chips)
_    _(in=IN)
_    _(out_bandpass=OUT_BANDPASS)
_    _(out_highpass=OUT_HIGHPASS)
_    _(out_lowpass=OUT_LOWPASS)
.ENDALIASES
