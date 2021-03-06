//
//  BottomSheetTanggalVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 02/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import JTAppleCalendar
import DIKit

class BottomSheetTanggalVC: BaseViewController {
    
    @IBOutlet weak var imageCalendar: UIImageView!
    @IBOutlet weak var labelMonth: CustomLabel!
    @IBOutlet weak var labelFullDate: CustomLabel!
    @IBOutlet weak var collectionCalendar: JTACMonthView!
    
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private let formatter = DateFormatter()
    private var isFirstTimeOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initCollection()
    }
    
    private func setupView() {
        imageCalendar.image = UIImage(named: "calendarToday")?.tinted(with: UIColor.charcoalGrey)
        labelFullDate.text = PublicFunction.getStringDate(pattern: "EEEE, dd MMMM yyyy")
        labelMonth.text = PublicFunction.getStringDate(pattern: "MMMM yyyy")
    }
    
    private func initCollection() {
        collectionCalendar.calendarDelegate = self
        collectionCalendar.calendarDataSource = self
        collectionCalendar.register(UINib(nibName: "TanggalCell", bundle: .main), forCellWithReuseIdentifier: "TanggalCell")
        collectionCalendar.allowsMultipleSelection = true
        collectionCalendar.minimumLineSpacing = 0
        collectionCalendar.minimumInteritemSpacing = 0
        
        collectionCalendar.selectDates(rencanaPerjalananVM.selectedDates.value)
        collectionCalendar.reloadDates(collectionCalendar.selectedDates)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionCalendar.collectionViewLayout.invalidateLayout()
    }
}

extension BottomSheetTanggalVC {
    @IBAction func nextClick(_ sender: Any) {
        collectionCalendar.scrollToSegment(SegmentDestination.next, triggerScrollToDateDelegate: true, animateScroll: true)
    }
    @IBAction func previousClick(_ sender: Any) {
        collectionCalendar.scrollToSegment(SegmentDestination.previous, triggerScrollToDateDelegate: true, animateScroll: true)
    }
    @IBAction func closeClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BottomSheetTanggalVC: JTACMonthViewDataSource, JTACMonthViewDelegate {
    
    func configureCell(cell: JTACDayCell?, cellState: CellState) {
        guard let currentCell = cell as? TanggalCell else {
            return
        }
        
        currentCell.labelTanggal.text = cellState.text
        configureTextColorFor(cell: currentCell, cellState: cellState)
    }
    
    // Configure text colors
    func configureTextColorFor(cell: JTACDayCell?, cellState: CellState){
        guard let currentCell = cell as? TanggalCell else {
            return
        }
        
        currentCell.marginRightViewParent.constant = 3
        currentCell.marginLeftViewParent.constant = 3
        currentCell.marginTopViewParent.constant = 2
        currentCell.marginBottomViewParent.constant = 2
        
        if cellState.isSelected{
            currentCell.labelTanggal.textColor = UIColor.white
            currentCell.viewParent.backgroundColor = UIColor.mediumGreen
            currentCell.backgroundColor = UIColor.mediumGreen.withAlphaComponent(0.2)
            
            let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let firstDate = collectionCalendar.selectedDates.first ?? modifiedDate
            let lastDate = collectionCalendar.selectedDates.last ?? modifiedDate
            
            if collectionCalendar.selectedDates.count == 1 {
                currentCell.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: currentCell.frame.height / 2)
            } else if cellState.date == firstDate {
                if PublicFunction.dateToString(cellState.date, "EEEE") == "saturday".localize() {
                    currentCell.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: currentCell.frame.height / 2)
                } else {
                    currentCell.roundCorners([.topLeft, .bottomLeft], radius: currentCell.frame.height / 2)
                }
            } else if cellState.date == lastDate {
                if PublicFunction.dateToString(cellState.date, "EEEE") == "sunday".localize() {
                    currentCell.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: currentCell.frame.height / 2)
                } else {
                    currentCell.roundCorners([.topRight, .bottomRight], radius: currentCell.frame.height / 2)
                }
            } else {
                if PublicFunction.dateToString(cellState.date, "EEEE") == "saturday".localize() {
                    currentCell.roundCorners([.topRight, .bottomRight], radius: currentCell.frame.height / 2)
                } else if PublicFunction.dateToString(cellState.date, "EEEE") == "sunday".localize() {
                    currentCell.roundCorners([.topLeft, .bottomLeft], radius: currentCell.frame.height / 2)
                } else {
                    currentCell.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 0)
                }
            }
            
        } else {
            currentCell.backgroundColor = UIColor.white
            currentCell.viewParent.backgroundColor = UIColor.white
            
            let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            
            if cellState.dateBelongsTo == .thisMonth && cellState.date >= modifiedDate {
                currentCell.labelTanggal.textColor = UIColor.black
                currentCell.isUserInteractionEnabled = true
            } else {
                currentCell.labelTanggal.textColor = UIColor.gray
                currentCell.isUserInteractionEnabled = false
            }
        }
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "TanggalCell", for: indexPath) as! TanggalCell
        configureCell(cell: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.configureCell(cell: cell, cellState: cellState)
        }
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
          
        let firstDate = collectionCalendar.selectedDates.first ?? Date()
        let lastDate = collectionCalendar.selectedDates.last ?? Date()
        
        collectionCalendar.selectDates(from: firstDate, to: lastDate, triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: true)
        
        collectionCalendar.reloadDates(collectionCalendar.selectedDates)
        rencanaPerjalananVM.selectedDates.accept(collectionCalendar.selectedDates)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.configureCell(cell: cell, cellState: cellState)
        }
    }
    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        labelMonth.text = PublicFunction.dateToString(visibleDates.monthDates.first?.date ?? Date(), "MMMM yyyy")
    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        calendar.scrollingMode = .stopAtEachSection

        let startDate = formatter.date(from: PublicFunction.getStringDate(pattern: "dd-MM-yyyy"))!
        var dateComponents = DateComponents()
        dateComponents.year = 10
        let endDate = Calendar.current.date(byAdding: dateComponents, to: startDate)!

        let parameters = ConfigurationParameters(startDate: startDate,
                                endDate: endDate,
                                numberOfRows: 5,
                                calendar: Calendar.current,
                                generateInDates: .forAllMonths,
                                generateOutDates: .tillEndOfRow,
                                firstDayOfWeek: .sunday,
                                hasStrictBoundaries: true)
        return parameters
    }
    
}
