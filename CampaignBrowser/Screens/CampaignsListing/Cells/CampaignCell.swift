import UIKit
import RxSwift
import SnapKit

/**
 Style structure that may be used throughout the project to share styling variables.
 */
struct Style {
    struct Font {
        let title = UIFont(name: "Helvetica Neue Bold", size: 18)!
        let subtitle = UIFont(name: "Hoefler Text", size: 12)!
    }
    let font = Font()
    let campaignCell = CampaignCellStyle()
}

var style = Style()

struct CampaignCellStyle {
    let imageViewAspectRatio: CGFloat = 4.0 / 3
    let labelInterlinePadding: CGFloat = 8
    let labelHorizontalPadding: CGFloat = 8
}

/**
 The cell which displays a campaign.
 */
class CampaignCell: UICollectionViewCell {

    private let disposeBag = DisposeBag()

    /** Used to display the campaign's title. */
    private(set) weak var nameLabel: UILabel!

    /** Used to display the campaign's description. */
    private(set) weak var descriptionLabel: UILabel!

    /** The image view which is used to display the campaign's mood image. */
    private(set) weak var imageView: UIImageView!

    /** The mood image which is displayed as the background. */
    var moodImage: Observable<UIImage>? {
        didSet {
            moodImage?
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] image in
                    self?.imageView.image = image
                    })
                .disposed(by: disposeBag)
        }
    }

    /** The campaign's name. */
    var name: String? {
        didSet {
            nameLabel?.text = name
        }
    }

    var descriptionText: String? {
        didSet {
            descriptionLabel?.text = descriptionText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()

        assert(nameLabel != nil)
        assert(descriptionLabel != nil)
        assert(imageView != nil)
    }
}

private extension CampaignCell {
    
    var cellStyle: CampaignCellStyle {
        CampaignBrowser.style.campaignCell
    }
    
    func setupView() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    func setupImageView() {
        let v = UIImageView()
        contentView.addSubview(v)
        
        let aspectRatio: CGFloat = cellStyle.imageViewAspectRatio
        
        v.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(contentView.snp.width).dividedBy(aspectRatio)
        }
        
        v.contentMode = .scaleAspectFill
        
        imageView = v
    }
    
    func setupTitleLabel() {
        let l = UILabel()
        contentView.addSubview(l)
        
        l.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.equalToSuperview().offset(cellStyle.labelHorizontalPadding)
            make.right.equalToSuperview().offset(-cellStyle.labelHorizontalPadding)
        }
        
        l.font = style.font.title
        l.numberOfLines = 2
        l.textAlignment = .natural
        
        nameLabel = l
    }
    
    func setupDescriptionLabel() {
        let l = UILabel()
        contentView.addSubview(l)
        
        l.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(cellStyle.labelInterlinePadding)
            make.left.equalToSuperview().offset(cellStyle.labelHorizontalPadding)
            make.right.equalToSuperview().offset(-cellStyle.labelHorizontalPadding)
        }
        
        l.font = style.font.subtitle
        l.numberOfLines = 0
        l.textAlignment = .justified
        
        descriptionLabel = l
    }
}
