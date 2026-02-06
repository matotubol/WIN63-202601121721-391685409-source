package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_1846
   {
      
      public static const TYPE_REGULAR:int = 0;
      
      public static const TYPE_EXCLUSIVE:int = 1;
      
      public static const const_68:int = 2;
      
      public static const TYPE_LARGE:int = 3;
      
      public static const const_73:int = 4;
      
      public static const const_685:int = 0;
      
      public static const const_630:int = 1;
      
      public static const name_7:int = 2;
      
      private var _groupId:int;
      
      private var var_3507:Boolean;
      
      private var var_230:int;
      
      private var _groupName:String;
      
      private var var_735:String;
      
      private var var_2806:String;
      
      private var var_1951:int = -1;
      
      private var _roomName:String = "";
      
      private var _status:int;
      
      private var var_4110:int;
      
      private var var_5061:Boolean;
      
      private var var_3921:String;
      
      private var var_3219:Boolean;
      
      private var _isAdmin:Boolean;
      
      private var _ownerName:String;
      
      private var var_3942:Boolean;
      
      private var var_3860:Boolean;
      
      private var var_4540:Boolean;
      
      private var var_4949:int;
      
      public function class_1846(param1:IMessageDataWrapper)
      {
         super();
         _groupId = param1.readInteger();
         var_3507 = param1.readBoolean();
         var_230 = param1.readInteger();
         _groupName = param1.readString();
         var_735 = param1.readString();
         var_2806 = param1.readString();
         var_1951 = param1.readInteger();
         _roomName = param1.readString();
         _status = param1.readInteger();
         var_4110 = param1.readInteger();
         var_5061 = param1.readBoolean();
         var_3921 = param1.readString();
         var_3219 = param1.readBoolean();
         _isAdmin = param1.readBoolean();
         _ownerName = param1.readString();
         var_3942 = param1.readBoolean();
         var_4540 = param1.readBoolean();
         var_4949 = param1.readInteger();
         var_3860 = param1.readBoolean();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get isGuild() : Boolean
      {
         return var_3507;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get totalMembers() : int
      {
         return var_4110;
      }
      
      public function get favourite() : Boolean
      {
         return var_5061;
      }
      
      public function get creationDate() : String
      {
         return var_3921;
      }
      
      public function get isOwner() : Boolean
      {
         return var_3219;
      }
      
      public function get isAdmin() : Boolean
      {
         return _isAdmin;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get openDetails() : Boolean
      {
         return var_3942;
      }
      
      public function get membersCanDecorate() : Boolean
      {
         return var_4540;
      }
      
      public function get pendingMemberCount() : int
      {
         return var_4949;
      }
      
      public function get hasBoard() : Boolean
      {
         return var_3860;
      }
      
      public function get joiningAllowed() : Boolean
      {
         return _status == 0 && (var_230 == 0 || var_230 == 4);
      }
      
      public function get requestMembershipAllowed() : Boolean
      {
         return _status == 0 && var_230 == 1;
      }
      
      public function get leaveAllowed() : Boolean
      {
         return var_3507 && !var_3219 && _status == 1;
      }
   }
}

