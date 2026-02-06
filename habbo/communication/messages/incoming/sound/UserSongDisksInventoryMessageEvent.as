package com.sulake.habbo.communication.messages.incoming.sound
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.sound.UserSongDisksInventoryMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserSongDisksInventoryMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserSongDisksInventoryMessageEvent(param1:Function)
      {
         super(param1,UserSongDisksInventoryMessageEventParser);
      }
      
      public function getParser() : UserSongDisksInventoryMessageEventParser
      {
         return this.var_15 as UserSongDisksInventoryMessageEventParser;
      }
   }
}

