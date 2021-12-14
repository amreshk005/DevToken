// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;



interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// Define our DevToken smart contract. 
contract DevToken {
  

  /**    * notice Our Tokens required variables that are needed to operate everything*/

  uint private _totalSupply;
  uint8 private _decimals;
  string private _symbol;
  string private _name;

  /**
  * notice _balances is a mapping that contains a address as KEY 
  * and the balance of the address as the value
  */


  mapping (address => uint256) private _balances;

  /**
  * notice Events are created below.
  * Transfer event is a event that notify the blockchain that a transfer of assets has taken place
  *
  */


  event Transfer(address indexed from, address indexed to, uint256 value);


  /**
  * notice constructor will be triggered when we create the Smart contract
  * _name = name of the token
  * _short_symbol = Short Symbol name for the token
  * token_decimals = The decimal precision of the Token, defaults 18
  * _totalSupply is how much Tokens there are totally 
  */

  // Constructor is a function that will run when the Token is created.
  constructor(string memory token_name, string memory short_symbol, uint8 token_decimals, uint256 token_totalSupply) {
    _name = token_name;
    _symbol = short_symbol;
    _decimals = token_decimals;
    _totalSupply = token_totalSupply;

    // Add all the tokens created to the creator of the token 
    _balances[msg.sender] = _totalSupply;

    //Emit an Transfer event to notify the blockchain that an Transfer has occured
    emit Transfer(address(0), msg.sender, _totalSupply);
  }


  /**
  * notice decimals will return the number of decimal precision the Token is deployed with
  */
  function decimals() external view returns (uint8) {
    return _decimals;
  }

   /**
  * notice symbol will return the Token's symbol 
  */
  function symbol() external view returns (string memory) {
    return _symbol;
  }

  /**
  * notice name will return the Token's symbol 
  */

  function name() external view returns (string memory){
    return _name;
  }

   /**
  * notice totalSupply will return the tokens total supply of tokens
  */

  function totalSupply() external view returns (uint256){
    return _totalSupply;
  }

   /**
  * @notice mint will create tokens on the address inputted and then increase the total supply
  *
  * It will also emit an Transfer event, with sender set to zero address (adress(0))
  * 
  * Requires that the address that is recieveing the tokens is not zero address
  */

  function mint(address account,uint256 amount) public {
    require(account != address(0), "DevToken: cannot mint to zero address");

    //Increase total supply
    _totalSupply = _totalSupply + (amount);
    //Add amount to the account balance using the balance mapping
    _balances[account] = _balances[account] + amount;
    //Emit our event to log the action
    emit Transfer(address(0), account, amount);
  }

    /**
  * @notice burn will destroy tokens from an address inputted and then decrease total supply
  * An Transfer event will emit with receiever set to zero address
  * 
  * Requires 
  * - Account cannot be zero
  * - Account balance has to be bigger or equal to amount
  */

  function burn(address account, uint256 amount) public {
    require(account != address(0), "DevToken: cannot burn from zero address");
    require(_balances[account] >= amount, "DevToken: Cannot burn more than the account owns");

    //Remove the amount from the account balance
    _balances[account] = _balances[account] - amount;
    //Decrease totalSupply
    _totalSupply = _totalSupply - amount;
    //Emit event, use zero address as reciever
    emit Transfer(account, address(0), amount);
  }
}