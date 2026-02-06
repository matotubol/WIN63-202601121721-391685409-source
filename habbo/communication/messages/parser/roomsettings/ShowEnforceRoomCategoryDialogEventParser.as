package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ShowEnforceRoomCategoryDialogEventParser implements IMessageParser
   {
      
      private var var_4395:int;
      
      public function ShowEnforceRoomCategoryDialogEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4395 = param1.readInteger();
         return true;
      }
      
      public function get selectionType() : int
      {
         return var_4395;
      }
   }
}

