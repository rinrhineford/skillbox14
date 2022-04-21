//
//  WeatherPageViewController.swift
//  Skillbox HW 12
//
//  Created by Nikita Selianin on 06.08.2020.
//  Copyright © 2020 Nikita Selianin. All rights reserved.
//

import UIKit

class WeatherPageViewController: UIPageViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        self.view.backgroundColor = .systemGray6
        setViewControllers([weatherControllers[0]], direction: .forward, animated: true, completion: nil)
    }

    let mainWeatherPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainWeatherScreen") as! MainWeatherViewController
    let dailyWeatherPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DailyWeatherScreen") as! DailyWeatherViewController
    
    // MARK: - VC
    lazy var weatherControllers = [mainWeatherPage, dailyWeatherPage]
}



extension WeatherPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = weatherControllers.firstIndex(of: viewController) {
            if index > 0 {
                return weatherControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = weatherControllers.firstIndex(of: viewController) {
            if index < weatherControllers.count - 1 {
                return weatherControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return weatherControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
