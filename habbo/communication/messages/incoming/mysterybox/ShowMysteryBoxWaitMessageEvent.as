package com.sulake.habbo.communication.messages.incoming.mysterybox
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.mysterybox.ShowMysteryBoxWaitMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ShowMysteryBoxWaitMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ShowMysteryBoxWaitMessageEvent(param1:Function)
      {
         super(param1,ShowMysteryBoxWaitMessageEventParser);
      }
      
      public function getParser() : ShowMysteryBoxWaitMessageEventParser
      {
         return var_15 as ShowMysteryBoxWaitMessageEventParser;
      }
   }
}

