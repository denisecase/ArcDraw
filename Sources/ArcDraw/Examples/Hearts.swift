/***************************************************************
 Hearts
 **************************************************************

 This generates a picture of various hearts.
 */

 import CoreGraphics
 
     func  Hearts()
 {
 var        i: Int
 var        n: Int
 var        highCurveNum: Int
 var nullPoint = CGPoint.zero
 var anglePoint: CGPoint
// RECT      contentRect
 var        localIndex: Int

 var        numCurves = 8
 var        iAngle = [0, 1, 0, 1, 0, 1, 0, 1]
 var        appleAngle = [20.0, 164.0, 45.0, 133.0, 20.0, 200.0, 7.0, 170.0]
 var        numDots = [3, 3, 3, 3, 4, 4, 4, 4]
 var        x = [90+83, 155+83, 90+83,   90+83, 25+83, 90+83,
 270+83, 320+83, 270+83,   270+83, 220+83, 270+83,
 90+83, 162+83, 133+83, 90+83,   90+83, 18+83, 47+83, 90+83,
 270+83, 336+83, 316+83, 291+83,   270+83, 207+83, 230+83, 291+83]
 var        y = [80, 101, 194,   80, 101, 194,
 80, 132, 194,   80, 132, 194,
 332, 332, 415, 446,   332, 332, 415, 446,
 332, 325, 397, 446,   332, 353, 405, 446]
 
 var g = ArcDrawGlobals()  // initialize arc draw constants to local var named g

 highCurveNum = g.gHighCurveNum  // use any of the constants by starting with c.

 /*  Initialize some of the globals  */
 g.gAngleClick       = 0
 g.gAddDotClick       = 0
 g.gOldDotLoc         = nullPoint
 g.gOldAppleAngle     = 0
 g.gAppleAngle       = 0

 g.gSecondAngleFlag   = false
 g.gSketchFlag       = false
 g.gUndoFlag         = false
 g.gHighCurveNumFlag = false

 g.gDotSelectIndex   = 0
 g.gDeleteDotIndex   = 0
 g.gDragDotIndex     = 0
 g.gAddDotIndex       = 0
 g.gOldAngleIndex     = 0

// var n = 0
 let maxIndex = highCurveNum
// for ( n = 0; n <= highCurveNum; n+= )
 while i <= maxIndex {
 g.gHighDotNum[n]   = -1
 g.gAngleFlag[n]   = false
 g.gAngleIndex[n]   = 0
 }

 let maxIndex2 = 15*(highCurveNum + 1)
// for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
 while i <= maxIndex2 {
 g.gX[i]           = 0
 g.gY[i]           = 0
 g.gAlphai[i]       = 0.0
 g.gAlphaf[i]       = 0.0
 g.gStartAngle[i]  = 0
 g.gArcAngle[i]     = 0
 g.gXc[i]           = 0.0
 g.gYc[i]           = 0.0
 g.gR[i]           = 0.0
 g.gDotLoc[i]       = nullPoint

 g.gIsCW[i]         = 0
 }

// g.gMenuItem       = IDM_HEARTS
// g.gLastMenuItem   = IDM_HEARTS

 g.gHighCurveNum   = -1
 g.gCurveNum       = 0

 localIndex       = 0
 /*  End initialize some of the globals  */

 redraw()

 let maxIndex3 = numCurves - 1
// for ( n = 0;  n <= numCurves - 1;  n+= )
 while n <= maxIndex3{
 g.gHighCurveNum   = n
 g.gCurveNum     = g.gHighCurveNum
 g.gAngleIndex[n]   = 15*n + iAngle[n]

 let maxIndex4 = numDots[n] - 1
// for ( i = 0;  i <= numDots[n] - 1;  i+= )
 while i <= maxIndex4{
// g.gDotLoc[15*n + i].x = x[localIndex]
 g.gDotLoc[15*n + i].x = CGFloat(x[localIndex])
// g.gDotLoc[15*n + i].y = y[localIndex]
 g.gDotLoc[15*n + i].y = CGFloat(y[localIndex])
 g.gHighDotNum[n]   = i
 localIndex +=
 //  drawDot(dotIndex: 15*n + i)
 //  drawDot(dotIndex: 15*n + i)
  drawDot(dotIndex: 15*n + 1)
   dotAsRegion(dotIndex: 15*n + i)
 // Sleep(500)
DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
}

 }

   drawLargeDot(dotIndex: 15*n + iAngle[n])
// Sleep(1000)
 DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
}

 g.gAppleAngle   = appleAngle[n]
 g.gAngleFlag[n]   = true

 /*  Draw angle line  */
 anglePoint.x = g.gDotLoc[ 15*n + iAngle[n] ].x + 36*cos( g.gDegToRad*(90 - g.gAppleAngle) )
 anglePoint.y = g.gDotLoc[ 15*n + iAngle[n] ].y -
 36*sin( g.gDegToRad*(90 - g.gAppleAngle) )

// MoveToEx(g.gDotLoc[ 15*n + iAngle[n] ].x, g.gDotLoc[ 15*n + iAngle[n] ].y, NULL)
// LineTo(anglePoint.x, anglePoint.y)
 
 // Move to the start point (equivalent to MoveToEx)
        CGContext.move(to: startPoint)
        
        // Draw a line to the end point (equivalent to LineTo)
        CGContext.addLine(to: endPoint)

 //Sleep(1000)
 DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
}
 EraseLargeDot(15*n + iAngle[n] )

 /*  Erase angle line  */
 hPen = SelectObjectGetStockObject(WHITE_PEN)) // Erase lines
 MoveToEx(g.gDotLoc[ 15*n + iAngle[n] ].x, g.gDotLoc[ 15*n + iAngle[n] ].y, NULL)
 LineTo(anglePoint.x, anglePoint.y)

 hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen


 calcArcs()
 EraseLines(hWnd, hDC)
 DrawCurve(hWnd, hDC)
// Sleep(1000)
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
}
 }

 redraw()

 ReleaseDC()

 return
 } 

