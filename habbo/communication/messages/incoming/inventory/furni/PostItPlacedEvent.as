package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.PostItPlacedEventParser;
   
   [SecureSWF(rename="true")]
   public class PostItPlacedEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PostItPlacedEvent(param1:Function)
      {
         super(param1,PostItPlacedEventParser);
      }
      
      public function getParser() : PostItPlacedEventParser
      {
         return this.var_15 as PostItPlacedEventParser;
      }
   }
}

