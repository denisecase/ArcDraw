/***************************************************************
 NewSketchCurve
 **************************************************************

 This starts a new curve, in the sketch mode.

 Changes: curve number
 */
    func  NewSketchCurve()
 {
 if gHighCurveNum < 19  //  gHighCurveNum starts at -1
 {
 gHighCurveNum +=
 gCurveNum    = gHighCurveNum
 gMenuItem    = IDM_NEWSKETCHCURVE
 gSketchFlag = true
 gAngleFlag2 = false
 }

 else {
 gHighCurveNumFlag = true }

 return
 } 
