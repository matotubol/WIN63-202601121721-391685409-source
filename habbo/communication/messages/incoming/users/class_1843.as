package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_1843 implements class_1818
   {
      
      private var var_5071:int;
      
      private var var_3508:Array;
      
      private var var_3661:Array;
      
      public function class_1843(param1:IMessageDataWrapper)
      {
         super();
         var_5071 = param1.readInteger();
         var_3508 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         _loc2_ = param1.readInteger();
         var_3661 = [];
         _loc3_ = 0;
      }
      
      public function get costInCredits() : int
      {
         return var_5071;
      }
      
      public function get ownedRooms() : Array
      {
         return var_3508;
      }
      
      public function get exists() : Boolean
      {
         return false;
      }
      
      public function get isOwner() : Boolean
      {
         return true;
      }
      
      public function get groupId() : int
      {
         return 0;
      }
      
      public function get groupName() : String
      {
         return "";
      }
      
      public function get groupDesc() : String
      {
         return "";
      }
      
      public function get baseRoomId() : int
      {
         return 0;
      }
      
      public function get primaryColorId() : int
      {
         return 0;
      }
      
      public function get secondaryColorId() : int
      {
         return 0;
      }
      
      public function get badgeSettings() : Array
      {
         return var_3661;
      }
      
      public function get locked() : Boolean
      {
         return false;
      }
      
      public function get url() : String
      {
         return "";
      }
      
      public function get guildType() : int
      {
         return 0;
      }
      
      public function get guildRightsLevel() : int
      {
         return 0;
      }
      
      public function get badgeCode() : String
      {
         return "";
      }
      
      public function get membershipCount() : int
      {
         return 0;
      }
   }
}

