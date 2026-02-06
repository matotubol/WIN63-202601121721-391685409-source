package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_1819 implements class_1818
   {
      
      private var var_3508:Array;
      
      private var var_3219:Boolean;
      
      private var _groupId:int;
      
      private var _groupName:String;
      
      private var var_4021:String;
      
      private var var_4458:int;
      
      private var var_4501:int;
      
      private var var_4768:int;
      
      private var var_1613:Boolean;
      
      private var var_989:String;
      
      private var var_2266:int;
      
      private var var_4176:int;
      
      private var var_3661:Array;
      
      private var var_2806:String;
      
      private var var_4550:int;
      
      public function class_1819(param1:IMessageDataWrapper)
      {
         super();
         var_3508 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         var_3219 = param1.readBoolean();
         _groupId = param1.readInteger();
         _groupName = param1.readString();
         var_4021 = param1.readString();
         var_4458 = param1.readInteger();
         var_4501 = param1.readInteger();
         var_4768 = param1.readInteger();
         var_2266 = param1.readInteger();
         var_4176 = param1.readInteger();
         var_1613 = param1.readBoolean();
         var_989 = param1.readString();
         var_3661 = [];
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         var_2806 = param1.readString();
         var_4550 = param1.readInteger();
      }
      
      public function get ownedRooms() : Array
      {
         return var_3508;
      }
      
      public function get exists() : Boolean
      {
         return true;
      }
      
      public function get isOwner() : Boolean
      {
         return var_3219;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get groupDesc() : String
      {
         return var_4021;
      }
      
      public function get baseRoomId() : int
      {
         return var_4458;
      }
      
      public function get primaryColorId() : int
      {
         return var_4501;
      }
      
      public function get secondaryColorId() : int
      {
         return var_4768;
      }
      
      public function get badgeSettings() : Array
      {
         return var_3661;
      }
      
      public function get locked() : Boolean
      {
         return var_1613;
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function get guildType() : int
      {
         return var_2266;
      }
      
      public function get guildRightsLevel() : int
      {
         return var_4176;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
      
      public function get membershipCount() : int
      {
         return var_4550;
      }
   }
}

