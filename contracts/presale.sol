/**
 *Submitted for verification at BscScan.com on 2022-03-19
*/

// SPDX-License-Identifier: MIP

/**
 *                                                                                @
 *                                                                               @@@
 *                          @@@@@@@                     @@@@@@@@                @ @ @
 *                   @@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@           @@@
 *                @@@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@         @
 *
 *    @@@@@@@@     @@@@@@@@@    @@@@@@@@@@    @@@@@@@       @@@      @@@@@  @@     @@@@@@@@@@
 *    @@@@@@@@@@   @@@@@@@@@@   @@@@@@@@@@   @@@@@@@@@      @@@       @@@   @@@    @@@@@@@@@@
 *    @@@     @@@  @@@     @@@  @@@     @@  @@@     @@@    @@@@@      @@@   @@@@   @@@     @@
 *    @@@     @@@  @@@     @@@  @@@         @@@            @@@@@      @@@   @@@@   @@@
 *    @@@@@@@@@@   @@@@@@@@@@   @@@    @@    @@@@@@@      @@@ @@@     @@@   @@@@   @@@    @@
 *    @@@@@@@@     @@@@@@@@     @@@@@@@@@     @@@@@@@     @@@ @@@     @@@   @@@@   @@@@@@@@@
 *    @@@          @@@   @@@    @@@    @@          @@@   @@@   @@@    @@@   @@@@   @@@    @@
 *    @@@  @@@@    @@@   @@@    @@@                 @@@  @@@   @@@    @@@   @@@@   @@@
 *    @@@   @@@    @@@    @@@   @@@     @@  @@@     @@@  @@@@@@@@@    @@@   @@     @@@     @@
 *    @@@    @@    @@@    @@@   @@@@@@@@@@   @@@@@@@@    @@@   @@@    @@@      @@  @@@@@@@@@@
 *   @@@@@     @  @@@@@   @@@@  @@@@@@@@@@    @@@@@@    @@@@@ @@@@@  @@@@@@@@@@@@  @@@@@@@@@@
 *
 *                @@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@@@
 *                   @@@@@@@@@@@@@@@@@@@@        @@@@@@@@@@@@@@@@@@@@@
 *                        @@@@@@@@@@                 @@@@@@@@@@@@
 *
 */

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/access/Ownable.sol";

/*===================================================
    OpenZeppelin Contracts (last updated v4.5.0)
=====================================================*/

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function decimals() external view returns (uint8);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

library Address {    
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success,) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }

    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

library SafeERC20 {
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
       );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    function _callOptionalReturn(IERC20 token, bytes memory data) private {

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

abstract contract ReentrancyGuard {

    bool private _notEntered;

    constructor () {

        _notEntered = true;
    }

    modifier nonReentrant() {

        require(_notEntered, "ReentrancyGuard: reentrant call");

        _notEntered = false;
        _;
        _notEntered = true;
    }
}



/*===================================================
    Crinet Presale Contract - Round 1_3
=====================================================*/

contract CNTPresale is ReentrancyGuard, Ownable {

    using SafeERC20 for IERC20;

    event TokenPurchase(address indexed beneficiary, uint256 amount);

    // CNT and BUSD token
    IERC20 private cnt;
    IERC20 private busd;

    // Round Information
    struct RoundInfo {
        uint256 cntPrice;
        uint256 hardCap;
        uint256 startTime;
        uint256 endTime;
        uint256 busdAmount;
        uint256 investors;
        bool    active;
    }
    
    mapping(uint8 => RoundInfo) public roundInfos;

    uint8 public constant maxRoundLV = 3;
    uint8 public currentRound;

    // time to start claim.
    uint256 public claimStartTime = 1649894400; // Thu Apr 14 2022 00:00:00 UTC

    // user information
    mapping (address => uint256) public claimableAmounts;

    // Referral Information
    mapping(address => uint16) public referralCount;

    uint256[] public REFERRAL_PERCENTS = [200, 250, 300, 400];

    // price and percent divisor
    uint256 constant public divisor = 10000;

    // wallet to withdraw
    address public wallet;

    /**
     * @dev Initialize with token address and round information.
     */
    constructor (address _cnt, address _busd, address _wallet) Ownable() {
        require(_cnt != address(0), "presale-err: invalid address");
        require(_busd != address(0), "presale-err: invalid address");
        require(_wallet != address(0), "presale-err: invalid address");

        cnt = IERC20(_cnt);
        busd = IERC20(_busd);
        wallet = _wallet;
  
        roundInfos[1].cntPrice = 75;

        roundInfos[1].hardCap = 500_000 * 10**18;
    }

    /**
     * @dev Initialize ICO data. Only for test
     */
    function Initialize() external onlyOwner {
        roundInfos[1].startTime = 0;
        roundInfos[1].endTime = 0;
        roundInfos[1].busdAmount = 0;
        roundInfos[1].investors = 0;
        roundInfos[1].active = false;

        currentRound = 0;
    }

    /**
     * @dev Set token price for a round.
     */
    function setPrice(uint256 _price) external onlyOwner {
        roundInfos[1].cntPrice = _price;
    }

    /**
     * @dev Set hardcap for a round.
     */
    function setHardCap(uint256 _hardCap) external onlyOwner {
        require(_hardCap >= roundInfos[1].busdAmount , "presale-err: _hardCap should be greater than deposit amount");

        roundInfos[1].hardCap = _hardCap;
        roundInfos[1].active = true;
    }

    /**
     * @dev Start ICO with end time and hard cap.
     */
    function startICO() external onlyOwner {
        require(roundInfos[1].active == false, "presale-err: Round is already running");

        currentRound = 1;
        roundInfos[1].active = true;
        roundInfos[1].startTime = block.timestamp;
    }

    /**
     * @dev Stop current round.
     */
    function stopICO() external onlyOwner {
        require(roundInfos[1].active == true, "presale-err: no active ico-round");

        roundInfos[currentRound].active = false;
        roundInfos[currentRound].endTime = block.timestamp;
        roundInfos[currentRound].hardCap = roundInfos[currentRound].busdAmount;
    }

    /**
     * @dev Calculate token amount for busd amount.
     */
    function _getTokenAmount(uint256 _busdAmount) internal view returns (uint256) {
        return _busdAmount / roundInfos[1].cntPrice * divisor / (10**9);
    }

    /**
     * @dev Calculate referral bonus amount with refCount.
     */
    function _getReferralAmount(uint16 _refCount, uint256 _busdAmount) internal view returns (uint256) {
        uint256 referralAmount = 0;
        if (_refCount < 4) {
            referralAmount = _busdAmount * REFERRAL_PERCENTS[0] / divisor;
        } else if (_refCount < 10) {
            referralAmount = _busdAmount * REFERRAL_PERCENTS[1] / divisor;
        } else if (_refCount < 26) {
            referralAmount = _busdAmount * REFERRAL_PERCENTS[2] / divisor;
        } else {
            referralAmount = _busdAmount * REFERRAL_PERCENTS[3] / divisor;
        }

        return referralAmount;
    }

    /**
     * @dev Buy tokens with busd and referral address.
     */
    function buyTokens(uint256 _amount, address _referrer) external nonReentrant {
        _preValidatePurchase(msg.sender, _amount);

        uint256 referralAmount;
        if (_referrer != address(0)) {
            referralCount[_referrer] += 1;
            uint16 refCount = referralCount[_referrer];
            
            referralAmount = _getReferralAmount(refCount, _amount);

            _amount -= referralAmount;
        }

        if (roundInfos[1].busdAmount + _amount > roundInfos[1].hardCap) {
            _amount = roundInfos[1].hardCap - roundInfos[1].busdAmount;
            roundInfos[1].endTime = block.timestamp;
            roundInfos[1].active = false;

            if (referralAmount > 0) {
                uint16 refCount = referralCount[_referrer];
                referralAmount = _getReferralAmount(refCount, _amount);
                _amount -= referralAmount;
            }
        }

        busd.safeTransferFrom(msg.sender, address(this), _amount + referralAmount);
        
        if (referralAmount > 0) {
            busd.safeTransfer(_referrer, referralAmount);
        }

        roundInfos[1].busdAmount += _amount;
        roundInfos[1].investors += 1;

        uint256 purchaseAmount = _getTokenAmount(_amount);
        claimableAmounts[msg.sender] += purchaseAmount;

        emit TokenPurchase(msg.sender, purchaseAmount);
    }

    /**
     * @dev Check the possibility to buy token.
     */
    function _preValidatePurchase(address _beneficiary, uint256 _amount) internal view {
        require(_beneficiary != address(0), "presale-err: beneficiary is the zero address");
        require(_amount != 0, "presale-err: _amount is 0");
        require(roundInfos[1].active == true, "presale-err: no active round");
        this; 
    }

    /**
     * @dev Claim tokens after ICO.
     */
    function claimTokens() external {
        require(block.timestamp > 1649894400, "presale-err: can claim after Apr 14 2022 UTC");
        require(roundInfos[1].active == false, "presale-err: ICO is not finished yet");
        require(claimableAmounts[msg.sender] > 0, "presale-err: no token to claim");

        claimableAmounts[msg.sender] = 0;
        cnt.safeTransfer(msg.sender, claimableAmounts[msg.sender]);
    }

    /**
     * @dev Withdraw busd or cnt token from this contract.
     */
    function withdrawTokens(address _token) external onlyOwner {
        IERC20(_token).safeTransfer(wallet, IERC20(_token).balanceOf(address(this)));
    }

    /**
     * @dev Set referral percent on referral level.
     */
    function setReferralPercent(uint8 _referralLV, uint256 _refPercent) external onlyOwner {
        require(_referralLV < 4, "presale-err: referralLV should be less than 4");
        require(_refPercent < 1000, "presale-err: refPercent should be less than 10%");
        
        REFERRAL_PERCENTS[_referralLV] = _refPercent;
    }

    /**
     * @dev Set wallet to withdraw.
     */
    function setWalletReceiver(address _newWallet) external onlyOwner {
        wallet = _newWallet;
    }
}