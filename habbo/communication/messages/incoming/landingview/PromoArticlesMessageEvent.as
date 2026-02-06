package com.sulake.habbo.communication.messages.incoming.landingview
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.landingview.PromoArticlesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PromoArticlesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PromoArticlesMessageEvent(param1:Function)
      {
         super(param1,PromoArticlesMessageEventParser);
      }
      
      public function getParser() : PromoArticlesMessageEventParser
      {
         return var_15 as PromoArticlesMessageEventParser;
      }
   }
}

