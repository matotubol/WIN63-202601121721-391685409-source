package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.CategoriesWithVisitorCountEventParser;
   
   [SecureSWF(rename="true")]
   public class CategoriesWithVisitorCountEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CategoriesWithVisitorCountEvent(param1:Function)
      {
         super(param1,CategoriesWithVisitorCountEventParser);
      }
      
      public function getParser() : CategoriesWithVisitorCountEventParser
      {
         return this.var_15 as CategoriesWithVisitorCountEventParser;
      }
   }
}

