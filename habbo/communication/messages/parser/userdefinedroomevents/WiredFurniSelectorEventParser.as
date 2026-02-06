package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition;
   
   public class WiredFurniSelectorEventParser implements IMessageParser
   {
      
      private var var_2680:SelectorDefinition;
      
      public function WiredFurniSelectorEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2680 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2680 = new SelectorDefinition(param1);
         return true;
      }
      
      public function get def() : SelectorDefinition
      {
         return var_2680;
      }
   }
}

