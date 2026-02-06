package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredAllVariablesHashEventParser implements IMessageParser
   {
      
      private var var_3003:int;
      
      public function WiredAllVariablesHashEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3003 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3003 = param1.readInteger();
         return true;
      }
      
      public function get allVariablesHash() : int
      {
         return var_3003;
      }
   }
}

