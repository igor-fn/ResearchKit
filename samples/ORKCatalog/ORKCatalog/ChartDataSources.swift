/*
Copyright (c) 2015, James Cox. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3.  Neither the name of the copyright holder(s) nor the names of any contributors
may be used to endorse or promote products derived from this software without
specific prior written permission. No license is granted to the trademarks of
the copyright holders even if such marks are included in this software.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import ResearchKit

class PieChartDataSource: NSObject, ORKPieChartViewDataSource {
    
    lazy var backingStore: [UIColor] = { [unowned self] in
        return self.randomColors(8)
    }()
    
    func randomColors(number: Int) -> [UIColor] {
        
        func random() -> CGFloat {
            return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        }
        
        var colors: [UIColor] = []
        for index in 0..<number {
            colors.append(UIColor(red: random(), green: random(), blue: random(), alpha: 1))
        }
        return colors
    }
    
    func numberOfSegmentsInPieChartView(pieChartView: ORKPieChartView ) -> Int {
        return backingStore.count
    }
    
    func pieChartView(pieChartView: ORKPieChartView, valueForSegmentAtIndex index: Int) -> CGFloat {
        return CGFloat(index + 1)
    }
    
    func pieChartView(pieChartView: ORKPieChartView, colorForSegmentAtIndex index: Int) -> UIColor {
        return backingStore[index]
    }
    
    func pieChartView(pieChartView: ORKPieChartView, titleForSegmentAtIndex index: Int) -> String {
        return "Title \(index + 1)"
    }
}

class LineGraphDataSource: NSObject, ORKGraphViewDataSource {
    
    var firstPlot = [
        ORKRangedPoint(value: 20),
        ORKRangedPoint(value: 25),
        ORKRangedPoint(),
        ORKRangedPoint(value: 30),
        ORKRangedPoint(value: 40),
        ] as [ORKRangedPoint]
    var secondPlot = [
        ORKRangedPoint(value: 2),
        ORKRangedPoint(value: 4),
        ORKRangedPoint(value: 8),
        ORKRangedPoint(value: 16),
        ORKRangedPoint(value: 32),
        ORKRangedPoint(value: 64),
        ] as [ORKRangedPoint]
    
    func graphView(graphView: ORKGraphView, pointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKRangedPoint {
        return plotIndex == 0 ? firstPlot[pointIndex] : secondPlot[pointIndex]
    }
    
    func graphView(graphView: ORKGraphView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        return plotIndex == 0 ? firstPlot.count : secondPlot.count
    }
    
    func numberOfPlotsInGraphView(graphView: ORKGraphView) -> Int {
        return 2
    }
    
    func numberOfDivisionsInXAxisForGraphView(graphView: ORKGraphView) -> Int {
        return max(firstPlot.count, secondPlot.count)
    }
    
    func maximumValueForGraphView(graphView: ORKGraphView) -> CGFloat {
        return 70;
    }
    
    func minimumValueForGraphView(graphView: ORKGraphView) -> CGFloat {
        return 0
    }
    
    func graphView(graphView: ORKGraphView, titleForXAxisAtIndex pointIndex: Int) -> String {
        return "\(pointIndex + 1)"
    }
}

class DiscreteGraphDataSource: NSObject, ORKGraphViewDataSource {
    
    var firstPlot: [ORKRangedPoint] {
        return [
            ORKRangedPoint(minimumValue: 0, maximumValue: 2),
            ORKRangedPoint(minimumValue: 1, maximumValue: 3),
            ORKRangedPoint(minimumValue: 2, maximumValue: 6),
            ORKRangedPoint(minimumValue: 3, maximumValue: 9),
            ORKRangedPoint(minimumValue: 4, maximumValue: 13),
        ]
    }
    
    var secondPlot: [ORKRangedPoint] {
        return [
            ORKRangedPoint(value: 1),
            ORKRangedPoint(minimumValue: 2, maximumValue: 4),
            ORKRangedPoint(minimumValue: 3, maximumValue: 8),
            ORKRangedPoint(minimumValue: 5, maximumValue: 11),
            ORKRangedPoint(minimumValue: 7, maximumValue: 13),
            ORKRangedPoint(minimumValue: 10, maximumValue: 13),
        ]
    }
    
    func graphView(graphView: ORKGraphView, pointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKRangedPoint {
        return plotIndex == 0 ? firstPlot[pointIndex] : secondPlot[pointIndex]
    }
    
    func graphView(graphView: ORKGraphView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        return plotIndex == 0 ? firstPlot.count : secondPlot.count
    }
    
    func maximumValueForGraphView(graphView: ORKGraphView) -> CGFloat {
        return 13;
    }
    
    func minimumValueForGraphView(graphView: ORKGraphView) -> CGFloat {
        return 0
    }
    
    func graphView(graphView: ORKGraphView, titleForXAxisAtIndex pointIndex: Int) -> String {
        return "\(pointIndex + 1)"
    }
    
    func numberOfPlotsInGraphView(graphView: ORKGraphView) -> Int {
        return 2
    }
    
    func numberOfDivisionsInXAxisForGraphView(graphView: ORKGraphView) -> Int {
        return max(firstPlot.count, secondPlot.count)
    }
}
