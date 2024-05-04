/***************************************************************
 Spirals
 **************************************************************

 This generates a picture of various spirals.
 */
 
 import CoreGraphics
 
     func  Spirals()
 {

 var        i: Int
 var        n: Int
 var        highCurveNum: Int
 var nullPoint = CGPoint.zero
 var anglePoint: CGPoint
 RECT      contentRect;
 var        localIndex: Int

 var        numCurves = 2
 var        iAngle[2] = [{0, 5]
 var        appleAngle[2] = [0.0, 180.0]}
 var        numDots[2] = [12, 11]
 var        x[23] = [198+83, 162+83, 216+83, 144+83, 234+83, 126+83,
 252+83, 108+83, 270+83, 90+83, 288+83, 72+83,
 126+83, 144+83, 108+83, 162+83, 90+83, 180+83,
 270+83, 198+83, 252+83, 216+83, 234+83]
 var        y[23] = [126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126,
 378, 378, 378, 378, 378, 378, 378, 378, 378, 378, 378]
 
 var g = ArcDrawGlobals()  // initialize arc draw constants to local var named g

 HPEN      hPen

 highCurveNum = g.gHighCurveNum;

 /*  Initialize some of the globals  */
 g.gAngleClick = 0
 g.gAddDotClick = 0
 g.gOldDotLoc = nullPoint
 g.gOldAppleAngle = 0.0
 g.gAppleAngle = 0.0

 g.gSecondAngleFlag = false
 g.gSketchFlag = false
 g.gUndoFlag = false
 g.gHighCurveNumFlag = false

 g.gDotSelectIndex = 0
 g.gDeleteDotIndex = 0
 g.gDragDotIndex = 0
 g.gAddDotIndex = 0
 g.gOldAngleIndex = 0

 for ( n = 0; n <= highCurveNum; n+= )
 {
 gHighDotNum[n] = -1
 gAngleFlag[n] = false
 gAngleIndex[n] = 0
 }

 for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
 {
 gX[i] = 0
 gY[i] = 0
 gAlphai[i] = 0.0
 gAlphaf[i] = 0.0
 gStartAngle[i] = 0
 gArcAngle[i] = 0.0
 gXc[i] = 0.0
 gYc[i] = 0.0
 gR[i] = 0.0
 gDotLoc[i] = nullPoint

 gIsCW[i] = 0
 }

 gMenuItem     = IDM_SPIRALS
 gLastMenuItem   = IDM_SPIRALS

 gHighCurveNum   = -1
 gCurveNum     = 0

 localIndex = 0
 /*  End initialize some of the globals  */

 redraw(hWnd, hDC)

 for ( n = 0;  n <= numCurves - 1;  n+= )
 {
 gHighCurveNum   = n
 gCurveNum     = gHighCurveNum
 gAngleIndex[n]   = 15*n + iAngle[n]

 for ( i = 0;  i <= numDots[n] - 1;  i+= )
 {
 gDotLoc[15*n + i].x = x[localIndex]
 gDotLoc[15*n + i].y = y[localIndex]
 gHighDotNum[n]   = i
 localIndex +=
 drawDot(hWnd, hDC, 15*n + i)
 dotAsRegion(15*n + i)
// Sleep(500)
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
}
 }

 drawLargeDot(15*n + iAngle[n])
// Sleep(1000)
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
}

 gAppleAngle   = appleAngle[n]
 gAngleFlag[n]   = true

 /*  Draw angle line  */
 anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x +
 36*cos( gDegToRad*(90 - gAppleAngle) )
 anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y -
 36*sin( gDegToRad*(90 - gAppleAngle) )

 MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
 LineTo(hDC, anglePoint.x, anglePoint.y)

// Sleep(1000)
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
}
 EraseLargeDot(hWnd, hDC, 15*n + iAngle[n] )

 /*  Erase angle line  */
 hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
 MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
 LineTo(hDC, anglePoint.x, anglePoint.y)
 hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen

 calcArcs()
 EraseLines(hWnd, hDC)
 drawCurve(hWnd, hDC)
// Sleep(1000)
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
}
 }

 redraw(hWnd, hDC)

 ReleaseDC(hWnd, hDC)

 return
 } 
