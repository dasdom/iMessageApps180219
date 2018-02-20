//  Created by dasdom on 14.02.18.
//  Copyright © 2018 dasdom. All rights reserved.
//

import UIKit

class CompactStyleViewController: UIViewController {
    
    var delegate: CompactStyleViewControllerProtocol?
    var presentationStyleString = ".compact"
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.brown
        
        let label = UILabel()
        label.text = presentationStyleString
        label.textAlignment = .center
        label.textColor = .white

        let button = UIButton()
        button.setTitle("send", for: .normal)
        button.addTarget(self, action: #selector(send), for: .touchUpInside)
        button.setTitleColor(.yellow, for: .normal)
        button.layer.borderColor = UIColor.yellow.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        let sinceStartLabel = UILabel()
        sinceStartLabel.textAlignment = .center
        sinceStartLabel.textColor = .white
        sinceStartLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        let stackView = UIStackView(arrangedSubviews: [label, button, sinceStartLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        let startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            sinceStartLabel.text = "\(-Int(startDate.timeIntervalSinceNow))"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func send() {
        UIGraphicsBeginImageContext(view.bounds.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let theSnapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        delegate?.controllerDidTapSend(self, withImage: theSnapshotImage!)
    }
}

protocol CompactStyleViewControllerProtocol {
    func controllerDidTapSend(_ controller: UIViewController, withImage: UIImage)
}
