package com.sulake.habbo.communication.messages.incoming.mysterybox
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.mysterybox.MysteryBoxKeysMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class MysteryBoxKeysMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MysteryBoxKeysMessageEvent(param1:Function)
      {
         super(param1,MysteryBoxKeysMessageEventParser);
      }
      
      public function getParser() : MysteryBoxKeysMessageEventParser
      {
         return var_15 as MysteryBoxKeysMessageEventParser;
      }
   }
}

