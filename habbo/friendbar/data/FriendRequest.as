package com.sulake.habbo.friendbar.data
{
   public class FriendRequest implements class_3380
   {
      
      private var var_197:int;
      
      private var _name:String;
      
      private var var_975:String;
      
      public function FriendRequest(param1:int, param2:String, param3:String)
      {
         super();
         var_197 = param1;
         _name = param2;
         var_975 = param3;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
   }
}

