package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.SlideObjectBundleMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class SlideObjectBundleMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SlideObjectBundleMessageEvent(param1:Function)
      {
         super(param1,SlideObjectBundleMessageEventParser);
      }
      
      public function getParser() : SlideObjectBundleMessageEventParser
      {
         return var_15 as SlideObjectBundleMessageEventParser;
      }
   }
}

