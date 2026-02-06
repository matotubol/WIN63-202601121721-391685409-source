package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3878
   {
      
      private var var_2711:String;
      
      private var var_5109:int;
      
      public function class_3878(param1:IMessageDataWrapper)
      {
         super();
         var_2711 = param1.readString();
         var_5109 = param1.readInteger();
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get vipDays() : int
      {
         return var_5109;
      }
   }
}

