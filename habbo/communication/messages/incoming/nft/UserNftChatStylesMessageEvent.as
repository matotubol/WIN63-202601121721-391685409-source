package com.sulake.habbo.communication.messages.incoming.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nft.UserNftChatStylesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserNftChatStylesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserNftChatStylesMessageEvent(param1:Function)
      {
         super(param1,UserNftChatStylesMessageEventParser);
      }
      
      public function getParser() : UserNftChatStylesMessageEventParser
      {
         return var_15 as UserNftChatStylesMessageEventParser;
      }
   }
}

