package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.ShowEnforceRoomCategoryDialogEventParser;
   
   [SecureSWF(rename="true")]
   public class ShowEnforceRoomCategoryDialogEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ShowEnforceRoomCategoryDialogEvent(param1:Function)
      {
         super(param1,ShowEnforceRoomCategoryDialogEventParser);
      }
      
      public function getParser() : ShowEnforceRoomCategoryDialogEventParser
      {
         return this.var_15 as ShowEnforceRoomCategoryDialogEventParser;
      }
   }
}

