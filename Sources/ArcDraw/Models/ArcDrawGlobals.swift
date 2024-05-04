import Foundation


/// Structure containing ArcDraw Constants
struct ArcDrawGlobals {
  var gAddDotClick: Int = 0
	var gAddDotIndex: Int = 0
	var gAlphai: [Double] = [Double]()
	var gAlphaf: [Double] = [Double]()
	var gAngleClick: Int = 0
	var gAngleFlag: [Bool] = [Bool]()
	var gAngleIndex: [Int] = [Int]()
	var gAngleIndexAfter: Int = 0
	var gAngleIndexBefore: Int = 0
	var gCurveNum: Int = 0
	var gDeleteDotIndex: Int = 0
	var gDirAngle: Double = 0.0
	var gDotLoc: [CGPoint] = [CGPoint]()
	var gDotRgnRect: [CGRect] = [CGRect]()
	var gDotSelectIndex: Int = 0
	var gDragDotIndex: Int = 0
	var gDragFlag: Int = 0
	var gEndAngle: [Double] = [Double]()
	var gHighCurveNum: Int = 0
	var gHighDotNum: [Int] = [Int]()
	var gIsCW: [Int] = [Int]()
	var gIsStillDown: Int = 0
	var gLastMenuItem: Int = 0
	var gLastMouse: CGPoint = CGPoint.zero
	var gMenuItem: Int = 0
	var gOldAngleIndex: Int = 0
	var gOldDirAngle: Double = 0.0
	var gOldDotLoc:CGPoint = CGPoint.zero
	var gPi:Double = 3.141592653589793238;
	var gPtIsInARect: Int = 0
	var gR: [Double] = [Double]()
	var gShowDots: Int = 1
	var gStartAngle: [Double] = [Double]()
	var gX: [Double] = [Double]()
	var gXc: [Double] = [Double]()
	var gY: [Double] = [Double]()
	var gYc: [Double] = [Double]()
	var gFirstDotNum: Int = 0
	var gDotTry: Int = 0
	var gDirPt:CGPoint = CGPoint.zero
  var gOldAppleAngle = 0.0
  var gAppleAngle = 0.0
  var gSketchFlag = false
  var gSecondAngleFlag = false
  var gUndoFlag = false
  var gHighCurveNumFlag = false
  var gArcAngle: [Double] = [Double]()
  var gDegToRad = 3.141592653589793238/180.0
  var gRadToDeg = 180.0/3.141592653589793238
  
  
}
