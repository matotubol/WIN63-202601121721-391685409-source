package com.sulake.habbo.communication.messages.incoming.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nft.UserNftWardrobeSelectionMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserNftWardrobeSelectionMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserNftWardrobeSelectionMessageEvent(param1:Function)
      {
         super(param1,UserNftWardrobeSelectionMessageEventParser);
      }
      
      public function getParser() : UserNftWardrobeSelectionMessageEventParser
      {
         return var_15 as UserNftWardrobeSelectionMessageEventParser;
      }
   }
}

