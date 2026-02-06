package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.FavouritesEventParser;
   
   [SecureSWF(rename="true")]
   public class FavouritesEvent extends MessageEvent implements IMessageEvent
   {
      
      public function FavouritesEvent(param1:Function)
      {
         super(param1,FavouritesEventParser);
      }
      
      public function getParser() : FavouritesEventParser
      {
         return this.var_15 as FavouritesEventParser;
      }
   }
}

