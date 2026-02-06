package com.sulake.habbo.communication.messages.incoming.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nft.UserPurchasableChatStylesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserPurchasableChatStylesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserPurchasableChatStylesMessageEvent(param1:Function)
      {
         super(param1,UserPurchasableChatStylesMessageEventParser);
      }
      
      public function getParser() : UserPurchasableChatStylesMessageEventParser
      {
         return var_15 as UserPurchasableChatStylesMessageEventParser;
      }
   }
}

