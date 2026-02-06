package com.sulake.habbo.communication.messages.incoming.sound
{
   [SecureSWF(rename="true")]
   public class class_3136
   {
      
      protected var var_2766:int;
      
      protected var var_3754:int;
      
      protected var _songName:String;
      
      protected var var_3592:String;
      
      private var var_4278:Number = 0;
      
      public function class_3136(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         var_2766 = param1;
         var_3754 = param2;
         _songName = param3;
         var_3592 = param4;
      }
      
      public function get id() : int
      {
         return var_2766;
      }
      
      public function get length() : int
      {
         return var_3754;
      }
      
      public function get name() : String
      {
         return _songName;
      }
      
      public function get creator() : String
      {
         return var_3592;
      }
      
      public function get startPlayHeadPos() : Number
      {
         return var_4278;
      }
      
      public function set startPlayHeadPos(param1:Number) : void
      {
         var_4278 = param1;
      }
   }
}

