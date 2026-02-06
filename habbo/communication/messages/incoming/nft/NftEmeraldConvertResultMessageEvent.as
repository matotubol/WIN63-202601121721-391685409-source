package com.sulake.habbo.communication.messages.incoming.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nft.NftEmeraldConvertResultMessageEventParser;
   
   public class NftEmeraldConvertResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NftEmeraldConvertResultMessageEvent(param1:Function)
      {
         super(param1,NftEmeraldConvertResultMessageEventParser);
      }
      
      public function getParser() : NftEmeraldConvertResultMessageEventParser
      {
         return var_15 as NftEmeraldConvertResultMessageEventParser;
      }
   }
}

