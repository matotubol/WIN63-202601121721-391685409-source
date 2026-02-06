package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4056
   {
      
      private var var_3913:String;
      
      public function class_4056(param1:IMessageDataWrapper)
      {
         super();
         var_3913 = param1.readString();
      }
      
      public function get perkId() : String
      {
         return var_3913;
      }
   }
}

