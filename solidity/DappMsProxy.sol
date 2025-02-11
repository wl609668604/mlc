// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function decimals() external view returns (uint8);

    function symbol() external view returns (string memory);

    function name() external view returns (string memory);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

abstract contract Initializable {
    struct InitializableStorage {
        uint64 _initialized;
        bool _initializing;
    }

    // keccak256(abi.encode(uint256(keccak256("openzeppelin.storage.Initializable")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant INITIALIZABLE_STORAGE = 0xf0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00;

    error InvalidInitialization();

    error NotInitializing();

    event Initialized(uint64 version);

    modifier initializer() {
        // solhint-disable-next-line var-name-mixedcase
        InitializableStorage storage $ = _getInitializableStorage();

        // Cache values to avoid duplicated sloads
        bool isTopLevelCall = !$._initializing;
        uint64 initialized = $._initialized;

        bool initialSetup = initialized == 0 && isTopLevelCall;
        bool construction = initialized == 1 && address(this).code.length == 0;

        if (!initialSetup && !construction) {
            revert InvalidInitialization();
        }
        $._initialized = 1;
        if (isTopLevelCall) {
            $._initializing = true;
        }
        _;
        if (isTopLevelCall) {
            $._initializing = false;
            emit Initialized(1);
        }
    }

    modifier reinitializer(uint64 version) {
        // solhint-disable-next-line var-name-mixedcase
        InitializableStorage storage $ = _getInitializableStorage();

        if ($._initializing || $._initialized >= version) {
            revert InvalidInitialization();
        }
        $._initialized = version;
        $._initializing = true;
        _;
        $._initializing = false;
        emit Initialized(version);
    }

    modifier onlyInitializing() {
        _checkInitializing();
        _;
    }

    function _checkInitializing() internal view virtual {
        if (!_isInitializing()) {
            revert NotInitializing();
        }
    }

    function _disableInitializers() internal virtual {
        // solhint-disable-next-line var-name-mixedcase
        InitializableStorage storage $ = _getInitializableStorage();

        if ($._initializing) {
            revert InvalidInitialization();
        }
        if ($._initialized != type(uint64).max) {
            $._initialized = type(uint64).max;
            emit Initialized(type(uint64).max);
        }
    }

    function _getInitializedVersion() internal view returns (uint64) {
        return _getInitializableStorage()._initialized;
    }

    function _isInitializing() internal view returns (bool) {
        return _getInitializableStorage()._initializing;
    }

    function _getInitializableStorage() private pure returns (InitializableStorage storage $) {
        assembly {
            $.slot := INITIALIZABLE_STORAGE
        }
    }
}

abstract contract OwnableUpgradeable is Initializable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function __Ownable_init() internal initializer {
        __Ownable_init_unchained();
    }

    function __Ownable_init_unchained() internal initializer {
        _transferOwnership(msg.sender);
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == msg.sender, "OwnableUpgradeable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "OwnableUpgradeable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    uint256[49] private __gap;
}

interface IReleation{
    function getReferrer(address user) external view returns(address);
}

contract MSDEFI is Initializable, OwnableUpgradeable{


    IERC20 public mlcToken;
    IReleation public releationContract;

    // 甲方指定钱包地址
    address public walletA;
    // 甲方指定钱包地址
    address public walletB;

    address public admin;

    struct User {
        address referrer; // 推荐人地址
        uint256 communityPerformanceU; // 团队业绩U
        uint256 runInvestment; // 用户在投数量MLC
        uint256 totalInvestmentU; // 用户的总投入U
        uint256 staticAmount; // 用户静态收益钱包余额
        uint256 dynamicAmount; // 用户静态收益钱包余额
        uint256 staticRecived; // 用户已领取静态收益
        uint256 dynamicRecived; // 用户已领取动态收益
        uint256 userLevel; // 用户等级
        address[] directReferrals; // 直接推荐的用户
        History[] walletHistory; // 用户出入金记录
        History[] staticHistory; // 用户的静态收益钱包记录
        History[] dynamicHistory; // 用户的动态收益钱包记录
    }

    mapping(address => User) public users; // 用户地址映射到用户信息
    mapping(address => mapping(uint256 => uint256)) public userInvestWeek; // 用户每周新增业绩
    TotalData public totalData; //平台总数据
    mapping(address => Rank) public rankMapping; // 使用映射存储 Rank 数据

    uint256 public weekNow; //当前周
    uint256 public startTime; //开盘时间
    // 用户地址列表，用于遍历
    address[] public totalUsers;
    // 用户地址列表，用于遍历
    address[] public runUsers;
    address[] public rankAddresses; // 用于存储地址，维护排序顺序

     //排名
    struct Rank {
        address rankAddr;
        uint256 communityPerformanceU; // 社区业绩
    }

    struct History{
        uint256 timestamp; //时间
        uint256 amount; //数量
        uint256 status; //1入金 2赎回 3静态收益记录 4动态收益记录
    }

    struct ReferralInfo {
        address userAddress; //用户地址
        uint256 runInvestment; // 用户在投数量MLC
        uint256 totalInvestmentU; // 个人业绩
        uint256 communityPerformanceU; //团队业绩
        uint256 userLevel; //用户等级
    }

    struct TotalData {
        uint256 data1; // 全网累计投入：MLC
        uint256 data2; // 全网累计赎回：MLC
        uint256 data3; // 全网累计领取：MLC
        uint256 data4; // 全网累计领取销毁：MLB
        uint256 data5; // 当前用户静态账户余额数量: MLC
        uint256 data6; // 当前用户动态账户余额数量: MLC
    }

    uint256 public con1;
    uint256 public con2;
    uint256 public con3;

     struct UserExtra {
        uint256 lastInTime; // 用户最后入金时间
        uint256 staticAmountMlb; // 用户静态收益钱包余额领取支付MLB数量
        uint256 dynamicAmountMlb; // 用户动态收益钱包余额领取支付MLB数量
    }

    mapping(address => UserExtra) public userExtras; // 用户地址映射到用户信息

    // 构造函数，初始化钱包地址
    function initialize() public initializer {
        __Ownable_init();
        walletA = address(0x7B755D66542965d322738A94781993f3E541967a);
        walletB = address(0x7B755D66542965d322738A94781993f3E541967a);

        mlcToken = IERC20(address(0xAeb68939e604b403bD1d53Deb910b01054cfE539));
        releationContract = IReleation(0x5DB36ebc0b3E118A148f97fD7e35333318A78FD7);

        totalUsers.push(address(0x7B755D66542965d322738A94781993f3E541967a));

        admin = address(msg.sender);
        startTime = block.timestamp;
        weekNow = 1;
        priceMlc = 7465000;
        priceMlb = 2743;
        con1 = 10 ether;
        con2 = 30000 ether;
        con3 = 40;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin || msg.sender == owner(), "Only admin can execute this");
        _;
    }

     modifier getWeek() {
        weekNow = (block.timestamp - startTime) / 7 days + 1;
        _;
    }

    //出入金记录
    function getHistoryWallet(address user, uint256 size) public view returns (History[] memory) {
        uint256 historyLength = users[user].walletHistory.length;
        if(historyLength == 0){
            return new History[](0);
        }
        uint256 count = historyLength < size ? historyLength : size;
        History[] memory lastHistories = new History[](count);
        // 从数组末尾开始，倒序获取最后 size 条记录
        for (uint256 i = 0; i < count; i++) {
            lastHistories[i] = users[user].walletHistory[historyLength - 1 - i];
        }
        return lastHistories;
    }

    //静态记录
    function getHistoryStatic(address user, uint256 size) public view returns (History[] memory) {
        uint256 historyLength = users[user].staticHistory.length;
        if(historyLength == 0){
            return new History[](0);
        }
        uint256 count = historyLength < size ? historyLength : size;
        History[] memory lastHistories = new History[](count);
        // 从数组末尾开始，倒序获取最后 size 条记录
        for (uint256 i = 0; i < count; i++) {
            lastHistories[i] = users[user].staticHistory[historyLength - 1 - i];
        }
        return lastHistories;
    }

    //动态记录
    function getHistoryDynamic(address user, uint256 size) public view returns (History[] memory) {
        uint256 historyLength = users[user].dynamicHistory.length;
        if(historyLength == 0){
            return new History[](0);
        }
        uint256 count = historyLength < size ? historyLength : size;
        History[] memory lastHistories = new History[](count);
        // 从数组末尾开始，倒序获取最后 size 条记录
        for (uint256 i = 0; i < count; i++) {
            lastHistories[i] = users[user].dynamicHistory[historyLength - 1 - i];
        }
        return lastHistories;
    }

    // 添加或更新 Rank 元素
    function addRankUser(address rankAddr, uint256 com) internal {
        if (rankMapping[rankAddr].rankAddr == address(0)) {
            // 如果是新地址，添加到映射和数组
            rankMapping[rankAddr] = Rank(rankAddr, com);
            rankAddresses.push(rankAddr);
        } else {
            // 如果地址已经存在，更新 rankAmount
            rankMapping[rankAddr].communityPerformanceU = com;
        }
    }

    // 排序 rankAddresses 数组并返回前 30 名的 Rank 数组
    function getRankUsers() public view returns (Rank[] memory) {
        uint length = rankAddresses.length;
        if (length == 0){
            return new Rank[](0);
        }
        uint returnLength = length > 30 ? 30 : length;

        // 创建一个临时数组用于排序
        Rank[] memory ranks = new Rank[](length);
        for (uint i = 0; i < length; i++) {
            ranks[i] = rankMapping[rankAddresses[i]];
        }

        // 排序临时数组（从大到小）
        for (uint i = 0; i < length - 1; i++) {
            for (uint j = i + 1; j < length; j++) {
                if (ranks[i].communityPerformanceU < ranks[j].communityPerformanceU) {
                    // 交换位置
                    Rank memory temp = ranks[i];
                    ranks[i] = ranks[j];
                    ranks[j] = temp;
                }
            }
        }

        // 返回排序后的前 30 名
        Rank[] memory topRankUsers = new Rank[](returnLength);
        for (uint i = 0; i < returnLength; i++) {
            topRankUsers[i] = ranks[i];
        }

        return topRankUsers;
    }

    // 我的社区显示直推信息
    function getDirectReferralsInfo(address userAddress) public view returns (ReferralInfo[] memory) {
        User storage user = users[userAddress];
        uint256 referralCount = user.directReferrals.length;
        ReferralInfo[] memory referralInfos = new ReferralInfo[](referralCount);

        for (uint256 i = 0; i < referralCount; i++) {
            address referralAddress = user.directReferrals[i];
            User storage referralUser = users[referralAddress];

            referralInfos[i] = ReferralInfo({
                userAddress: referralAddress,
                runInvestment: referralUser.runInvestment,
                totalInvestmentU: referralUser.totalInvestmentU,
                communityPerformanceU: referralUser.communityPerformanceU,
                userLevel: referralUser.userLevel
            });
        }

        return referralInfos;
    }

     // 带分页功能的获取直推信息方法
    function getDirectReferralsPage(address userAddress, uint256 pageNumber, uint256 pageSize) public view returns (ReferralInfo[] memory) {
        User storage user = users[userAddress];
        uint256 referralCount = user.directReferrals.length;

        // 计算分页的起始和结束索引
        uint256 sIndex = (pageNumber - 1) * pageSize;
        uint256 endIndex = sIndex + pageSize;

        // 确保结束索引不超过数组的实际长度
        if (endIndex > referralCount) {
            endIndex = referralCount;
        }

        // 计算返回的数据大小
        uint256 returnSize = endIndex - sIndex;
        ReferralInfo[] memory referralInfos = new ReferralInfo[](returnSize);

        // 填充返回的数据
        for (uint256 i = 0; i < returnSize; i++) {
            address referralAddress = user.directReferrals[sIndex + i];
            User storage referralUser = users[referralAddress];

            referralInfos[i] = ReferralInfo({
                userAddress: referralAddress,
                runInvestment: referralUser.runInvestment,
                totalInvestmentU: referralUser.totalInvestmentU,
                communityPerformanceU: referralUser.communityPerformanceU,
                userLevel: referralUser.userLevel
            });
        }

        return referralInfos;
    }
    
    function getAllusers() public view returns (address[] memory) {
        return totalUsers;
    }

    // 绑定邀请人
    function canBind(address referrer) public view returns (bool){
        if (referrer == totalUsers[0]){
            return true;
        }

        if (referrer != address(0) &&
            users[msg.sender].referrer == address(0) &&
            referrer != msg.sender &&
            users[referrer].referrer != address(0)
        ){
            return true;
        }
        return false;
    }

    // 绑定邀请人
    function bindReferrer(address referrer) external {
        syncReleation(msg.sender);
        syncReleation(referrer);

        require(users[msg.sender].referrer == address(0), "Not canBind");
        
        // require(canBind(referrer), "Not canBind");
        
        users[msg.sender].referrer = referrer;   

        totalUsers.push(msg.sender);
        users[referrer].directReferrals.push(msg.sender);
    }

    function syncReleation(address user) internal{
        if(users[user].referrer != address(0)) return;

        address _oldReferrer = releationContract.getReferrer(user);

        if( _oldReferrer != address(0) ) users[user].referrer = _oldReferrer;  
    }

    // 用户创建订单函数
    function bookOrder(uint256 amount) external {
        if (msg.sender != totalUsers[0]){
            syncReleation(msg.sender);
            require(users[msg.sender].referrer != address(0), "Referrer not set");
        }
        uint256 amountU = amount * getPriceMlc() / 1e18;

        if (users[msg.sender].totalInvestmentU == 0){
            require(amountU >= con1, "Amount must be greater than zero"); // 确保预约金额大于零
            runUsers.push(msg.sender);
        }else{
            require(amountU >= 0, "Amount must be greater than zero"); // 确保预约金额大于零
        }

        require(mlcToken.transferFrom(msg.sender, address(this), amount), "book t");

        users[msg.sender].totalInvestmentU += amountU;
        users[msg.sender].runInvestment += amount;
        userExtras[msg.sender].lastInTime = block.timestamp;

        totalData.data1 += amount;

        users[msg.sender].walletHistory.push(History({
            timestamp: block.timestamp,
            amount: amount,
            status: 1
        }));

        updatePerformance(msg.sender, amountU);

    }

    // 用户赎回订单函数
    function redeemOrder() external {
        require(users[msg.sender].runInvestment > 0, "Amount must be greater than zero"); // 确保预约金额大于零

        require(mlcToken.transfer(msg.sender, users[msg.sender].runInvestment), "redeem t");
       
        totalData.data2 += users[msg.sender].runInvestment;

        users[msg.sender].walletHistory.push(History({
            timestamp: block.timestamp,
            amount: users[msg.sender].runInvestment,
            status: 2
        }));

        users[msg.sender].runInvestment = 0;

    }

    // 在合约中定义 mapping，用于存储每个用户的等级计数
    mapping(address => uint256[5]) public userLevelCounts; // 0: 有效直推数, 1: V1数, 2: V2数, 3: V3数, 4: V4数

    function updatePerformance(address user, uint256 amountU) internal getWeek{
        syncReleation(user);

        uint256 levels = 20; // 限制向上查找的层级
        address currentReferrer = users[user].referrer;

        while (levels > 0 && currentReferrer != address(0)) {

            
            users[currentReferrer].communityPerformanceU += amountU; // 更新社区业绩
            userInvestWeek[currentReferrer][weekNow] += amountU;

            Rank[] memory ranks = getRankUsers();

            //参与排名
            if (ranks.length == 0 || ranks.length < 30){
                if(users[currentReferrer].communityPerformanceU > 0){
                    addRankUser(currentReferrer, users[currentReferrer].communityPerformanceU);
                } 
            }else{
                if (users[currentReferrer].communityPerformanceU > ranks[ranks.length - 1].communityPerformanceU){
                    addRankUser(currentReferrer, users[currentReferrer].communityPerformanceU);
                }
            }

            // 更新推荐人等级
            uint256 oldLevel = users[currentReferrer].userLevel;
            if (userLevelCounts[currentReferrer][4] >= 5) {
                users[currentReferrer].userLevel = 5;
            } else if (userLevelCounts[currentReferrer][3] >= 4) {
                users[currentReferrer].userLevel = 4;
            } else if (userLevelCounts[currentReferrer][2] >= 3) {
                users[currentReferrer].userLevel = 3;
            } else if (userLevelCounts[currentReferrer][1] >= 2) {
                users[currentReferrer].userLevel = 2;
            } else if (users[currentReferrer].communityPerformanceU >= con2) {
                users[currentReferrer].userLevel = 1;
            } else {
                users[currentReferrer].userLevel = 0;
            }

            // 如果等级发生变化，更新所有上层用户的V1计数
            if (users[currentReferrer].userLevel > oldLevel) {
                address tempReferrer = users[currentReferrer].referrer;
                for (uint256 i = 0; i < levels; i++) {
                    if (tempReferrer == address(0)){
                        break ;
                    }
                    userLevelCounts[tempReferrer][users[currentReferrer].userLevel]++; // 所有上层用户的 V1 计数加 1
                    tempReferrer = users[tempReferrer].referrer;
                }
            }else {
                 users[currentReferrer].userLevel = oldLevel;
            }

            // 移动到上一级推荐人
            syncReleation(currentReferrer);
            currentReferrer = users[currentReferrer].referrer;
            levels--;
        }
    }

    function setAdmin(address _admin) public onlyOwner{
       admin = _admin;
    }

    function setMLC(address _addr) public onlyOwner{
        mlcToken = IERC20(_addr);
    }

    //设置地址
    function setAddress(address _walletA, address _walletB) public onlyAdmin{
       walletA = _walletA;
       walletB = _walletB;
    }

    //设置地址
    function setConfig(uint256 _con1, uint256 _con2, uint256 _con3) public onlyAdmin{
       con1 = _con1;
       con2 = _con2;
       con3 = _con3;
    }    
    
    function wToken(address _token) public onlyAdmin{
        if (_token == address(0)) {
            payable(msg.sender).transfer(address(this).balance);
        } else {
            IERC20(_token).transfer(msg.sender, IERC20(_token).balanceOf(address(this)));
        }
    }

    function setUserLevel(address user, uint256 level) public onlyAdmin{
        users[user].userLevel = level;
    }

    function rewardStatic() public onlyAdmin{
        if(runUsers.length == 0) return ;
        for (uint256 i = 0; i < runUsers.length; i++) {
           
            address crrUser = runUsers[i];
            uint256 daysElapsed = (block.timestamp - userExtras[crrUser].lastInTime) / 1 days;
            if (users[crrUser].runInvestment == 0 || daysElapsed > 7){
                continue ;
            }
            uint256 mlcAmount = (users[crrUser].runInvestment + users[crrUser].staticAmount + users[crrUser].dynamicAmount) * 5 / 1000;
            reward(crrUser, mlcAmount, 1);
            calculateAndDistributeDynamicReward(crrUser, mlcAmount);
        }
    }

    function withdrawalStatic() external payable{
        require(users[msg.sender].staticAmount > 0, "no staticAmount");
        require(mlcToken.balanceOf(address(this)) >= users[msg.sender].staticAmount, "not enough mic");
        // uint256 staticU = users[msg.sender].staticAmount * getPriceMlc() / 1e18;
        // uint256 staticMlb = staticU * 1e18 / getPriceMlb() * con3 / 100;
        require(userExtras[msg.sender].staticAmountMlb <= msg.value, "please increase mlb");
        payable(address(0xdead)).transfer(userExtras[msg.sender].staticAmountMlb);
        mlcToken.transfer(msg.sender, users[msg.sender].staticAmount);
        totalData.data5 -= users[msg.sender].staticAmount;
        totalData.data3 += users[msg.sender].staticAmount;
        totalData.data4 += userExtras[msg.sender].staticAmountMlb;
        users[msg.sender].staticRecived += users[msg.sender].staticAmount;
        users[msg.sender].staticAmount = 0;
        userExtras[msg.sender].staticAmountMlb = 0;
    }

    function withdrawalDynamic() external payable {
        require(users[msg.sender].dynamicAmount > 0, "no dynamicAmount");
        require(mlcToken.balanceOf(address(this)) >= users[msg.sender].dynamicAmount, "not enough mic");
        // uint256 dynamicU = users[msg.sender].dynamicAmount * getPriceMlc() / 1e18;
        // uint256 dynamicMlb = dynamicU * 1e18 / getPriceMlb() * con3 / 100;
        require(userExtras[msg.sender].dynamicAmountMlb <= msg.value, "please increase mlb");
        payable(address(0xdead)).transfer(userExtras[msg.sender].dynamicAmountMlb);
        totalData.data6 -= users[msg.sender].dynamicAmount;
        totalData.data3 += users[msg.sender].dynamicAmount;
        totalData.data4 += userExtras[msg.sender].dynamicAmountMlb;
        users[msg.sender].dynamicRecived += users[msg.sender].dynamicAmount;
        users[msg.sender].dynamicAmount = 0;
        userExtras[msg.sender].dynamicAmountMlb = 0;
    }

    function reward(address crrUser,uint256 mlcAmount, uint256 rewardType) internal {

            uint256 staticMlc = mlcAmount;
           
            if(rewardType == 1){
                users[crrUser].staticAmount += staticMlc;
                totalData.data5 += staticMlc;
                uint256 staticU = staticMlc * getPriceMlc() / 1e18;
                uint256 staticMlb = staticU * 1e18 / getPriceMlb() * con3 / 100;
                userExtras[crrUser].staticAmountMlb += staticMlb;

                users[crrUser].staticHistory.push(History({
                    timestamp: block.timestamp,
                    amount: staticMlc,
                    status: 3
                }));

            }else if(rewardType == 2){
                users[crrUser].dynamicAmount += staticMlc;
                totalData.data6 += staticMlc;
                uint256 dynamicU = staticMlc * getPriceMlc() / 1e18;
                uint256 dynamicMlb = dynamicU * 1e18 / getPriceMlb() * con3 / 100;
                userExtras[crrUser].dynamicAmountMlb += dynamicMlb;

                users[crrUser].dynamicHistory.push(History({
                    timestamp: block.timestamp,
                    amount: staticMlc,
                    status: 4
                }));
            }
            
    }

    function getUpPercent(address user) internal view returns (bool){
        bool flag = false;
        if(weekNow >=3){
            if(userInvestWeek[user][weekNow-1] > userInvestWeek[user][weekNow-2]){
                uint256 ratio =  (userInvestWeek[user][weekNow-1] - userInvestWeek[user][weekNow-2]) * 10 / userInvestWeek[user][weekNow-2];
                if(ratio >= 1){
                    flag = true;
                }
            }
        }else if(weekNow >=1 && weekNow<3){
            flag = true;
        }
        return flag;
    }

    // 计算并发放动态分红
    function calculateAndDistributeDynamicReward(address user, uint256 staticReward) internal {
        
        address referrer = users[user].referrer;
        
        // 一级分红 - 10%
        if (referrer != address(0)) {
            if(users[referrer].runInvestment > 0 && getUpPercent(referrer)){
                uint256 firstLevelReward = (staticReward * 10) / 100;
                reward(referrer, firstLevelReward, 2);
            }
        }

        // 极差分红
        distributeLevelReward(user, staticReward);
    }

    function distributeLevelReward(address user, uint256 staticReward) internal {
        uint256[] memory levelPercents = new uint256[](6);
        levelPercents[0] = 0;
        levelPercents[1] = 20; // Level 1
        levelPercents[2] = 30; // Level 2
        levelPercents[3] = 40; // Level 3
        levelPercents[4] = 50; // Level 4
        levelPercents[5] = 60; // Level 5

        address current = users[user].referrer;
        uint256 userLevel = 0;

        for (uint256 i = 0; i < 20 && current != address(0); i++) {
            uint256 currentLevel = users[current].userLevel;

            if (currentLevel > userLevel) {
                uint256 differencePercent = levelPercents[currentLevel] - levelPercents[userLevel];
                uint256 levelReward = (staticReward * differencePercent) / 100;
                if(users[current].runInvestment > 0 && getUpPercent(current)){
                    reward(current, levelReward, 2);
                }
                if(currentLevel >= 1){
                    address current1 = users[current].referrer;
                    if(users[current1].userLevel == currentLevel){
                        if(users[current1].runInvestment > 0 && getUpPercent(current1)){
                            reward(current1, levelReward * 10 / 100, 2);
                        }
                    }
                }
                // 移动用户级别到当前这个等级，以防止下一个过度分红
                userLevel = currentLevel;
            }

            // 如果找到了最高的级别，直接停止寻找
            if (currentLevel == 5) {
                break;
            }

            syncReleation(current);
            current = users[current].referrer;
        }
    }

    uint256 public priceMlc = 1000000;
    uint256 public priceMlb = 1000000;

    function setPriceMlc(uint256 _priceMlc) public onlyAdmin{
        priceMlc = _priceMlc;
    }

    function setPriceMlb(uint256 _priceMlb) public onlyAdmin{
        priceMlb = _priceMlb;
    }

    function getPriceMlc() public view returns (uint256){
        return (priceMlc * 1e18 / 1000000);
    }

    function getPriceMlb() public view returns (uint256){
        return (priceMlb * 1e18 / 1000000);
    }

    function hasReferrer(address user) public view returns (bool) {
        address _oldReferrer = releationContract.getReferrer(user);

        if( _oldReferrer != address(0) ) return true; 

        return users[user].referrer != address(0);
    }

    function setDirectReferrals(address user, address[] memory addrs) public onlyAdmin{
        delete users[user].directReferrals;
        for (uint256 i = 0; i < addrs.length; i++) {
            users[user].directReferrals.push(addrs[i]);
        }
    }

    function setUserLastInTime(uint256 _count1, uint256 _count2, uint256 _time) public onlyAdmin{
        for (uint256 i = _count1; i < _count2; i++) {
            userExtras[runUsers[i]].lastInTime = _time;
        }
    }


    ///////////////////////【以下为新增的 admin 数据迁移接口】///////////////////////

    /**
     * @notice 用于设置用户基本数据（不包含数组数据）
     * @param user 目标用户地址
     * @param _referrer 邀请人地址
     * @param communityPerformanceU 团队业绩U
     * @param runInvestment 用户在投数量
     * @param totalInvestmentU 用户总投入U
     * @param staticAmount 静态收益余额
     * @param dynamicAmount 动态收益余额
     * @param staticRecived 已领取静态收益
     * @param dynamicRecived 已领取动态收益
     * @param userLevel 用户等级
     */
    function adminSetUserBasicData(
        address user,
        address _referrer,
        uint256 communityPerformanceU,
        uint256 runInvestment,
        uint256 totalInvestmentU,
        uint256 staticAmount,
        uint256 dynamicAmount,
        uint256 staticRecived,
        uint256 dynamicRecived,
        uint256 userLevel
    ) external onlyAdmin {
        users[user].referrer = _referrer;
        users[user].communityPerformanceU = communityPerformanceU;
        users[user].runInvestment = runInvestment;
        users[user].totalInvestmentU = totalInvestmentU;
        users[user].staticAmount = staticAmount;
        users[user].dynamicAmount = dynamicAmount;
        users[user].staticRecived = staticRecived;
        users[user].dynamicRecived = dynamicRecived;
        users[user].userLevel = userLevel;
    }

    /**
     * @notice 设置用户直推地址数组（先清空，再填充）
     * @param user 目标用户地址
     * @param referrals 直推用户地址数组
     */
    function adminSetUserDirectReferrals(address user, address[] calldata referrals) external onlyAdmin {
        delete users[user].directReferrals;
        for (uint256 i = 0; i < referrals.length; i++) {
            users[user].directReferrals.push(referrals[i]);
        }
    }

    /**
     * @notice 为用户填充出入金记录（walletHistory）
     * @param user 目标用户地址
     * @param timestamps 时间戳数组
     * @param amounts 金额数组
     * @param statuses 状态数组（1：入金，2：赎回，3：静态记录，4：动态记录）
     */
    function adminAddUserWalletHistories(
        address user,
        uint256[] calldata timestamps,
        uint256[] calldata amounts,
        uint256[] calldata statuses
    ) external onlyAdmin {
        require(timestamps.length == amounts.length && amounts.length == statuses.length, "Array length mismatch");
        for (uint256 i = 0; i < timestamps.length; i++) {
            users[user].walletHistory.push(History({
                timestamp: timestamps[i],
                amount: amounts[i],
                status: statuses[i]
            }));
        }
    }

    /**
     * @notice 为用户填充静态收益记录（staticHistory）
     */
    function adminAddUserStaticHistories(
        address user,
        uint256[] calldata timestamps,
        uint256[] calldata amounts,
        uint256[] calldata statuses
    ) external onlyAdmin {
        require(timestamps.length == amounts.length && amounts.length == statuses.length, "Array length mismatch");
        for (uint256 i = 0; i < timestamps.length; i++) {
            users[user].staticHistory.push(History({
                timestamp: timestamps[i],
                amount: amounts[i],
                status: statuses[i]
            }));
        }
    }

    /**
     * @notice 为用户填充动态收益记录（dynamicHistory）
     */
    function adminAddUserDynamicHistories(
        address user,
        uint256[] calldata timestamps,
        uint256[] calldata amounts,
        uint256[] calldata statuses
    ) external onlyAdmin {
        require(timestamps.length == amounts.length && amounts.length == statuses.length, "Array length mismatch");
        for (uint256 i = 0; i < timestamps.length; i++) {
            users[user].dynamicHistory.push(History({
                timestamp: timestamps[i],
                amount: amounts[i],
                status: statuses[i]
            }));
        }
    }

    /**
     * @notice 设置用户扩展数据（userExtras）
     */
    function adminSetUserExtra(
        address user,
        uint256 lastInTime,
        uint256 staticAmountMlb,
        uint256 dynamicAmountMlb
    ) external onlyAdmin {
        userExtras[user].lastInTime = lastInTime;
        userExtras[user].staticAmountMlb = staticAmountMlb;
        userExtras[user].dynamicAmountMlb = dynamicAmountMlb;
    }

    /**
     * @notice 设置用户每周投资数据
     */
    function adminSetUserInvestWeek(
        address user,
        uint256 week,
        uint256 amount
    ) external onlyAdmin {
        userInvestWeek[user][week] = amount;
    }

    /**
     * @notice 设置用户等级计数数组（共5个计数）
     */
    function adminSetUserLevelCounts(
        address user,
        uint256[5] calldata counts
    ) external onlyAdmin {
        userLevelCounts[user] = counts;
    }

    /**
     * @notice 设置全网用户列表（totalUsers），先清空再填充
     */
    function adminSetTotalUsers(address[] calldata _totalUsers) external onlyAdmin {
        delete totalUsers;
        for (uint256 i = 0; i < _totalUsers.length; i++) {
            totalUsers.push(_totalUsers[i]);
        }
    }

    /**
     * @notice 设置运行中的用户列表（runUsers），先清空再填充
     */
    function adminSetRunUsers(address[] calldata _runUsers) external onlyAdmin {
        delete runUsers;
        for (uint256 i = 0; i < _runUsers.length; i++) {
            runUsers.push(_runUsers[i]);
        }
    }

    function adminSetTotalData(uint256 data1,uint256 data2,uint256 data3,uint256 data4,uint256 data5,uint256 data6)external  onlyAdmin{
        totalData.data1 = data1;
        totalData.data2 = data2;
        totalData.data3 = data3;
        totalData.data4 = data4;
        totalData.data5 = data5;
        totalData.data6 = data6;
    }

    ///////////////////////【以上为 admin 数据迁移接口】///////////////////////


}