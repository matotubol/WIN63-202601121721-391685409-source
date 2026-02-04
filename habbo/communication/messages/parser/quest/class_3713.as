package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3713 implements IMessageParser
   {
      
      private var var_3107:String;
      
      public function class_3713()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3107 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3107 = param1.readString();
         return true;
      }
      
      public function get imageUri() : String
      {
         return var_3107;
      }
   }
}

