package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.avatar.WardrobeMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class WardrobeMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_825:int = 0;
      
      public static const const_573:int = 1;
      
      public function WardrobeMessageEvent(param1:Function)
      {
         super(param1,WardrobeMessageEventParser);
      }
      
      private function getParser() : WardrobeMessageEventParser
      {
         return this.var_15 as WardrobeMessageEventParser;
      }
      
      public function get outfits() : Array
      {
         return getParser().outfits;
      }
      
      public function get state() : int
      {
         return getParser().state;
      }
   }
}

