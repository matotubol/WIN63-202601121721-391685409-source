package com.sulake.habbo.communication.messages.incoming.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nft.UserNftWardrobeMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserNftWardrobeMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserNftWardrobeMessageEvent(param1:Function)
      {
         super(param1,UserNftWardrobeMessageEventParser);
      }
      
      public function getParser() : UserNftWardrobeMessageEventParser
      {
         return var_15 as UserNftWardrobeMessageEventParser;
      }
   }
}

