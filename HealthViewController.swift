//
//  HealthViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/6.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit
import HealthKit
enum ProfileViewControllerTableViewIndex : Int {
    case Age = 0
    case Height
    case Weight
}

enum ProfileKeys : String {
    case Age = "age"
    case Height = "height"
    case Weight = "weight"
}

class HealthViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    private let kProfileUnit = 0
    private let kProfileDetail = 1
    
    var healthStore: HKHealthStore?
    
    private var userProfiles: [ProfileKeys: [String]]?
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var right2Image: UIImageView!
    @IBOutlet weak var left2Image: UIImageView!
    @IBOutlet weak var right1Image: UIImageView!
    @IBOutlet weak var left1Image: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = true
        // Do any additional setup after loading the view.
        setImage()
        
    }
    func setImage (){
        userImage.image = UIImage.init(named: "健康A")
        userImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(userImageTouchAction))
        userImage.addGestureRecognizer(gesture)
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 2
        userImage.layer.borderColor = UIColor.red.cgColor
        userImage.layer.cornerRadius = userImage.frame.size.height/4
        
        left1Image.clipsToBounds = true
        left1Image.layer.borderWidth = 2
        left1Image.layer.borderColor = UIColor.red.cgColor
        left1Image.layer.cornerRadius = left1Image.frame.size.width/5
        
        left2Image.clipsToBounds = true
        left2Image.layer.borderWidth = 2
        left2Image.layer.borderColor = UIColor.red.cgColor
        left2Image.layer.cornerRadius = left2Image.frame.size.width/5
        
        right1Image.clipsToBounds = true
        right1Image.layer.borderWidth = 2
        right1Image.layer.borderColor = UIColor.red.cgColor
        right1Image.layer.cornerRadius = left2Image.frame.size.width/5
        
        right2Image.clipsToBounds = true
        right2Image.layer.borderWidth = 2
        right2Image.layer.borderColor = UIColor.red.cgColor
        right2Image.layer.cornerRadius = left2Image.frame.size.width/5
    }
    
    
    //userImage触摸事件
    func userImageTouchAction(){
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
        let picVc = UIImagePickerController()
        picVc.sourceType = .photoLibrary
        picVc.allowsEditing = true
        picVc.delegate = self
        present(picVc, animated: true, completion: nil)
    
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //显示的图片
        let image:UIImage!
        if isEditing {
            //获取编辑后的图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //获取选择的原图
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        
        self.userImage.image = image
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }

      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func dataTypesToWrite() -> Set<HKSampleType> {
        
        let dietaryCalorieEnergyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
        let activeEnergyBurnType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let heightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        let writeDataTypes: Set<HKSampleType> = [dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType]
        
        return writeDataTypes
    }
    
    private func dataTypesToRead() -> Set<HKObjectType> {
        
        let dietaryCalorieEnergyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
        let activeEnergyBurnType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let heightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let birthdayType = HKQuantityType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!
        let biologicalSexType = HKQuantityType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!
        
        let readDataTypes: Set<HKObjectType> = [dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, birthdayType, biologicalSexType]
        
        return readDataTypes
    }
    

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Set up an HKHealthStore, asking the user for read/write permissions. The profile view controller is the
        // first view controller that's shown to the user, so we'll ask for all of the desired HealthKit permissions now.
        // In your own app, you should consider requesting permissions the first time a user wants to interact with
        // HealthKit data.
        guard HKHealthStore.isHealthDataAvailable() else {
            
            return
        }
        
        let writeDataTypes: Set<HKSampleType> = self.dataTypesToWrite()
        let readDataTypes: Set<HKObjectType> = self.dataTypesToRead()
        
        let completion: ((Bool, Error?) -> Void)! = {
            (success, error) -> Void in
            
            if !success {
                
                print("You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: \(error). If you're using a simulator, try it on a device.")
                
                return
            }
            
            DispatchQueue.main.async{
                
                // Update the user interface based on the current user's health information.
                self.updateUserAge()
                self.updateUsersHeight()
                self.updateUsersWeight()
            }
        }
        
        if let healthStore = self.healthStore {
            
            healthStore.requestAuthorization(toShare: writeDataTypes, read: readDataTypes, completion: completion)
        }
    }
    private func updateUserAge() -> Void
    {
        var dateOfBirth: Date! = nil
        
        do {
            
            dateOfBirth = try self.healthStore?.dateOfBirth()
            
        } catch {
            
            print("Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.")
            
            return
        }
        
        let now = Date()
        
        let ageComponents: DateComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: now)
        
        let userAge: Int = ageComponents.year!
        
        let ageValue: String = NumberFormatter.localizedString(from: userAge as NSNumber, number: NumberFormatter.Style.none)
        
        if var userProfiles = self.userProfiles {
            
            var age: [String] = userProfiles[ProfileKeys.Age] as [String]!
            age[kProfileDetail] = ageValue
            
            userProfiles[ProfileKeys.Age] = age
            self.userProfiles = userProfiles
        }
        
        // Reload table view (only age row)
        
    }
    
    private func updateUsersHeight() -> Void
    {
        let setHeightInformationHandle: ((String) -> Void) = {
            
            [unowned self] (heightValue) -> Void in
            
            // Fetch user's default height unit in inches.
            let lengthFormatter = LengthFormatter()
            lengthFormatter.unitStyle = Formatter.UnitStyle.long
            
            let heightFormatterUnit = LengthFormatter.Unit.inch
            let heightUniString: String = lengthFormatter.unitString(fromValue: 10, unit: heightFormatterUnit)
            let localizedHeightUnitDescriptionFormat: String = NSLocalizedString("Height (%@)", comment: "");
            
            let heightUnitDescription: String = String(format: localizedHeightUnitDescriptionFormat, heightUniString);
            
            if var userProfiles = self.userProfiles {
                
                var height: [String] = userProfiles[ProfileKeys.Height] as [String]!
                height[self.kProfileUnit] = heightUnitDescription
                height[self.kProfileDetail] = heightValue
                
                userProfiles[ProfileKeys.Height] = height
                self.userProfiles = userProfiles
            }
            
            // Reload table view (only height row)
         
        }
        
        let heightType: HKQuantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        
        // Query to get the user's latest height, if it exists.
        let completion: HKCompletionHandle = {
            
            (mostRecentQuantity, error) -> Void in
            
            guard let mostRecentQuantity = mostRecentQuantity else {
                
                print("Either an error occured fetching the user's height information or none has been stored yet. In your app, try to handle this gracefully.")
                
                DispatchQueue.main.async {
                    
                    let heightValue: String = NSLocalizedString("Not available", comment: "")
                    
                    setHeightInformationHandle(heightValue)
                }
                
                return
            }
            
            // Determine the height in the required unit.
            let heightUnit = HKUnit.inch()
            let usersHeight: Double = mostRecentQuantity.doubleValue(for: heightUnit)
            
            // Update the user interface.
            DispatchQueue.main.async {
                
                let heightValue: String = NumberFormatter.localizedString(from: usersHeight as NSNumber, number: NumberFormatter.Style.none)
                
                setHeightInformationHandle(heightValue)
            }
        }
        
        if let healthStore = self.healthStore {
            
            healthStore.mostRecentQuantitySample(ofType: heightType, completion: completion)
        }
    }
    
    private func updateUsersWeight() -> Void
    {
        let setWeightInformationHandle: ((String) -> Void) = {
            
            [unowned self] (weightValue) -> Void in
            
            // Fetch user's default height unit in inches.
            let massFormatter = MassFormatter()
            massFormatter.unitStyle = Formatter.UnitStyle.long
            
            let weightFormatterUnit = MassFormatter.Unit.pound
            let weightUniString: String = massFormatter.unitString(fromValue: 10, unit: weightFormatterUnit)
            let localizedHeightUnitDescriptionFormat: String = NSLocalizedString("Weight (%@)", comment: "");
            
            let weightUnitDescription = String(format: localizedHeightUnitDescriptionFormat, weightUniString);
            
            if var userProfiles = self.userProfiles {
                var weight: [String] = userProfiles[ProfileKeys.Weight] as [String]!
                weight[self.kProfileUnit] = weightUnitDescription
                weight[self.kProfileDetail] = weightValue
                
                userProfiles[ProfileKeys.Weight] = weight
                self.userProfiles = userProfiles
            }
            
            // Reload table view (only height row)
            
        }
        
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        // Query to get the user's latest weight, if it exists.
        let completion: HKCompletionHandle = {
            (mostRecentQuantity, error) -> Void in
            
            guard let mostRecentQuantity = mostRecentQuantity else {
                
                print("Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.")
                
                DispatchQueue.main.async {
                    
                    let weightValue: String = NSLocalizedString("Not available", comment: "")
                    
                    setWeightInformationHandle(weightValue)
                }
                
                return
            }
            
            // Determine the weight in the required unit.
            let weightUnit = HKUnit.pound()
            let usersWeight: Double = mostRecentQuantity.doubleValue(for: weightUnit)
            
            // Update the user interface.
            DispatchQueue.main.async {
                
                let weightValue: String = NumberFormatter.localizedString(from: usersWeight as NSNumber, number: NumberFormatter.Style.none)
                
                setWeightInformationHandle(weightValue)
            }
        }
        
        if let healthStore = self.healthStore {
            
            healthStore.mostRecentQuantitySample(ofType: weightType, completion: completion)
        }
    }
    
    private func saveHeightIntoHealthStore(_ height: Double) -> Void
    {
        // Save the user's height into HealthKit.
        let inchUnit = HKUnit.inch()
        let heightQuantity = HKQuantity(unit: inchUnit, doubleValue: height)
        
        let heightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let nowDate = Date()
        
        let heightSample = HKQuantitySample(type: heightType, quantity: heightQuantity, start: nowDate, end: nowDate)
        
        let completion: ((Bool, Error?) -> Void) = {
            [unowned self] (success, error) -> Void in
            
            if !success {
                print("An error occured saving the height sample \(heightSample). In your app, try to handle this gracefully. The error was: \(error).")
                
                abort()
            }
            
            self.updateUsersHeight()
        }
        
        if let healthStore = self.healthStore {
            
            healthStore.save(heightSample, withCompletion: completion)
        }
    }
    
    private func saveWeightIntoHealthStore(_ weight: Double) -> Void
    {
        // Save the user's weight into HealthKit.
        let poundUnit = HKUnit.pound()
        let weightQuantity = HKQuantity(unit: poundUnit, doubleValue: weight)
        
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let nowDate = Date()
        
        let weightSample: HKQuantitySample = HKQuantitySample(type: weightType, quantity: weightQuantity, start: nowDate, end: nowDate)
        
        let completion: ((Bool, Error?) -> Void) = {
            [unowned self] (success, error) -> Void in
            
            if !success {
                print("An error occured saving the weight sample \(weightSample). In your app, try to handle this gracefully. The error was: \(error).")
                
                abort()
            }
            
            self.updateUsersWeight()
        }
        
        if let healthStore = self.healthStore {
            healthStore.save(weightSample, withCompletion: completion)
        }
    }



}
