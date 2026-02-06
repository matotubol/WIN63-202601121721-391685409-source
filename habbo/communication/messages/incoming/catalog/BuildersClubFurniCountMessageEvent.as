package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubFurniCountMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubFurniCountMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BuildersClubFurniCountMessageEvent(param1:Function)
      {
         super(param1,BuildersClubFurniCountMessageEventParser);
      }
      
      public function getParser() : BuildersClubFurniCountMessageEventParser
      {
         return this.var_15 as BuildersClubFurniCountMessageEventParser;
      }
   }
}

