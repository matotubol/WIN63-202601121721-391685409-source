package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4089
   {
      
      private var var_4785:int;
      
      private var var_4943:String;
      
      private var var_191:String;
      
      private var var_4605:int;
      
      private var var_5059:Number;
      
      public function class_4089(param1:IMessageDataWrapper)
      {
         super();
         var_4785 = param1.readInteger();
         var_4943 = param1.readString();
         var_191 = param1.readString();
         var_4605 = param1.readInteger();
         var_5059 = param1.readLong();
      }
      
      public function get errorId() : int
      {
         return var_4785;
      }
      
      public function get errorName() : String
      {
         return var_4943;
      }
      
      public function get category() : String
      {
         return var_191;
      }
      
      public function get throwCount() : int
      {
         return var_4605;
      }
      
      public function get msSinceLastOccurrence() : Number
      {
         return var_5059;
      }
   }
}

