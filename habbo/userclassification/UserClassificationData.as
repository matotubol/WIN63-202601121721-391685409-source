package com.sulake.habbo.userclassification
{
   public class UserClassificationData
   {
      
      public static var var_5405:uint = 1;
      
      public static var var_5375:uint = 2;
      
      public static var var_5387:uint = 3;
      
      public static var PAYING_USER_CLASSIFICATION:uint = 4;
      
      private var var_1270:int;
      
      private var _username:String;
      
      private var var_3537:String;
      
      public function UserClassificationData(param1:int, param2:String, param3:String)
      {
         super();
         var_1270 = param1;
         _username = param2;
         var_3537 = param3;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get username() : String
      {
         return _username;
      }
      
      public function get classType() : String
      {
         return var_3537;
      }
      
      public function toString() : String
      {
         return "[" + var_1270 + ", " + _username + "] [" + var_3537 + "]";
      }
   }
}

