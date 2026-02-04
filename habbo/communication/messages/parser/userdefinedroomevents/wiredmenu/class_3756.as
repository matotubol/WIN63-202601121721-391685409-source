package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class class_3756 implements IMessageParser
   {
      
      private var var_858:int;
      
      private var var_766:int;
      
      private var var_846:String;
      
      public function class_3756()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_858 = 0;
         var_766 = 0;
         var_846 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_858 = param1.readInteger();
         var_766 = param1.readInteger();
         var_846 = param1.readString();
         return true;
      }
      
      public function get modifyPermissionMask() : int
      {
         return var_858;
      }
      
      public function get readPermissionMask() : int
      {
         return var_766;
      }
      
      public function get timezone() : String
      {
         return var_846;
      }
   }
}

