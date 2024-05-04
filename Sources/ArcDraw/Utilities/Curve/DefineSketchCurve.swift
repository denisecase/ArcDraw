/***************************************************************
 defineSketchCurve
 **************************************************************

 This picks up the mouse movement after New Sketch Curve is selected in the ArcDraw
 menu and we click in the content region of our window. We set the positions for
 the dots of a curve.

 The curve number must have been defined somewhere in order to get here, normally in
 NewSketchCurve.

 When drawing and moving arcDraw curves we deal in Windows coordinates.

 Changes: loads dots in global array
 */
    func  defineSketchCurve (LPARAM  lParam)
 {
 var firstPoint: CGPoint
 var        x1: Int
 var        x3: Int
 var        y1: Int
 var        y3: Int
 //      var        dummy: Int
 var        i: Int

 var      posnx: Double
 var      posny: Double
 var posn: CGPoint
 
 var g = ArcDrawGlobals()  // initialize arc draw constants to local var named g

 posnx   = LOWORD(lParam)
 posny   = HIWORD(lParam)

 posn.x  =  posnx
 posn.y  =  posny


 /*  For first dot  */
 if gSketchClick == 1
 {
 firstPoint   = posn
 gArcLength   = 0
 gEnergyFlag = false

 defineSketchDot(hWnd, hDC, firstPoint)  //  Define first Sketch Dot
 MoveToEx (hDC, firstPoint.x, firstPoint.y, NULL)
 gLastMouse = firstPoint
 ReleaseDC(hWnd, hDC)
 return
 }

 /*  For later dots  */
 if gMouseDown == true && gSketchClick > 1 && gEnergyFlag == false
 {
 if posn.x != gLastMouse.x || posn.y != gLastMouse.y
 {
 LineTo(hDC, posnx, posny)
 gArcLength = gArcLength + sqrt
 ( (posn.x - gLastMouse.x)*(posn.x - gLastMouse.x)
 + (posn.y - gLastMouse.y)*(posn.y - gLastMouse.y) )
 gLastMouse = posn

 if (gArcLength >= 40) && (gAngleFlag2 == false)  //  Minimum length of curve
 {
 gAnglePoint2 = posn
 gAngleFlag2 = true
 }

 if gArcLength >= 80
 {
 if g.gHighDotNum[g.gCurveNum] < 13    //  Define Sketch Dots
 {
 g.gHighDotNum[g.gCurveNum] +=
 defineSketchDot(gLastMouse)  // Calls DrawSketchDot
 }
 gArcLength = 0
 }

 }  //End if (unequal positions)

 ReleaseDC()
 return

 }  //  End if(gMouseDown == true)

 if gAngleFlag2 == true && gEnergyFlag == false
 {
 /*   Define last sketch dot if gArcLength is great enough    */
 if gArcLength >= 60
 {
 g.gHighDotNum[g.gCurveNum] +=
 defineSketchDot(posn)
 }

 x1 = g.gDotLoc[15*g.gCurveNum].x
 x3 = gAnglePoint2.x

 y1 = -g.gDotLoc[15*g.gCurveNum].y
 y3 = -gAnglePoint2.y

 gAlpha1 = gRadToDeg*atan2(y3 - y1, x3 - x1)

 if gAlpha1 < 0.0 {
 gAlpha1 = gAlpha1 + 360.0 }  //  To get initially in range of 0.0 to 360.0

 g.gAppleAngle = 90.0 - gAlpha1

 if g.gAppleAngle < 0 {
 g.gAppleAngle = g.gAppleAngle + 360.0 }

 g.gSecondAngleFlag = false
 g.gAngleFlag[g.gCurveNum] = true
 g.gAngleIndex[g.gCurveNum] = 15*g.gCurveNum

 calcArcs()

 //  First, find gUt0 with original gAppleAngle
 gUt0 = 0.0
 for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
 {
 gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
 gUt0 = gUt0 + gU[i]
 }

 //  Then, find gUt1 with smaller gAppleAngle
 gAlpha1 = gAlpha1 + 1

 gAppleAngle = 90.0 - gAlpha1

 if g.gAppleAngle < 0 {
 g.gAppleAngle = g.gAppleAngle + 360.0 }

 calcArcs()

 gUt1 = 0.0
 for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
 {
 gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
 gUt1 = gUt1 + gU[i]
 }

 //  Then, find gUt2 with larger gAppleAngle
 gAlpha1 = gAlpha1 - 2

 gAppleAngle = 90.0 - gAlpha1

 if g.gAppleAngle < 0.0 {
 g.gAppleAngle = g.gAppleAngle + 360.0 }

 calcArcs()

 gUt2 = 0.0
 for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
 {
 gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
 gUt2 = gUt2 + gU[i]
 }

 }    //  End if (angleFlag2)

 else if gEnergyFlag == false
 {
 g.gHighDotNum[g.gCurveNum] = -1
 MessageBox  (hWnd,
 "Curve is too short.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC()
 return
 }

 // Now iterate to minimize energy in the curve
 // We have one less arc than points in the curve

 if gUt0 < gUt1 && gUt0 < gUt2 {  //  Must reduce gAppleAngle by 1 degree
 gAlpha1 = gAlpha1 + 1 }

 else if gUt1 < gUt0  //  Must reduce gAppleAngle by 2 degrees
 {
 gAlpha1 = gAlpha1 + 2  //  To get gAppleAngle back to where it was for gUt1

 while gUt1 < gUt0
 {
 gUt0 = gUt1

 gAlpha1 = gAlpha1 + 1

 g.gAppleAngle = 90.0 - gAlpha1

 if g.gAppleAngle < 0 {
 g.gAppleAngle = g.gAppleAngle + 360.0 }

 calcArcs()

 gUt1 = 0.0
 for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
 {
 gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
 gUt1 = gUt1 + gU[i]
 }

 }  //  end while

 gAlpha1 = gAlpha1 - 1

 }  //  End else if

 else  //  gAppleAngle OK as is
 {
 while gUt2 < gUt0
 {
 gUt0 = gUt2

 gAlpha1 = gAlpha1 - 1

 g.gAppleAngle = 90.0 - gAlpha1

 if g.gAppleAngle < 0 {
 g.gAppleAngle = g.gAppleAngle + 360.0 }

 calcArcs()

 gUt2 = 0.0
 for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
 {
 gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
 gUt2 = gUt2 + gU[i]
 }
 }  //  End while

 gAlpha1 = gAlpha1 + 1

 }  //  End else

 g.gAppleAngle = 90.0 - gAlpha1

 if g.gAppleAngle < 0 {
 g.gAppleAngle = g.gAppleAngle + 360.0 }

 calcArcs()
 redraw()
 gEnergyFlag = true

 //      dummy = x1 + x3 + y1 + y3 + gMenuItem + gAlpha1 + i

 g.gLastMenuItem  = IDM_NEWSKETCHCURVE

 g.gAngleFlag[g.gHighCurveNum] = true
 g.gDotSelectIndex            = 0
 gSketchClick              = 1
 gAngleFlag2               = false


 if g.gHighCurveNum < 19  //  gHighCurveNum starts at -1
 {
 g.gHighCurveNum +=
 g.gCurveNum    = g.gHighCurveNum
 g.gMenuItem    = IDM_NEWSKETCHCURVE
 g.gSketchFlag = true

 }

 else {
 g.gHighCurveNumFlag = true }

 ReleaseDC()

 return
 } 
