package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredClickUserResponseEventParser implements IMessageParser
   {
      
      private var _index:int;
      
      private var var_2817:Boolean;
      
      public function WiredClickUserResponseEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _index = 0;
         var_2817 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _index = param1.readInteger();
         var_2817 = param1.readBoolean();
         return true;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get openMenu() : Boolean
      {
         return var_2817;
      }
   }
}

