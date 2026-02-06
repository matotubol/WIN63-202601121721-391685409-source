package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.avatar.FigureUpdateEventParser;
   
   [SecureSWF(rename="true")]
   public class FigureUpdateEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FigureUpdateEvent(param1:Function)
      {
         super(param1,FigureUpdateEventParser);
      }
      
      private function getParser() : FigureUpdateEventParser
      {
         return this.var_15 as FigureUpdateEventParser;
      }
      
      public function get figure() : String
      {
         return (var_15 as FigureUpdateEventParser).figure;
      }
      
      public function get gender() : String
      {
         return (var_15 as FigureUpdateEventParser).gender;
      }
   }
}

