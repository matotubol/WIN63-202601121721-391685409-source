package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class class_3781 implements IMessageParser
   {
      
      public static var var_5342:int = 0;
      
      public static var var_5407:int = 1;
      
      public static var var_5381:int = 2;
      
      private var var_2759:int;
      
      public function class_3781()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2759 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2759 = param1.readShort();
         return true;
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
   }
}

