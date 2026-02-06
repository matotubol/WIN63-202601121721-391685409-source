package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.NavigatorSettingsEventParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorSettingsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NavigatorSettingsEvent(param1:Function)
      {
         super(param1,NavigatorSettingsEventParser);
      }
      
      public function getParser() : NavigatorSettingsEventParser
      {
         return this.var_15 as NavigatorSettingsEventParser;
      }
   }
}

