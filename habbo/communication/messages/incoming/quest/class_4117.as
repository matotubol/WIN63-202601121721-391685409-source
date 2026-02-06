package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4117 implements class_4116
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_975:String;
      
      private var var_4726:int;
      
      private var var_4321:int;
      
      public function class_4117(param1:IMessageDataWrapper)
      {
         super();
         var_1270 = param1.readInteger();
         _userName = param1.readString();
         var_975 = param1.readString();
         var_4726 = param1.readInteger();
         var_4321 = param1.readInteger();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get rank() : int
      {
         return var_4726;
      }
      
      public function get currentScore() : int
      {
         return var_4321;
      }
   }
}

