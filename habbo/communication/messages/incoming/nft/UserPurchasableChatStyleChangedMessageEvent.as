package com.sulake.habbo.communication.messages.incoming.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nft.UserPurchasableChatStyleChangedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserPurchasableChatStyleChangedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserPurchasableChatStyleChangedMessageEvent(param1:Function)
      {
         super(param1,UserPurchasableChatStyleChangedMessageEventParser);
      }
      
      public function getParser() : UserPurchasableChatStyleChangedMessageEventParser
      {
         return var_15 as UserPurchasableChatStyleChangedMessageEventParser;
      }
   }
}

