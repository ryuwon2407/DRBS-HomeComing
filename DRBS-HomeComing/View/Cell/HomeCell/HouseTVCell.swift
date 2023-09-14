import UIKit

final class HouseTVCell: UITableViewCell {
    
    //MARK: - Properties
    
    var indexPath: Int?
    weak var cellselectedDelegate: CellSelectedDelegate?
    
//    var apartCellCount: Int?
//    var oneRoomCellCount: Int?
//    var villaCellCount: Int?
//    var bookmarkCellCount: Int?
    
    lazy var apartCell: [House] = []
    lazy var oneRoomCell: [House] = []
    lazy var villaCell: [House] = []
    lazy var bookmarkCell: [House] = []
    
    
    private let noDataView = NoDataView(message: "+ 버튼으로 체크리스트를 추가해보세요!")
    
    var houses: [House] = [] {
        didSet {
//            self.oneRoomCellCount = houses.filter{$0.livingType! == "원룸/투룸+"}.count
//            self.villaCellCount = houses.filter{$0.livingType! == "빌라/주택"}.count
//            self.apartCellCount = houses.filter{$0.livingType! == "아파트/오피스텔"}.count
//            self.bookmarkCellCount = houses.filter{$0.isBookMarked! == true}.count
            
            self.oneRoomCell = houses.filter{$0.livingType! == "원룸/투룸+"}
            self.villaCell = houses.filter{$0.livingType! == "빌라/주택"}
            self.apartCell = houses.filter{$0.livingType! == "아파트/오피스텔"}
            self.bookmarkCell = houses.filter{$0.isBookMarked! == true}
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.updatePlaceholderView()
            }
        }
    }
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = .init(width: 160, height: 170)
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(ApartCell.self, forCellWithReuseIdentifier: Constant.Identifier.apartCell.rawValue)
        view.register(OneroomCell.self, forCellWithReuseIdentifier: Constant.Identifier.oneroomCell.rawValue)
        view.register(VillaCell.self, forCellWithReuseIdentifier: Constant.Identifier.villaCell.rawValue)
        view.register(BookMarkCell.self, forCellWithReuseIdentifier: Constant.Identifier.bookmarkCell.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.contentView.addSubviews(self.collectionView, self.noDataView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleHouseDeleted), name: Notification.Name("houseDeleted"), object: nil)
        
        NSLayoutConstraint.activate([
            self.collectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.noDataView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -10),
            self.noDataView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    deinit {
        // NotificationCenter에서 관찰자 제거
        NotificationCenter.default.removeObserver(self, name: Notification.Name("houseDeleted"), object: nil)
    }
    
    //MARK: - Helpers
    
    private func updatePlaceholderView() {
        switch self.indexPath {
            case 0:
            self.noDataView.isHidden = (self.apartCell.count) > 0
            case 1:
            self.noDataView.isHidden = (self.villaCell.count) > 0
            case 2:
            self.noDataView.isHidden = (self.oneRoomCell.count) > 0
            case 3:
            self.noDataView.isHidden = (self.bookmarkCell.count) > 0
            default:
                self.noDataView.isHidden = true
        }
    }
}


//MARK: - UICollectionViewDataSource

extension HouseTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.indexPath {
            case 0:
//                guard let count = apartCellCount else { return 0 }
//                return count
            return self.apartCell.count
            case 1:
//                guard let count = villaCellCount else { return 0 }
//                return count
            return self.villaCell.count

            case 2:
//                guard let count = oneRoomCellCount else { return 0 }
//                return count
            return self.oneRoomCell.count
            case 3:
//                guard let count = bookmarkCellCount else { return 0 }
//                return count
            return self.bookmarkCell.count
            default:
                return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.indexPath {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.apartCell.rawValue, for: indexPath) as! ApartCell
//            cell.apartHouse = self.houses.filter{ $0.livingType! == "아파트/오피스텔" }[indexPath.row]
            cell.apartHouse = self.apartCell[indexPath.row]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.villaCell.rawValue, for: indexPath) as! VillaCell
//            cell.villaHouse = self.houses.filter{ $0.livingType! == "빌라/주택" }[indexPath.row]
            cell.villaHouse = self.villaCell[indexPath.row]
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.oneroomCell.rawValue, for: indexPath) as! OneroomCell
//            cell.oneRoomHouse = self.houses.filter { $0.livingType! == "원룸/투룸+" }[indexPath.row]
            cell.oneRoomHouse = self.oneRoomCell[indexPath.row]
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.bookmarkCell.rawValue, for: indexPath) as! BookMarkCell
//            cell.bookmarkHouse = self.houses.filter{ $0.isBookMarked! == true }[indexPath.row]
            cell.bookmarkHouse = self.bookmarkCell[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    @objc func handleHouseDeleted(notification: Notification) {
        if let userInfo = notification.userInfo, let deletedHouseId = userInfo["deletedHouseId"] as? String {
            if let index = self.houses.firstIndex(where: { $0.houseId == deletedHouseId }) {
                self.houses.remove(at: index)
            }
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HouseTVCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.indexPath {
            case 0:
                self.cellselectedDelegate?.cellselected(houseTVCell: self, house: self.houses.filter{ $0.livingType! == "아파트/오피스텔" }[indexPath.row])
            case 1:
                self.cellselectedDelegate?.cellselected(houseTVCell: self, house: self.houses.filter{ $0.livingType! == "빌라/주택" }[indexPath.row])
            case 2:
                self.cellselectedDelegate?.cellselected(houseTVCell: self, house: self.houses.filter{ $0.livingType! == "원룸/투룸+" }[indexPath.row])
            case 3:
                self.cellselectedDelegate?.cellselected(houseTVCell: self, house: self.houses.filter{ $0.isBookMarked! == true }[indexPath.row])
            default:
                break
        }
    }
}
