package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_188.VariableInfoAndHolders;
   
   public class class_3711 implements IMessageParser
   {
      
      private var var_3373:VariableInfoAndHolders;
      
      public function class_3711()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3373 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         param1.readInteger();
         var_3373 = new VariableInfoAndHolders(param1);
         return true;
      }
      
      public function get variableInfoAndHolders() : VariableInfoAndHolders
      {
         return var_3373;
      }
   }
}

