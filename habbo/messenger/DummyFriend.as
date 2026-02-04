package com.sulake.habbo.messenger
{
   import com.sulake.habbo.friendlist.class_1927;
   
   public class DummyFriend implements class_1927
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_975:String;
      
      public function DummyFriend(param1:int, param2:String, param3:String)
      {
         super();
         var_1270 = param1;
         _userName = param2;
         var_975 = param3;
      }
      
      public function get id() : int
      {
         return var_1270;
      }
      
      public function get name() : String
      {
         return _userName;
      }
      
      public function get gender() : int
      {
         return 0;
      }
      
      public function get online() : Boolean
      {
         return true;
      }
      
      public function get followingAllowed() : Boolean
      {
         return true;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get realName() : String
      {
         return "";
      }
      
      public function get persistedMessageUser() : Boolean
      {
         return true;
      }
      
      public function get pocketHabboUser() : Boolean
      {
         return false;
      }
      
      public function get relationshipStatus() : int
      {
         return 0;
      }
   }
}

