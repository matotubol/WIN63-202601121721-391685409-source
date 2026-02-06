package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredPermissionsEventParser implements IMessageParser
   {
      
      private var var_2782:Boolean;
      
      private var var_3124:Boolean;
      
      public function WiredPermissionsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2782 = false;
         var_3124 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2782 = param1.readBoolean();
         var_3124 = param1.readBoolean();
         return true;
      }
      
      public function get canModify() : Boolean
      {
         return var_2782;
      }
      
      public function get canRead() : Boolean
      {
         return var_3124;
      }
   }
}

