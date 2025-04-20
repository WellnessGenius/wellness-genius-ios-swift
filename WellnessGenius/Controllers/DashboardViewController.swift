import UIKit
import HealthKit

class DashboardViewController: UIViewController {
    
    // MARK: - Properties
    private let healthStore = HKHealthStore()
    private var stepCount: Int = 0
    private var activeCalories: Double = 0
    private var heartRate: Double = 0
    private var bioAge: Double = 0
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, User!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todayStatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Stats"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stepCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Steps"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let caloriesView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activeCalsLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heartRateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let heartRateLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bpmLabel: UILabel = {
        let label = UILabel()
        label.text = "BPM"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioAgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bioAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioAgeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio Age"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadHealthData()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Dashboard"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(greetingLabel)
        contentView.addSubview(todayStatsLabel)
        
        contentView.addSubview(stepCountView)
        stepCountView.addSubview(stepCountLabel)
        stepCountView.addSubview(stepsLabel)
        
        contentView.addSubview(caloriesView)
        caloriesView.addSubview(caloriesLabel)
        caloriesView.addSubview(activeCalsLabel)
        
        contentView.addSubview(heartRateView)
        heartRateView.addSubview(heartRateLabel)
        heartRateView.addSubview(bpmLabel)
        
        contentView.addSubview(bioAgeView)
        bioAgeView.addSubview(bioAgeLabel)
        bioAgeView.addSubview(bioAgeTextLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            greetingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            greetingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            todayStatsLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 20),
            todayStatsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            todayStatsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stepCountView.topAnchor.constraint(equalTo: todayStatsLabel.bottomAnchor, constant: 20),
            stepCountView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stepCountView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            stepCountView.heightAnchor.constraint(equalToConstant: 150),
            
            stepCountLabel.centerXAnchor.constraint(equalTo: stepCountView.centerXAnchor),
            stepCountLabel.centerYAnchor.constraint(equalTo: stepCountView.centerYAnchor, constant: -10),
            
            stepsLabel.topAnchor.constraint(equalTo: stepCountLabel.bottomAnchor, constant: 5),
            stepsLabel.centerXAnchor.constraint(equalTo: stepCountView.centerXAnchor),
            
            caloriesView.topAnchor.constraint(equalTo: todayStatsLabel.bottomAnchor, constant: 20),
            caloriesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            caloriesView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            caloriesView.heightAnchor.constraint(equalToConstant: 150),
            
            caloriesLabel.centerXAnchor.constraint(equalTo: caloriesView.centerXAnchor),
            caloriesLabel.centerYAnchor.constraint(equalTo: caloriesView.centerYAnchor, constant: -10),
            
            activeCalsLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 5),
            activeCalsLabel.centerXAnchor.constraint(equalTo: caloriesView.centerXAnchor),
            
            heartRateView.topAnchor.constraint(equalTo: stepCountView.bottomAnchor, constant: 20),
            heartRateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heartRateView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            heartRateView.heightAnchor.constraint(equalToConstant: 150),
            
            heartRateLabel.centerXAnchor.constraint(equalTo: heartRateView.centerXAnchor),
            heartRateLabel.centerYAnchor.constraint(equalTo: heartRateView.centerYAnchor, constant: -10),
            
            bpmLabel.topAnchor.constraint(equalTo: heartRateLabel.bottomAnchor, constant: 5),
            bpmLabel.centerXAnchor.constraint(equalTo: heartRateView.centerXAnchor),
            
            bioAgeView.topAnchor.constraint(equalTo: caloriesView.bottomAnchor, constant: 20),
            bioAgeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bioAgeView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            bioAgeView.heightAnchor.constraint(equalToConstant: 150),
            bioAgeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            bioAgeLabel.centerXAnchor.constraint(equalTo: bioAgeView.centerXAnchor),
            bioAgeLabel.centerYAnchor.constraint(equalTo: bioAgeView.centerYAnchor, constant: -10),
            
            bioAgeTextLabel.topAnchor.constraint(equalTo: bioAgeLabel.bottomAnchor, constant: 5),
            bioAgeTextLabel.centerXAnchor.constraint(equalTo: bioAgeView.centerXAnchor)
        ])
    }
    
    // MARK: - Data Loading
    private func loadHealthData() {
        loadStepCount()
        loadActiveCalories()
        loadHeartRate()
        loadBioAge()
    }
    
    private func loadStepCount() {
        // This would fetch real step count data from HealthKit in a real app
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stepCount = 8432
            self.stepCountLabel.text = "\(self.stepCount)"
        }
    }
    
    private func loadActiveCalories() {
        // This would fetch real active calories data from HealthKit in a real app
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activeCalories = 425.5
            self.caloriesLabel.text = "\(Int(self.activeCalories))"
        }
    }
    
    private func loadHeartRate() {
        // This would fetch real heart rate data from HealthKit in a real app
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.heartRate = 72.0
            self.heartRateLabel.text = "\(Int(self.heartRate))"
        }
    }
    
    private func loadBioAge() {
        // This would fetch bio age from the Wellness Genius API in a real app
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.bioAge = 32.5
            self.bioAgeLabel.text = "\(Int(self.bioAge))"
        }
    }
}
