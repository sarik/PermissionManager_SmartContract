pragma solidity ^0.5.2;

contract ManagePermissions{
    
    /**
     * Defining mapping from address1 to address2 to boolean
     * Tells if address1 has granted permission to address2
     */
    mapping (address => mapping(address => bool)) permissions;
    
    /*
    assuming caller is never required to grant permission to its own address
    */
    modifier checkNotOwnAddress(address _add){
        require(_add != msg.sender);
        _;
    }
    
    /**
     * gives ability to caller to give or revoke permission to an address.
     * @param _add Address whom to grant or revoke permission to by the caller
     * @param _action true to grant permission,false to revoke permission
     */
    function grantORRevokePermissionToAddress(address _add ,bool _action) public checkNotOwnAddress(_add) returns(bool){
      //giving an if to prevent write in case permission already set
       if(permissions[msg.sender][_add] != _action)
         permissions[msg.sender][_add] = _action;
         
       if( permissions[msg.sender][_add] == _action)
          return true;
       else
          return false;
    }
    
    /**
     * gives ability to caller to see if already granted permission to an address.
     * @param _add Address under observation
     * NOTE:Checking self address will always return false as per our assumption
     */
    function checkPermissionForAddress(address _add) public view returns(bool){
        return permissions[msg.sender][_add];
    }
    
    /**
     * gives ability to caller to see if he has permission from an address.
     * @param _add Address under observation
     * NOTE:Checking self address will always return false as per our assumption
     */
    function checkPermissionFromAddress(address _add) public view returns(bool){
         return  permissions[_add][msg.sender];
    }
   
}

