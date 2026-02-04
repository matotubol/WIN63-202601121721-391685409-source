package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_97.WiredObjectInspectionData;
   
   public class class_3676 implements IMessageParser
   {
      
      private var var_24:WiredObjectInspectionData;
      
      public function class_3676()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_24 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new WiredObjectInspectionData(param1);
         return true;
      }
      
      public function get data() : WiredObjectInspectionData
      {
         return var_24;
      }
   }
}

