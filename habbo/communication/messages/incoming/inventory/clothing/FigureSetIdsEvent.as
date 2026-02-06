package com.sulake.habbo.communication.messages.incoming.inventory.clothing
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.clothing.FigureSetIdsEventParser;
   
   [SecureSWF(rename="true")]
   public class FigureSetIdsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FigureSetIdsEvent(param1:Function)
      {
         super(param1,FigureSetIdsEventParser);
      }
      
      public function getParser() : FigureSetIdsEventParser
      {
         return var_15 as FigureSetIdsEventParser;
      }
   }
}

