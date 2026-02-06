package com.sulake.habbo.communication.messages.incoming.mysterybox
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.mysterybox.GotMysteryBoxPrizeMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GotMysteryBoxPrizeMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GotMysteryBoxPrizeMessageEvent(param1:Function)
      {
         super(param1,GotMysteryBoxPrizeMessageEventParser);
      }
      
      public function getParser() : GotMysteryBoxPrizeMessageEventParser
      {
         return var_15 as GotMysteryBoxPrizeMessageEventParser;
      }
   }
}

