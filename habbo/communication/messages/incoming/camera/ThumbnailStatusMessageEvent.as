package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.ThumbnailStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ThumbnailStatusMessageEvent extends MessageEvent
   {
      
      public function ThumbnailStatusMessageEvent(param1:Function)
      {
         super(param1,ThumbnailStatusMessageEventParser);
      }
      
      public function getParser() : ThumbnailStatusMessageEventParser
      {
         return this.var_15 as ThumbnailStatusMessageEventParser;
      }
   }
}

