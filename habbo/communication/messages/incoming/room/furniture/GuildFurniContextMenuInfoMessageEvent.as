package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.GuildFurniContextMenuInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildFurniContextMenuInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildFurniContextMenuInfoMessageEvent(param1:Function)
      {
         super(param1,GuildFurniContextMenuInfoMessageEventParser);
      }
      
      public function getParser() : GuildFurniContextMenuInfoMessageEventParser
      {
         return var_15 as GuildFurniContextMenuInfoMessageEventParser;
      }
   }
}

