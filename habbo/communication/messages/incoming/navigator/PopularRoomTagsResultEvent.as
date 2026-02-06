package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.PopularRoomTagsResultEventParser;
   
   [SecureSWF(rename="true")]
   public class PopularRoomTagsResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PopularRoomTagsResultEvent(param1:Function)
      {
         super(param1,PopularRoomTagsResultEventParser);
      }
      
      public function getParser() : PopularRoomTagsResultEventParser
      {
         return this.var_15 as PopularRoomTagsResultEventParser;
      }
   }
}

