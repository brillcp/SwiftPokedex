import UIKit

final class DetailHeaderView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var cornerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrey
        return view
    }()
    
    init(frame: CGRect, urlString: String, color: UIColor) {
        super.init(frame: frame)
        
        backgroundColor = color
        
        let fillerView = UIView(frame: UIScreen.main.bounds)
        fillerView.backgroundColor = backgroundColor
        fillerView.frame.origin.y -= fillerView.frame.height - frame.height
        addSubview(fillerView)

        addSubview(imageView)
        addSubview(cornerView)

        UIImage.load(from: urlString) { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = frame
        
        let cornerHeight: CGFloat = 30.0
        cornerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: cornerHeight)
        cornerView.frame.origin.y = frame.height - (cornerHeight / 2)
        cornerView.roundedView(corners: [.topLeft, .topRight])
    }
}
