package com.sulake.habbo.friendbar.data
{
   public class FriendEntity implements class_3462
   {
      
      private static var ROLLING_LOG_EVENT_ID:int = 0;
      
      private var var_197:int;
      
      private var _name:String;
      
      private var var_111:int;
      
      private var var_3279:Boolean;
      
      private var _allowFollow:Boolean;
      
      private var var_975:String;
      
      private var var_2851:int;
      
      private var var_3144:String;
      
      private var var_2995:String;
      
      private var _realName:String;
      
      private var _notifications:Vector.<class_2307>;
      
      private var var_5055:int = -1;
      
      public function FriendEntity(param1:int, param2:String, param3:String, param4:String, param5:int, param6:Boolean, param7:Boolean, param8:String, param9:int, param10:String)
      {
         super();
         var_197 = param1;
         _name = param2;
         _realName = param3;
         var_3144 = param4;
         var_111 = param5;
         var_3279 = param6;
         _allowFollow = param7;
         var_975 = param8;
         var_2851 = param9;
         var_2995 = param10;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get gender() : int
      {
         return var_111;
      }
      
      public function get online() : Boolean
      {
         return var_3279;
      }
      
      public function get allowFollow() : Boolean
      {
         return _allowFollow;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function get motto() : String
      {
         return var_3144;
      }
      
      public function get lastAccess() : String
      {
         return var_2995;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get logEventId() : int
      {
         return var_5055;
      }
      
      public function get notifications() : Vector.<class_2307>
      {
         if(!_notifications)
         {
            _notifications = new Vector.<class_2307>();
         }
         return _notifications;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set gender(param1:int) : void
      {
         var_111 = param1;
      }
      
      public function set online(param1:Boolean) : void
      {
         var_3279 = param1;
      }
      
      public function set allowFollow(param1:Boolean) : void
      {
         _allowFollow = param1;
      }
      
      public function set figure(param1:String) : void
      {
         var_975 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_2851 = param1;
      }
      
      public function set motto(param1:String) : void
      {
         var_3144 = param1;
      }
      
      public function set lastAccess(param1:String) : void
      {
         var_2995 = param1;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function set logEventId(param1:int) : void
      {
         var_5055 = param1;
      }
      
      public function getNextLogEventId() : int
      {
         return ++ROLLING_LOG_EVENT_ID;
      }
   }
}

