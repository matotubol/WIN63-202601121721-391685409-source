package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_1893
   {
      
      private static const const_335:int = 0;
      
      private static const const_785:int = 1;
      
      private static const const_734:int = 2;
      
      private static const const_1217:int = 3;
      
      private static const const_300:int = 4;
      
      private var var_230:int;
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_975:String;
      
      private var var_4244:String;
      
      public function class_1893(param1:IMessageDataWrapper)
      {
         super();
         var_230 = param1.readInteger();
         var_1270 = param1.readInteger();
         _userName = param1.readString();
         var_975 = param1.readString();
         var_4244 = param1.readString();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get admin() : Boolean
      {
         return var_230 == 1;
      }
      
      public function get owner() : Boolean
      {
         return var_230 == 0;
      }
      
      public function get member() : Boolean
      {
         return var_230 != 3;
      }
      
      public function get blocked() : Boolean
      {
         return var_230 == 4;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get memberSince() : String
      {
         return var_4244;
      }
   }
}

