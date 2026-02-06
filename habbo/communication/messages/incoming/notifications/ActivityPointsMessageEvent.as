package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.parser.notifications.ActivityPointsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ActivityPointsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ActivityPointsMessageEvent(param1:Function)
      {
         super(param1,ActivityPointsMessageEventParser);
      }
      
      public function get points() : Dictionary
      {
         return (var_15 as ActivityPointsMessageEventParser).points;
      }
   }
}

