//
//  CarFitTests.swift
//  CarFitTests
//
//  Test Project
//

import XCTest
@testable import CarFit

class CarFitTests: XCTestCase {

    let visitJSON = """
    {
        "visitId": "ec94deca-d66a-4d62-b049-72414870de00",
        "homeBobEmployeeId": "85f99bd7-ffd2-4ca7-1174-08d7984a4cf3",
        "houseOwnerId": "9f2efc9b-c275-474c-aec9-4f9bd063b46a",
        "isBlocked": false,
        "startTimeUtc": "2020-05-30T09:15:00",
        "endTimeUtc": "2020-05-30T09:40:00",
        "title": "Add title",
        "isReviewed": false,
        "isFirstVisit": false,
        "isManual": false,
        "visitTimeUsed": 0,
        "rememberToday": null,
        "houseOwnerFirstName": "Mads",
        "houseOwnerLastName": "Kolding",
        "houseOwnerMobilePhone": "+4531952906",
        "houseOwnerAddress": "Sorgenfrigårdsvej 54 st th",
        "houseOwnerZip": "2800",
        "houseOwnerCity": "Lyngby",
        "houseOwnerLatitude": 55.776500,
        "houseOwnerLongitude": 12.512700,
        "isSubscriber": false,
        "rememberAlways": null,
        "professional": "Test",
        "visitState": "ToDo",
        "stateOrder": 2,
        "expectedTime": null,
        "tasks": [
            {
                "taskId": "9a5f6a07-aad8-4510-8686-de8a2b824113",
                "title": "Pudsning udvendig",
                "isTemplate": false,
                "timesInMinutes": 35,
                "price": 175.00,
                "paymentTypeId": "9f40509b-191d-4c61-946e-0e816b63088d",
                "createDateUtc": "2020-05-30T20:04:07.3063091",
                "lastUpdateDateUtc": "2020-05-30T20:04:07.3063118",
                "paymentTypes": null
            }
        ],
        "houseOwnerAssets": [],
        "visitAssets": [],
        "visitMessages": []
    }
    """

    let taskJSON = """
    {
        "taskId": "e4131f30-6beb-45aa-9fcf-02758f332219",
        "title": "Pudsning indvendig",
        "isTemplate": false,
        "timesInMinutes": 25,
        "price": 99.00,
        "paymentTypeId": "51d14bdf-8d83-49fa-843d-787ceba4bb40",
        "createDateUtc": "2020-05-28T20:01:56.8831511",
        "lastUpdateDateUtc": "2020-05-28T20:01:56.8831539",
        "paymentTypes": null
    }
    """

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTaskDecodefromJSON() throws {
        let jsonData = taskJSON.data(using: .utf8)
        let task: Task? = try? Task.decodeWith(data: jsonData!)
        XCTAssertNotNil(task)
    }

    func testVisitDataDecodefromJSON() throws {
        let jsonData = visitJSON.data(using: .utf8)
        let visits: VisitsData? = try? VisitsData.decodeWith(data: jsonData!)
        XCTAssertNotNil(visits)
    }

    func testVisitDataModel() throws {
        let jsonData = visitJSON.data(using: .utf8)
        let visits: VisitsData? = try? VisitsData.decodeWith(data: jsonData!)
        XCTAssertNotNil(visits)
        let viewModel = VisitsDataModel(with: visits!)
        XCTAssertTrue(viewModel.location == "Sorgenfrigårdsvej 54 st th 2800 Lyngby")
        XCTAssertTrue(viewModel.fullName == "Mads Kolding")
        XCTAssertNil(viewModel.expectedTime)
        XCTAssertTrue(viewModel.taskDescription() == "Pudsning udvendig")
        XCTAssertTrue(viewModel.requiredTime() == 35)
    }

    func testCalendarViewModel() throws {
        let viewModel = CalendarViewModel()
        viewModel.month = 2
        viewModel.year = 2020

        XCTAssertTrue(viewModel.monthTitle == "Feb")
        XCTAssertTrue(viewModel.numberOfDaysIn() == 29)
        XCTAssertTrue(viewModel.dayOfWeek(day: 1) == "Sat")
        XCTAssertFalse(viewModel.isCurrentDate(day: 1))

        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = Int(dateFormatter.string(from: currentDate))
        dateFormatter.dateFormat = "MM"
        let month = Int(dateFormatter.string(from: currentDate))
        dateFormatter.dateFormat = "dd"
        let day = Int(dateFormatter.string(from: currentDate))
        viewModel.month = month!
        viewModel.year = year!

        XCTAssertTrue(viewModel.isCurrentDate(day: day!))
    }

    func testCleanerListViewModel() throws {
        let viewModel = CleanerListViewModel()
        viewModel.getVisits()
        XCTAssertNotNil(viewModel.visits)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
